// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

// import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:remove_bg/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/homepage_bloc/homepage_bloc.dart';
import '../../../models/models.dart';
import '../../screens.dart';
import '../../../services/api_service/api_service.dart';
import 'widgets/appbar.dart';
import 'widgets/drawer_screen.dart';
import 'widgets/full_page_image.dart';
import 'widgets/functions/reduce_imgae_size.dart';
import 'widgets/gridview.dart';
import 'widgets/neumorphic_style.dart';
import 'widgets/selected_unselected_widgets.dart';

bool loading = true;

class HomePage extends StatefulWidget {
  final UserModel? userModel;
  const HomePage({super.key, this.userModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late GlobalKey<ScaffoldState> scaffoldKey;

  late Widget curentWidget;
  late double opacity;
  late Timer timer;
  int availableDiomonds = 0;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      // prefs.setStringList(key, value)
      availableDiomonds = prefs.getInt('currentDiomonds')!;
      prefs.getStringList('removedBgs');
      var removedBgs = prefs.getStringList('removedBgs') ?? [];
      context
          .read<HomepageBloc>()
          .add(UpdateRemoveBackgroundsList(removedBgs: removedBgs));
    });
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    curentWidget = unSelectedWidget;

    opacity = 0.0;

    timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        opacity += 0.2;
        if (opacity >= 1.0) {
          opacity = 0.0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    log("Available diomonds are ---->  $availableDiomonds");

    return SafeArea(
      child: Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        key: scaffoldKey,
        drawer: CustomeDrawer(),
        appBar: appBar(
          context,
          availableDiomonds,
          scaffoldKey,
        ),
        // bottomSheet: Container(
        //   height: size.height * 0.9,
        //   width: size.width,
        //   color: Colors.black,
        // ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),

                // ~ for selection of photos
                photoContainer(size: size, currentWidget: curentWidget),

                24.h.verticalHeight,
                BlocBuilder<HomepageBloc, HomepageState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        if (state.pickedImage != null &&
                            state.loadingRemovedBg == false &&
                            state.backgroundRemoved == false) {
                          if (availableDiomonds > 0) {
                            // ~ loading true
                            context.read<HomepageBloc>().add(
                                  const ChangeLoading(true),
                                );
                            // ~

                            RemoveBgApiService apiService =
                                RemoveBgApiService();

                            final res = await apiService
                                .removeBackground(state.pickedImage!.path);

                            if (res != null) {
                              context.read<HomepageBloc>().add(
                                  RemovedBackgroundSuccessfull(response: res));
                              availableDiomonds -= 1;
                              // setState(() {});
                              SharedPreferences.getInstance().then((prefs) {
                                prefs.setInt(
                                    'currentDiomonds', availableDiomonds);
                              });
                            } else {
                              // context.read<HomepageBloc>().add(
                              //     const RemoveBackground(backgroundRemoved: false));
                            }
                          } else {
                            SnackBarService().showSnackbar(
                                message: "You have no diomonds left",
                                duration: 2,
                                title: "Out of Diomonds",
                                color: Colors.red,
                                snackPosition: SnackPosition.TOP);
                          }
                        }
                      },
                      child: state.pickedImage == null ||
                              state.backgroundRemoved
                          ? Neumorphic(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 0.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 16.h),
                              style: neumorphicStyle(),
                              child: Center(
                                child: Text(
                                  "Remove Background",
                                  style: TextStyle(
                                      color: AppColors.kcPrimaryForgroundColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : state.pickedImage != null &&
                                  state.loadingRemovedBg == true
                              ? Neumorphic(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 0.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  style: neumorphicStyle(),
                                  child: SizedBox(
                                      height: 40,
                                      width: size.width,
                                      child: LiquidLinearProgressIndicator(
                                        value: 0.75, // Defaults to 0.5.
                                        valueColor: const AlwaysStoppedAnimation(
                                            NeumorphicColors
                                                .darkBackground), // Defaults to the current Theme's accentColor.
                                        backgroundColor: NeumorphicColors
                                            .background, // Defaults to the current Theme's backgroundColor.
                                        borderColor:
                                            NeumorphicColors.darkBackground,
                                        borderWidth: 5.0,
                                        borderRadius: 12.0,
                                        direction: Axis
                                            .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                        center: const Text(
                                            "Removing background...",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic)),
                                      )),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 24)
                                      .w,
                                  child: AnimatedOpacity(
                                    opacity: opacity,
                                    duration: const Duration(milliseconds: 300),
                                    child: Neumorphic(
                                      style: neumorphicStyle(),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 16.h),
                                        child: Center(
                                          child: Text(
                                            "Remove Background",
                                            style: TextStyle(
                                                color: AppColors
                                                    .kcPrimaryForgroundColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                    );
                  },
                ),
                16.h.verticalHeight,

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16).w,
                    child: NeumorphicText(
                      "Removed Backgrounds",
                      style: const NeumorphicStyle(
                        depth: 4, //customize depth here
                        color: NeumorphicColors
                            .defaultTextColor, //customize color here
                      ),
                      textStyle: NeumorphicTextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold
                          //customize size here
                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                          ),
                    ),
                  ),
                ),
                8.h.verticalHeight,
                // ~   Dummy Pictures
                dummyPictures(size: size)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget photoContainer({required Size size, required Widget currentWidget}) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      buildWhen: (previous, current) {
        log(current.backgroundRemoved.toString());
        curentWidget = current.backgroundRemoved
            ? selectedWidget(size: size)
            : unSelectedWidget;
        return current.pickedImage != null ? true : true;
        //  previous.isPhotoSelected != current.isPhotoSelected;
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: state.backgroundRemoved
                    ? Alignment.centerLeft
                    : Alignment.center,
                duration: const Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: () async {
                    context
                        .read<HomepageBloc>()
                        .add(const SelectedPhotoEvent());

                    
                  },
                  child: Neumorphic(
                    style: neumorphicStyle(),
                    child: SizedBox(
                      height: size.height * 0.33,
                      width: size.width * 0.4,
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.28,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.r),
                                    topRight: Radius.circular(16.r)),
                                color: Colors.transparent),
                            child: state.pickedImage != null
                                ? Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(
                                              () => FullScreenImage(
                                                    imagePath:
                                                        state.pickedImage!.path,
                                                  ),
                                              duration:
                                                  const Duration(seconds: 1));
                                        },
                                        child: Hero(
                                          tag: state.pickedImage!.path,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.r),
                                                topRight:
                                                    Radius.circular(16.r)),
                                            child: SizedBox(
                                              width: size.width * 0.4,
                                              height: size.height * 0.28,
                                              child: Image.file(
                                                File(state.pickedImage!.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 5,
                                          top: 5,
                                          child: CircleAvatar(
                                            // backgroundColor:
                                            //     AppColors.kcDiomondContainerColor,
                                            backgroundColor: Colors.transparent
                                                .withOpacity(0.1),
                                            radius: 15.r,
                                            child: Center(
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  context.read<HomepageBloc>().add(
                                                      const RemovePhotoEvent());
                                                },
                                                icon: NeumorphicIcon(
                                                  Icons.close,
                                                  // style: NeumorphicStyle(
                                                  //     color: NeumorphicColors
                                                  //         .defaultTextColor),
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      NeumorphicIcon(
                                        Icons.photo_library_outlined,
                                        style: NeumorphicStyle(
                                            color: NeumorphicColors
                                                .defaultTextColor
                                                .withOpacity(0.5)),
                                        size: 40.r,
                                      ),
                                      // Image.asset(
                                      //     'assets/images/select_photo.png'),
                                      8.h.verticalSpace,
                                      NeumorphicText(
                                        "Add Photo",
                                        style: const NeumorphicStyle(
                                          depth: 100, //customize depth here
                                          color: NeumorphicColors
                                              .defaultTextColor, //customize color here
                                        ),
                                        textStyle: NeumorphicTextStyle(
                                          fontSize: 14, //customize size here
                                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          Neumorphic(
                            style: neumorphicStyle(),
                            child: SizedBox(
                              height: size.height * 0.05,
                              width: size.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  NeumorphicIcon(
                                    Icons.check,
                                    style: const NeumorphicStyle(
                                        color:
                                            NeumorphicColors.defaultTextColor,
                                        depth: 100,
                                        intensity: 1),
                                  ),
                                  5.w.horizontalSpace,
                                  NeumorphicText(
                                      state.pickedImage != null
                                          ? "Selected"
                                          : "Select",
                                      style: const NeumorphicStyle(
                                        depth: 40, //customize depth here
                                        color:
                                            NeumorphicColors.defaultTextColor,

                                        // color: AppColors.kcPrimaryForgroundColor,

                                        //customize color here
                                      ),
                                      textStyle: NeumorphicTextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp, //customize size here
                                        // AND others usual text style properties (fontFamily, fontWeight, ...)
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: size.width * 0.415,
                top: size.height * 0.14,
                child: Visibility(
                  visible: state.backgroundRemoved,
                  child: Neumorphic(
                    padding: const EdgeInsets.all(4).w,
                    style: neumorphicStyle(),
                    child: Transform.rotate(
                      angle: 3.14 * 180 / 180,
                      child: SizedBox(
                        height: size.height * 0.024,
                        //width: size.width,
                        child: Lottie.asset(
                          'assets/lottie/OapAypFZZQ.json',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: BlocBuilder<HomepageBloc, HomepageState>(
                    builder: (context, state) {
                      return
                          //  Visibility(
                          //   visible: state.isPhotoSelected,
                          // child:
                          AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: curentWidget,
                        // ),
                      );
                    },
                  ))
            ],
          ),
        );
      },
    );
  }
}
