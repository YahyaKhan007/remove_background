// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';

extension SizedBoxExtension on double {
  SizedBox get verticalHeight => SizedBox(height: this as double);
  SizedBox get horizontalWidth => SizedBox(width: this as double);
}

extension SizedBoxExtensions on int {
  SizedBox get verticalHeight => SizedBox(height: this as double);
  SizedBox get horizontalWidth => SizedBox(width: this as double);
}
