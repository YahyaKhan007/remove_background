
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../screens.dart';

Widget customButton(
    {double? height,
    double? width,
    FontWeight? fontWeight,
    required VoidCallback onTap,
    required String text,
    int? radius,
    Color? textColor,
    Color? borderColor,
    double? fontSize,
    Color? backGroundColor,
    bool? isPassword}) {
  return BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: height?.h,
          width: width?.w,
          decoration: BoxDecoration(
            color: backGroundColor,
            border: Border.all(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(radius?.toDouble() ?? 5.r),
          ),
          child: state.isLoading
              ? Center(
                  child: loadingWidgetInkDrop(
                      size: 25.r, color: AppColors.kcPrimaryBackgroundColor))
              : Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: fontSize ?? 14,
                        fontWeight: fontWeight ?? FontWeight.normal),
                  ),
                ),
        ),
      );
    },
  );
}
