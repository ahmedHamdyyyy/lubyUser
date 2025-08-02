import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/services/api_services.dart';
import 'core/services/cach_services.dart';
import 'locator.dart';
import 'project/user/Home/cubit/home_cubit.dart';
import 'project/user/auth/cubit/auth_cubit.dart';
import 'project/user/auth/view/Screen/splash/luby_screen_splash.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
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
           */  home: const LubyScreenSplash(),
          ),
      ),
    );
  }
}
