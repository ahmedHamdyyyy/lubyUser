import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'project/Home/cubit/home_cubit.dart';
import 'project/activities/cubit/cubit.dart';
import 'project/auth/cubit/auth_cubit.dart';
import 'project/auth/view/Screen/splash/luby_screen_splash.dart';
import 'project/favorites/cubit/cubit.dart';
import 'project/reservation/cubit/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {}

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
        builder:
            (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(scaffoldBackgroundColor: Colors.white),
              home: const LubyScreenSplash(),
            ),
      ),
    );
  }
}
