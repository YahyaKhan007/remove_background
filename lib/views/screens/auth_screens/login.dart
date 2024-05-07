
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../screens.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const CircleAvatar(
              backgroundColor: AppColors.kcAvatarBackColor,
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.kcPrimaryForgroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 22.sp,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kcPrimaryForgroundColor),
              ),
              48.h.verticalSpace,
              customeTextField(
                  hintTtext: "Enter your email",
                  controller: emailController,
                  focusNode: emailFocusNode),
              24.h.verticalSpace,
              customeTextField(
                  hintTtext: "Enter your password",
                  isPassword: true,
                  controller: passwordController,
                  focusNode: passwordFocusNode),
              Padding(
                padding: EdgeInsets.only(top: 24.h, right: 16.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 14.sp, color: const Color(0xff3C9AFB)),
                    ),
                  ),
                ),
              ),
              32.h.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: customButton(
                    onTap: () {
                      emailFocusNode.unfocus();
                      passwordFocusNode.unfocus();
                      context.read<AuthBloc>().add(LoggingInEvent(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                    text: 'Login',
                    backGroundColor: AppColors.kcPrimaryForgroundColor,
                    height: 38.h,
                    radius: 100,
                    isPassword: null),
              ),
              SizedBox(
                height: size.height * 0.1,
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
    );
  }
}
