import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingWidgetInkDrop({
  required double size,
  required Color color,
}) {
  return LoadingAnimationWidget.inkDrop(
    color: color,
    size: size,
  );
}