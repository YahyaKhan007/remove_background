import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

Widget customeTextField(
    {required String hintTtext,
    required TextEditingController controller,
    bool? isPassword,
    required FocusNode focusNode}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    height: 48.h,
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300)),
    child: Center(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: isPassword != null ? state.showPassword : false,
            focusNode: focusNode,
            controller: controller,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 15.w,
                  right: 10,
                ),
                hintText: hintTtext,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                ),
                suffixIconConstraints:
                    BoxConstraints(maxWidth: 30.w, maxHeight: 48.h),
                suffixIcon: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Visibility(
                        visible: isPassword ?? false,
                        child: GestureDetector(
                            onTap: () {
                              context.read<AuthBloc>().add(ShowPasswordEvent(
                                  isShow: !state.showPassword));

                              log("state of sbscure : ${state.showPassword.toString()}");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: const Icon(Icons.remove_red_eye_sharp),
                            )));
                  },
                )),
          );
        },
      ),
    ),
  );
}
