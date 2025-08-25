import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'locator.dart';
import 'project/user/Home/cubit/home_cubit.dart';
import 'project/user/activities/cubit/cubit.dart';
import 'project/user/auth/cubit/auth_cubit.dart';
import 'project/user/auth/view/Screen/splash/luby_screen_splash.dart';
import 'project/user/favorites/cubit/cubit.dart';
import 'project/user/reservation/cubit/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase
    print('Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Continue without Firebase for now
  }
  
  setup();
  await getIt<CacheService>().init();
  await getIt<ApiService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            /*    theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              textTheme: GoogleFonts.poppinsTextTheme(
                TextTheme(
                  bodyMedium: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  bodyLarge: GoogleFonts.poppins(
             
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
                       */
            home: const LubyScreenSplash(),
          );
        },
      ),
    );
  }
}
