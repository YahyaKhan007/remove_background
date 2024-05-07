import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import '../constants.dart';

Widget dummyPictures({required Size size}) {
  return SizedBox(
    height: size.height * 0.3,
    width: size.width,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
      child: GridView.builder(
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 10.w, crossAxisSpacing: 10.h),
          itemBuilder: (context, index) {
            return Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 8,
                  lightSource: LightSource.topLeft,
                  color: NeumorphicColors.background),
              child: Image.asset(
                removedBg[index],
                fit: BoxFit.cover,
                height: 100.h,
                width: 100.w,
              ),
            );
          }),
    ),
  );
}
