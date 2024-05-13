import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:remove_bg/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:remove_bg/views/screens/home_screen/widgets/full_page_image.dart';

Widget dummyPictures({required Size size}) {
  return BlocBuilder<HomepageBloc, HomepageState>(
    builder: (context, state) {
      return SizedBox(
        height: size.height * 0.38,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
          child: GridView.builder(
              itemCount: state.removedBgs.length,
              reverse: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.h),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => FullScreenImage(
                        imagePath: state.removedBgs[index],
                      ),
                      // duration: const Duration(milliseconds: 600)
                    );
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: NeumorphicColors.background),
                    child: Hero(
                      tag: state.removedBgs[index],
                      child: Image.file(
                        File(state.removedBgs[index]),
                        fit: BoxFit.cover,
                        height: 100.h,
                        width: 100.w,
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    },
  );
}
