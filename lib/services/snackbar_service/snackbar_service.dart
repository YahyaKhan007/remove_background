// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SnackBarService {
  void showSnackbar(
      {required String message,
      required int duration,
      SnackPosition? snackPosition,
      Color? color,
      required String title}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: color ?? Colors.transparent,
        borderRadius: 50,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        snackPosition: snackPosition ?? SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        message: message,
        title: title,
        duration: Duration(seconds: duration),
      ),
    );
  }
}
