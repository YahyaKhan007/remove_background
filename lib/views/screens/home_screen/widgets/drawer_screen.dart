// ignore_for_file: must_be_immutable

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../services/services.dart';
import '../../../screens.dart';

class CustomeDrawer extends StatelessWidget {
  CustomeDrawer({super.key});
  SnackBarService snackBarService = SnackBarService();

  // Method to launch WhatsApp chat with the specified phone number
  Future<void> _launchWhatsApp() async {
    // Check if WhatsApp is installed on the device
    try {
      final whatsappInstalled =
          await launchUrl(Uri.parse('whatsapp://send?phone=+92 304-8178884'));
      if (!whatsappInstalled) {
        snackBarService.showSnackbar(
            message: 'WhatsApp is not installed on your device.',
            duration: 1,
            title: 'Warning',
            color: Colors.red);
      }
    } catch (e) {
      snackBarService.showSnackbar(
          message: 'WhatsApp is not installed on your device.',
          duration: 1,
          title: 'Warning',
          color: Colors.red);
    }
  }

  Future<void> _launchWebsite() async {
    // Check if WhatsApp is installed on the device
    final whatsappInstalled =
        await launchUrl(Uri.parse('https://stackwiseagency.com/'));

    if (!whatsappInstalled) {
      snackBarService.showSnackbar(
          message: 'Website not found',
          duration: 1,
          title: 'Warning',
          color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Drawer(
        // clipBehavior: Clip.none,

        elevation: 0.5,
        backgroundColor: NeumorphicTheme.baseColor(context),
        child: Column(
          children: [
            DrawerHeader(
                child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
              fit: BoxFit.fitWidth,
            )),
            drawerOption(
                size: size,
                iconImage: Image.asset(
                  'assets/images/policy.png',
                  height: 16.sp,
                ),
                onTap: () {},
                title: 'Privacy Policy'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: Divider(
                height: 2.h,
                color: NeumorphicColors.defaultTextColor.withOpacity(0.3),
              ),
            ),
            drawerOption(
                size: size,
                iconImage: Image.asset(
                  'assets/images/terms.png',
                  height: 16.sp,
                ),
                onTap: () {},
                title: 'Terms & Conditions'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: Divider(
                height: 2.h,
                color: NeumorphicColors.defaultTextColor.withOpacity(0.3),
              ),
            ),
            drawerOption(
                size: size,
                iconImage: Image.asset(
                  'assets/images/diomond.png',
                  color: Colors.grey.shade700,
                  height: 16.sp,
                ),
                onTap: () {},
                title: 'Watch ads to earn diomonds'),
            const Spacer(),
            Column(
              children: [
                FittedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        contactContainer(
                            onTap: () {
                              _launchWhatsApp();
                            },
                            image: Image.asset(
                              'assets/images/whatsapp.png',
                            ),
                            title: "+92 304-8178884"),
                        10.w.horizontalSpace,
                        contactContainer(
                            onTap: () {
                              _launchWebsite();
                            },
                            image: Image.asset('assets/images/web.png'),
                            title: "stackwiseagency.com")
                      ],
                    ),
                  ),
                ),
                10.w.verticalHeight,
                Column(
                  children: [
                    4.h.verticalSpace,
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Neumorphic(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            depth: 8,
                            lightSource: LightSource.topLeft,
                            color: NeumorphicColors.background),
                        child: SizedBox(
                          width: size.width * 0.65,
                          child: NeumorphicText(
                            "Made with love \nby Stackwise Technologies ❤️",
                            style: NeumorphicStyle(
                              depth: 4, //customize depth here
                              color: NeumorphicColors.defaultTextColor
                                  .withOpacity(0.5), //customize color here
                            ),
                            textStyle: NeumorphicTextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.bold
                                //customize size here
                                // AND others usual text style properties (fontFamily, fontWeight, ...)
                                ),
                          ),
                          // Text(
                          //   "Made with love \nby Stackwise Technologies ❤️",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       color: AppColors.kcPrimaryForgroundColor,
                          //       fontSize: 11.sp),
                          // ),
                        ),
                      ),
                    ),
                    8.h.verticalSpace,
                    NeumorphicText(
                      "Version : 1.0.2.1",
                      style: NeumorphicStyle(
                        depth: 4, //customize depth here
                        color: NeumorphicColors.defaultTextColor
                            .withOpacity(0.5), //customize color here
                      ),
                      textStyle: NeumorphicTextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold
                          //customize size here
                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                          ),
                    ),
                    10.h.verticalSpace,
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget drawerOption(
      {required Size size,
      required String title,
      required Image iconImage,
      required VoidCallback onTap}) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: iconImage,
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: NeumorphicText(
          title,
          style: NeumorphicStyle(
            depth: 4, //customize depth here
            color: NeumorphicColors.defaultTextColor
                .withOpacity(0.5), //customize color here
          ),
          textStyle: NeumorphicTextStyle(
              fontSize: 12.sp, fontWeight: FontWeight.bold
              //customize size here
              // AND others usual text style properties (fontFamily, fontWeight, ...)
              ),
        ),
      ),
    );
  }

  Widget contactContainer(
      {required VoidCallback onTap,
      required Image image,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Neumorphic(
                padding: EdgeInsets.all(6.r),
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: -8,
                    lightSource: LightSource.topLeft,
                    color: NeumorphicColors.background),
                child: image),
            6.w.horizontalSpace,
            NeumorphicText(
              title,
              style: NeumorphicStyle(
                depth: 4, //customize depth here
                color: NeumorphicColors.defaultTextColor
                    .withOpacity(0.5), //customize color here
              ),
              textStyle: NeumorphicTextStyle(
                  fontSize: 12.sp, fontWeight: FontWeight.bold
                  //customize size here
                  // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
            )
          ],
        ),
      ),
    );
  }
}
