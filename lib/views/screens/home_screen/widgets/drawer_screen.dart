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
    return Drawer(
      clipBehavior: Clip.hardEdge,
      elevation: 0.5,
      backgroundColor: NeumorphicTheme.baseColor(context),
      child: Column(
        children: [
          DrawerHeader(
              child: ListTile(
            contentPadding: EdgeInsets.zero,
            // title: FittedBox(
            //   alignment: Alignment.centerLeft,
            //   fit: BoxFit.scaleDown,
            //   child: Text(
            //     'Azeem Khdlid',
            //     style: TextStyle(
            //         fontSize: 14.sp,
            //         color: AppColors.kcPrimaryForgroundColor,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // subtitle: FittedBox(
            //   alignment: Alignment.centerLeft,
            //   fit: BoxFit.scaleDown,
            //   child: Text(
            //     'yahya.ali.barki@gmail.com',
            //     style: TextStyle(
            //         fontSize: 12.sp,
            //         color: AppColors.kcPrimaryForgroundColor,
            //         fontWeight: FontWeight.normal),
            //   ),
            // ),
            trailing: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Neumorphic(
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 8,
                    lightSource: LightSource.topLeft,
                    color: NeumorphicColors.background),
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  child: NeumorphicIcon(
                    Icons.close,

                    style: const NeumorphicStyle(
                        color: NeumorphicColors.defaultTextColor),
                    // color: AppColors.kcPrimaryForgroundColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          )),
          drawerOption(
              iconImage: Image.asset('assets/images/policy.png'),
              onTap: () {},
              title: 'Privacy Policy'),
          drawerOption(
              iconImage: Image.asset('assets/images/terms.png'),
              onTap: () {},
              title: 'Terms & Conditions'),
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
                          image: Image.asset('assets/images/whatsapp.png'),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 8,
                          lightSource: LightSource.topLeft,
                          color: NeumorphicColors.background),
                      child: Text(
                        "Made with love by Stackwise Technologies ❤️",
                        style: TextStyle(
                            color: AppColors.kcPrimaryForgroundColor,
                            fontSize: 12.sp),
                      ),
                    ),
                  ),
                  6.h.verticalSpace,
                  Neumorphic(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: NeumorphicColors.background),
                    child: Text(
                      "Version : 1.0.2.1",
                      style: TextStyle(
                          color: AppColors.kcPrimaryForgroundColor
                              .withOpacity(0.3),
                          fontSize: 12.sp),
                    ),
                  ),
                  10.h.verticalSpace,
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget drawerOption(
      {required String title,
      required Image iconImage,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8).h,
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            depth: 8,
            lightSource: LightSource.topLeft,
            color: NeumorphicColors.background),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Neumorphic(
              padding: EdgeInsets.all(18.r),
              style: const NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 8,
                  lightSource: LightSource.topLeft,
                  color: NeumorphicColors.background),
              child: iconImage),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.kcPrimaryForgroundColor.withOpacity(0.7),
                fontWeight: FontWeight.bold),
          ),
          onTap: onTap,
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
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Neumorphic(
                padding: EdgeInsets.all(8.r),
                style: const NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 8,
                    lightSource: LightSource.topLeft,
                    color: NeumorphicColors.background),
                child: image),
            // 6.w.horizontalSpace,
            Neumorphic(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 8,
                  lightSource: LightSource.topLeft,
                  color: NeumorphicColors.background),
              child: Text(
                title,
                style: TextStyle(
                    color: AppColors.kcPrimaryForgroundColor, fontSize: 12.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
