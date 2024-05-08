// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:remove_bg/views/screens/home_screen/widgets/neumorphic_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../bloc/homepage_bloc/homepage_bloc.dart';
import '../../../common/app_common.dart';
import '../save_image.dart';

Widget get unSelectedWidget => const SizedBox();
Widget selectedWidget({required Size size}) =>
    BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 8,
              lightSource: LightSource.topLeft,
              color: NeumorphicColors.background),
          child: SizedBox(
            height: size.height * 0.33,
            width: size.width * 0.4,
            child: Column(
              children: [
                Neumorphic(
                  style: neumorphicStyle(),
                  child: SizedBox(
                    height: size.height * 0.28,
                    width: size.width * 0.4,
                    child: state.response != null
                        ? Image.memory(
                            state.response!,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                BlocBuilder<HomepageBloc, HomepageState>(
                  builder: (context, state) {
                    return Neumorphic(
                      style: neumorphicStyle(),
                      child: InkWell(
                        onTap: () async {
                          log("Went for download");

                          var downloadedImage = await saveImage(state.response!,
                              '${state.removedBgs.length + 1}.png');

                          var removedBgs = state.removedBgs;

                          if (downloadedImage != null) {
                            removedBgs.add(downloadedImage);
                          }

                          context.read<HomepageBloc>().add(
                                UpdateRemoveBackgroundsList(
                                    removedBgs: removedBgs),
                              );

                          SharedPreferences.getInstance().then((prefs) async {
                            await prefs.setStringList('removedBgs', removedBgs);

                            // availableDiomonds = prefs.getInt('currentDiomonds')!;
                          });

                          log("downloaded");
                        },
                        child: SizedBox(
                          height: size.height * 0.05,
                          width: size.width * 0.4,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/download.png'),
                              6.w.horizontalSpace,
                              Text(
                                "Download",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.kcPrimaryForgroundColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
