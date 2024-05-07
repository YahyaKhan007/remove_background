import 'package:neumorphic_ui/neumorphic_ui.dart';

NeumorphicStyle neumorphicStyle() => NeumorphicStyle(
    shape: NeumorphicShape.concave,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    depth: 8,
    lightSource: LightSource.topLeft,
    color: NeumorphicColors.background);
