import 'dart:convert';
import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import 'config/constants/api_constance.dart';
import 'config/constants/constance.dart';
import 'core/localization/localization_cubit.dart';
import 'core/services/api_services.dart';
import 'core/services/app_links_service.dart';
import 'core/services/cach_services.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'locator.dart';
import 'project/Home/cubit/home_cubit.dart';
import 'project/activities/cubit/cubit.dart';
import 'project/activities/view/screens/activity.dart';
import 'project/auth/cubit/auth_cubit.dart';
import 'project/auth/view/Screen/splash/luby_screen_splash.dart';
import 'project/favorites/cubit/cubit.dart';
import 'project/reservation/cubit/cubit.dart';
import 'project/reservation/view/screens/reservation_loader_screen.dart';
import 'project/screens/propreties/views/property_screen.dart';

// Must be a top-level or static function.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure Firebase is initialized in background isolate
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {}
  developer.log('BG message: ${message.messageId}', name: 'FCM');

  // Initialize local notifications in background isolate as needed
  const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
  const iosInit = DarwinInitializationSettings();
  const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
  await _flutterLocalNotificationsPlugin.initialize(initSettings);

  // Ensure channel exists
  final android =
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await android?.createNotificationChannel(_defaultAndroidChannel);

  final title = message.notification?.title ?? message.data['title']?.toString();
  final body = message.notification?.body ?? message.data['body']?.toString();

  if (title != null || body != null) {
    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _defaultAndroidChannel.id,
          _defaultAndroidChannel.name,
          channelDescription: _defaultAndroidChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: message.data.isNotEmpty ? jsonEncode(message.data) : null,
    );
  }
}

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _defaultAndroidChannel = AndroidNotificationChannel(
  'high_importance_channel', // must match AndroidManifest meta-data
  'High Importance Notifications',
  description: 'Used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

Future<void> _initLocalNotifications() async {
  const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
  const iosInit = DarwinInitializationSettings();
  const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
  await _flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payload = response.payload;
      if (payload == null || payload.isEmpty) return;
      try {
        final Map<String, dynamic> data = jsonDecode(payload) as Map<String, dynamic>;
        _handleNotificationNavigation(data);
      } catch (_) {}
    },
  );

  // Create Android channel
  final android =
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await android?.createNotificationChannel(_defaultAndroidChannel);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {}

  // Register background handler early
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize local notifications and ask for notification permissions
  await _initLocalNotifications();

  // On Android 13+, explicitly request notification permission via local notifications plugin
  final androidLn =
      _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  if (androidLn != null) {
    await androidLn.requestNotificationsPermission();
  }

  final messaging = FirebaseMessaging.instance;

  // iOS/macOS + Android 13+ runtime permission
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    announcement: false,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
  );

  // Set foreground presentation options for iOS/macOS
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  // Get and print FCM token (handle errors gracefully)
  String? fcmToken;
  try {
    fcmToken = await messaging.getToken();
    developer.log('FCM Token: $fcmToken', name: 'FCM');
    // ignore: avoid_print
    print('FCM Token: $fcmToken');
  } catch (e) {
    developer.log('Failed to get FCM token: $e', name: 'FCM');
    // Do not crash; proceed. Token may be retrieved later via onTokenRefresh.
  }

  // Listen to token refresh
  // Don't send it yet; wait until services are initialized below

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    developer.log('FCM Token refreshed: $newToken', name: 'FCM');
    await _updateFcmTokenIfLoggedIn(newToken);
  });

  // Foreground message handler: show local notification only; don't auto-navigate.
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    final notification = message.notification;
    final android = notification?.android;

    developer.log('FG message received: ${message.messageId}', name: 'FCM');

    // Show a local notification for foreground messages
    if (notification != null) {
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _defaultAndroidChannel.id,
            _defaultAndroidChannel.name,
            channelDescription: _defaultAndroidChannel.description,
            icon: android?.smallIcon ?? '@mipmap/launcher_icon',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.isNotEmpty ? jsonEncode(message.data) : null,
      );
    }
    // Do not navigate on foreground messages automatically to avoid surprising users
    // and accidental double navigations. Navigation is handled when the user taps
    // the notification (onMessageOpenedApp) or taps a displayed local notification
    // (onDidReceiveNotificationResponse).
  });

  // When the user taps a notification and the app opens
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    developer.log('Notification clicked. Data: ${message.data}', name: 'FCM');
    _handleNotificationNavigation(message.data);
  });

  // If the app was launched by tapping a notification (terminated state)
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    developer.log('App opened from terminated by notification: ${initialMessage.data}', name: 'FCM');
    // Defer handling until after MaterialApp builds and Navigator is ready
    _pendingInitialMessageData = initialMessage.data;
  }

  setup();
  await getIt<CacheService>().init();
  await getIt<ApiService>().init();
  // After services are ready, send initial token to backend if logged in
  if (fcmToken != null && fcmToken.isNotEmpty) {
    await _updateFcmTokenIfLoggedIn(fcmToken);
  }
  runApp(const MyApp());
}

Future<void> _updateFcmTokenIfLoggedIn(String token) async {
  try {
    final accessToken = getIt<CacheService>().storage.getString(AppConst.accessToken);
    if (accessToken == null || accessToken.isEmpty) return;
    await getIt<ApiService>().dio.post(ApiConstance.updateFcmToken, data: {'fcmToken': token});
  } catch (e) {
    developer.log('Failed to update FCM token: $e', name: 'FCM');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLinksService? _appLinksService;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pendingInitialMessageData != null && !_hasHandledInitialMessage) {
        _hasHandledInitialMessage = true;
        _handleNotificationNavigation(_pendingInitialMessageData!);
        _pendingInitialMessageData = null;
      }
      // Initialize deep links
      _appLinksService = AppLinksService(
        navigatorKey: navigatorKey,
        onRouteData: _handleNotificationNavigation,
        acceptedSchemes: const ['lubyuser', 'https'],
      );
      _appLinksService!.init();
    });
  }

  @override
  void dispose() {
    _appLinksService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<LocalizationCubit>()..loadSaved()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<ActivitiesCubit>()),
        BlocProvider(create: (context) => getIt<FavoritesCubit>()),
        BlocProvider(create: (context) => getIt<ReservationsCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LocalizationCubit, Locale?>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: true),
                navigatorKey: navigatorKey,
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en'), Locale('ar')],
                onGenerateTitle: (context) => context.l10n.appTitle,
                home: const LubyScreenSplash(),
              );
            },
          );
        },
      ),
    );
  }
}

// Global navigator key to allow navigation from notification callbacks
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Hold initial notification data until the Navigator is ready
Map<String, dynamic>? _pendingInitialMessageData;
bool _hasHandledInitialMessage = false;

// Simple debounce to avoid duplicate navigations from multiple sources (e.g.,
// local notification tap and onMessageOpenedApp firing close together).
DateTime? _lastNavAt;
String? _lastNavKey;

void _handleNotificationNavigation(Map<String, dynamic> data) {
  try {
    final type = (data['type'] ?? '').toString();
    final activityId = (data['activityId'] ?? '').toString();
    final propertyId = (data['propertyId'] ?? '').toString();
    final registrationId = (data['registrationId'] ?? '').toString();

    // Build a lightweight key for deduplication
    final navKey = '$type|$activityId|$propertyId|$registrationId';
    final now = DateTime.now();
    if (_lastNavKey == navKey && _lastNavAt != null && now.difference(_lastNavAt!).inMilliseconds < 1500) {
      // Ignore duplicate navigation attempts within 1.5s window
      return;
    }

    Widget? target;
    switch (type) {
      case 'new_registration':
      case 'confirm_payment':
      case 'refund':
        if (registrationId.isNotEmpty) {
          target = ReservationLoaderScreen(reservationId: registrationId);
        }
        break;
      case 'new_activity':
      case 'activity_verification':
        if (activityId.isNotEmpty) {
          target = ActivityScreen(id: activityId);
        }
        break;
      case 'new_property':
      case 'property_verification':
        if (propertyId.isNotEmpty) {
          target = PropertyScreen(id: propertyId);
        }
        break;
      default:
        break;
    }

    if (target != null) {
      // Update debounce markers
      _lastNavKey = navKey;
      _lastNavAt = DateTime.now();
      final nav = navigatorKey.currentState;
      if (nav != null) {
        // Use push to keep user's back stack; alternatively pushNamed if routes are defined.
        nav.push(MaterialPageRoute(builder: (_) => target!));
      } else {
        // Navigator not ready yet (e.g., app cold start). Defer once more.
        _pendingInitialMessageData = data;
      }
    }
  } catch (e) {
    developer.log('Failed to handle notification navigation: $e', name: 'FCM');
  }
}

// Note: Firebase Dynamic Links code removed. Custom scheme links are handled via AppLinksService.

// favorites, reservations, messages, reviews, profile (test) done
