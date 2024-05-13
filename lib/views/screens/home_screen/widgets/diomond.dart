import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:remove_bg/views/screens/home_screen/widgets/neumorphic_style.dart';

Widget diomondContainer(
    {required Size size,
    required Image image,
    required String title,
    VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Neumorphic(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      style: neumorphicStyle(),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: NeumorphicIcon(
                Icons.play_circle,
                style: const NeumorphicStyle(
                    color: NeumorphicColors.defaultTextColor),
                size: 30.r,
              )),
          Container(
            width: 2,
            color: Colors.black,
          ),
          4.horizontalSpace,
          Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: NeumorphicText(
                    title,
                    style: const NeumorphicStyle(
                      depth: 4, //customize depth here
                      color: NeumorphicColors
                          .defaultTextColor, //customize color here
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 14.sp, //customize size here
                      // AND others usual text style properties (fontFamily, fontWeight, ...)
                    ),
                  ),
                ),
              ))
        ],
      ),
    ),
  );
}
