import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './views/screens.dart';
import 'package:flutter/material.dart';

import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/homepage_bloc/homepage_bloc.dart';

import 'package:get/get.dart';

import 'services/services.dart';
import 'views/utils/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: ((context) =>
                      HomepageBloc(imagePickerUtils: ImagePickerUtils()))),
              BlocProvider(
                  create: ((context) =>
                      AuthBloc(AuthService(), DataBaseService()))),
              BlocProvider(
                  create: ((context) =>
                      HomepageBloc(imagePickerUtils: ImagePickerUtils()))),
              BlocProvider(
                  create: ((context) =>
                      AuthBloc(AuthService(), DataBaseService()))),
              // BlocProvider(create: ((context) => AuthBloc(AuthService()))),
            ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'park my car',
              theme: ThemeData(
                primaryColor: AppColors.kcPrimaryBackgroundColor,
                primarySwatch: Colors.blue,
                textTheme:
                    Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              ),
              home: child,
            ),
          );
        },
        child: const HomePage()

        //  !showOnboarding ? OnBoardingScreen() : const SplashScreen(),
        );
  }
}
