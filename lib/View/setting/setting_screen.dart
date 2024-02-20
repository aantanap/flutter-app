// ignore_for_file: deprecated_member_use, unused_import

import 'package:rems/theme_old/config_theme/images.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:rems/theme_old/controller_theme/profile_controller.dart';
import 'package:rems/main.dart';
import 'package:rems/theme_old/view_theme/profile/notification_screen.dart';
import 'package:rems/theme_old/view_theme/profile/widget/custom_row.dart';
import 'package:rems/theme_old/view_theme/profile/widget/notification_view.dart';
import 'package:rems/theme_old/view_theme/profile/widget/social_view.dart';
import 'package:rems/view/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    setState(() {
      if (AppTheme.isLightTheme == false) {
        profileController.darkMode.value = true;
      } else {
        profileController.darkMode.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int light = 1;
    int dark = 2;
    changeColor(int color) {
      if (color == light) {
        MyApp.setCustomeTheme(context, 6);
      } else {
        MyApp.setCustomeTheme(context, 7);
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141F')
            : HexColor(AppTheme.primaryColorString!),
          title: Text(
            "Settings",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          elevation: 0,
          centerTitle: true,
          // backgroundColor: AppTheme.isLightTheme == false
          //     ? const Color(0xff211F32)
          //     : const Color(0xffFFFFFF),
          leading: IconButton(
            icon: Image.asset(
              "assets/images/Chevron_Left.png",
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.08,
              color: AppTheme.isLightTheme == false
                  ? const Color(0xffFFFFFF)
                  : const Color(0xff211F32),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        
        // backgroundColor: AppTheme.isLightTheme == false
        //     ? HexColor('#15141f')
        //     : Theme.of(context).appBarTheme.backgroundColor,
        // elevation: 0,
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Image.asset(
        //     "assets/images/Chevron_Left.png",
        //     height: MediaQuery.of(context).size.height * 0.08,
        //     width: MediaQuery.of(context).size.width * 0.08,
        //     color: AppTheme.isLightTheme == false
        //         ? const Color(0xffFFFFFF)
        //         : const Color(0xff211F32),
        //   ),
        // ),
      ),
      body: Container(
        
        height: Get.height,
        width: Get.width,
        color: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Settings",
                //   style: Theme.of(context).textTheme.headline6!.copyWith(
                //         fontSize: 24,
                //         fontWeight: FontWeight.w800,
                //       ),
                // ),
                const SizedBox(height: 32),
                // Text(
                //   "General",
                //   style: Theme.of(context).textTheme.caption!.copyWith(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w500,
                //         color: const Color(0xffA2A0A8),
                //       ),
                // ),
                // const SizedBox(height: 16),
                notificationView(
                  context,
                  "Dark Mode",
                  CupertinoSwitch(
                    value: profileController.darkMode.value,
                    activeColor: HexColor(AppTheme.primaryColorString!),
                    onChanged: (v) {
                      setState(() {
                        profileController.darkMode.value = v;
                        if (v == true) {
                          changeColor(dark);
                        } else {
                          changeColor(light);
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(height: 22),
                customRow(
                  context,
                  "Reset Password",
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Get.to(
                      const NotificationScreen(),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  child: customRow(
                    context,
                    "Notifications",
                  ),
                ),
                const SizedBox(height: 32),
                customRow(
                  context,
                  "Privacy Settings",
                ),
                const SizedBox(height: 32),
                customRow(
                  context,
                  "Help Center",
                ),
                const SizedBox(height: 32),
                customRow(
                  context,
                  "Contact Us",
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Get.offAll(const SplashScreen());
                  },
                  child: customRow(
                    context,
                    "Log out",
                  ),
                ),
                const SizedBox(height: 32),
                // Text(
                //   "Follow Us",
                //   style: Theme.of(context).textTheme.caption!.copyWith(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w500,
                //         color: const Color(0xffA2A0A8),
                //       ),
                // ),
                const SizedBox(height: 16),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     socialView(
                //       AppTheme.isLightTheme == false
                //           ? DefaultImages.twitterdark
                //           : DefaultImages.twitter,
                //     ),
                //     socialView(
                //       AppTheme.isLightTheme == false
                //           ? DefaultImages.facebookDark
                //           : DefaultImages.facebook,
                //     ),
                //     socialView(
                //       AppTheme.isLightTheme == false
                //           ? DefaultImages.tiktokDark
                //           : DefaultImages.tikTok,
                //     ),
                //     socialView(
                //       AppTheme.isLightTheme == false
                //           ? DefaultImages.instagramDark
                //           : DefaultImages.instagram,
                //     )
                //   ],
                // ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Log out",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffFB4E4E),
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "rems © 2022 v1.0",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff9EA3AE),
                        ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
