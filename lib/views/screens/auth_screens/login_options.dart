
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../screens.dart';

class LoginOptionScreen extends StatelessWidget {
  const LoginOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kcPrimaryBackgroundColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.11,
                ),
                Image.asset("assets/images/onb1.png"),
                20.h.verticalSpace,
                Text(
                  "Instant Clear: One-Tap Transformation",
                  style: TextStyle(
                      fontSize: 22.sp,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kcPrimaryForgroundColor),
                ),
                15.h.verticalSpace,
                Text(
                  "Tap once and watch as our app delivers clean, crisp images instantly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2,
                      color: AppColors.kcSecondaryForgroundColor),
                ),
                24.h.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    optionContainer(
                        bordrWidth: 3,
                        onTap: () {
                          context
                              .read<AuthBloc>()
                              .add(GotoRegisterationScreenEvent());
                        },
                        size: size,
                        title: 'Register'),
                    optionContainer(
                        // icon: Image.asset('assets/images/email.png'),
                        onTap: () {
                          context.read<AuthBloc>().add(GotoLoginScreenEvent());
                        },
                        bordrWidth: 3,
                        size: size,
                        title: 'Login'),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                optionContainer(
                    icon: Image.asset('assets/images/google.png'),
                    onTap: () {
                      context.read<AuthBloc>().add(GoogleLoginEvent());
                    },
                    width: size.width * 0.85,
                    size: size,
                    title: 'Sign up with Google'),
                optionContainer(
                    icon: Image.asset('assets/images/apple.png'),
                    onTap: () {
                      context.read<AuthBloc>().add(AppleLoginEvent());
                    },
                    width: size.width * 0.85,
                    size: size,
                    title: 'Sign Up with Apple'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
