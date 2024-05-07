import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:remove_bg/views/screens/home_screen/widgets/neumorphic_style.dart';

import '../../../screens.dart';

AppBar appBar(
  BuildContext context,
  GlobalKey<ScaffoldState> scaffoldKey
) =>
    AppBar(
      backgroundColor: NeumorphicTheme.baseColor(context),
      actions: [
        Neumorphic(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            style: neumorphicStyle(),
            child: Row(
              children: [
                NeumorphicText(
                  "100",
                  style: const NeumorphicStyle(
                    depth: 4, //customize depth here
                    color: AppColors
                        .kcSecondaryForgroundColor, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18.sp, //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
                4.w.horizontalSpace,
                NeumorphicIcon(
                  Icons.diamond_outlined,
                  style: const NeumorphicStyle(
                      color: Colors.red,
                      intensity: 1,
                      shape: NeumorphicShape.convex),
                  size: 20.r,
                ),
              ],
            )),

        // Image.asset(
        //   'assets/images/diomond.png',
        //   height: 18.h,
        // ),

        16.w.horizontalSpace,
      ],
      leading: Builder(
        builder: (context) => GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.w, top: 8.h),
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    intensity: 0.7,
                    oppositeShadowLightSource: true,
                    boxShape: const NeumorphicBoxShape.circle(),
                    // boxShape: NeumorphicBoxShape.roundRect(
                    //     BorderRadius.circular(12)),
                    depth: -18,
                    lightSource: LightSource.topLeft,
                    color: NeumorphicTheme.baseColor(context)),
                child: Center(
                  child: NeumorphicIcon(
                    Icons.menu,
                    style: const NeumorphicStyle(
                        color: AppColors.kcSecondaryForgroundColor,
                        intensity: 1,
                        shape: NeumorphicShape.convex),
                    size: 20.r,
                  ),
                ),
              ),
            )

            // Image.asset("assets/images/drawer.png")
            ),
      ),
    );
