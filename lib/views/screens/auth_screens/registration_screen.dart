
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../screens.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordController = TextEditingController();
  final passeordFocusNode = FocusNode();
  final confirmController = TextEditingController();
  final confirmFocusNode = FocusNode();

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
                height: size.height * 0.04,
              ),
              Text(
                "Register",
                style: TextStyle(
                    fontSize: 22.sp,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kcPrimaryForgroundColor),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "E-mail",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.kcPrimaryForgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              8.h.verticalHeight,
              customeTextField(
                  hintTtext: "Enter your email",
                  controller: emailController,
                  focusNode: emailFocusNode),
              24.h.verticalHeight,
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.kcPrimaryForgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              8.h.verticalHeight,
              customeTextField(
                  hintTtext: "Enter your password",
                  controller: passwordController,
                  isPassword: true,
                  focusNode: passeordFocusNode),
              24.h.verticalHeight,
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "Confirm Password",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.kcPrimaryForgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              8.h.verticalHeight,
              customeTextField(
                  hintTtext: "confirm your password",
                  isPassword: true,
                  controller: confirmController,
                  focusNode: confirmFocusNode),
              SizedBox(
                height: size.height * 0.15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: customButton(
                  onTap: () {
                    context.read<AuthBloc>().add(SignupEvent(
                        email: emailController.text,
                        password: passwordController.text,
                        confirm: confirmController.text));
                  },
                  isPassword: true,
                  text: "Create Account",
                  backGroundColor: AppColors.kcPrimaryForgroundColor,
                  height: 38.h,
                  radius: 100,
                ),
              ),
              24.h.verticalHeight,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "By continuing, you agree to our ",
                    style:
                        TextStyle(fontSize: 12.sp, color: Colors.grey.shade400),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Terms of Service",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xff3C9AFB),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              8.h.verticalHeight,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "and ",
                    style:
                        TextStyle(fontSize: 12.sp, color: Colors.grey.shade400),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xff3C9AFB),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
