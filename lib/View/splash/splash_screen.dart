// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, annotate_overrides

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'dart:async';
import 'package:rems/View/splash/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => WelcomeFirstScreen(), transition: Transition.downToUp);

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppTheme.isLightTheme == false
                ? HexColor('#15141F')
                : HexColor("#FAF9FF")),
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    'assets/images/icon.PNG',
                    // color: HexColor(AppTheme.secondaryColorString!)
                  ),
                ),
                const SizedBox(width: 8),
                // SizedBox(
                //   height: 40,
                //   width: 130,
                //   child: SvgPicture.asset('assets/images/Helpdesk.svg',
                //       color: HexColor(AppTheme.secondaryColorString!)),
                // ),
              ],
            ),
            const Spacer(),
            // Padding(
            //   padding: const EdgeInsets.only(left: 48, right: 48, bottom: 20),
            //   child: Text(
            //     "FinPay is a financial platform to manage your business and money.",
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context).textTheme.bodyText2!.copyWith(
            //           fontWeight: FontWeight.w500,
            //           fontSize: 14,
            //           color: const Color(0xffDCDBE0),
            //         ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
