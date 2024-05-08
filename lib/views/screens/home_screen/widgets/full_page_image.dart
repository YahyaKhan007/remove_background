import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import '../../../screens.dart';

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
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
                  color: NeumorphicTheme.defaultTextColor(context)),
              child: Center(
                child: NeumorphicIcon(
                  Icons.arrow_back_ios_new,
                  style: const NeumorphicStyle(
                      color: AppColors.kcSecondaryBackgroundColor,
                      intensity: 1,
                      shape: NeumorphicShape.convex),
                  size: 20.r,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: Hero(
            transitionOnUserGestures: true,
            tag: imagePath,
            child: Image.file(File(imagePath)),
          ),
        ),
      ),
    );
  }
}
