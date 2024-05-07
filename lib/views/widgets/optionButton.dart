  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../screens.dart';

Widget optionContainer(
      {required Size size,
      Image? icon,
      required String title,
      Color? borderColor,
      double? bordrWidth,
      double? width,
      required VoidCallback onTap}) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: width ?? size.width * 0.4,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    width: bordrWidth ?? 1,
                    color: borderColor ?? AppColors.kcSecondaryForgroundColor),
              ),
              child: title.contains('Google') && state.isGoogleLoading == true
                  ? loadingWidgetInkDrop(size: 25.r, color: Colors.black)
                  : title.contains('Apple') && state.isAppleLoading == true
                      ? loadingWidgetInkDrop(size: 25.r, color: Colors.black)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icon ?? Container(),
                            icon == null
                                ? 0.w.horizontalSpace
                                : 10.w.horizontalSpace,
                            Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: AppColors.kcPrimaryForgroundColor,
                                    fontSize: 12.sp),
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }