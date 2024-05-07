import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:remove_bg/views/screens/home_screen/widgets/neumorphic_style.dart';

import '../../../../bloc/homepage_bloc/homepage_bloc.dart';
import '../../../common/app_common.dart';

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
                Neumorphic(
                  style: neumorphicStyle(),
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
              ],
            ),
          ),
        );
      },
    );
