// ignore_for_file: unnecessary_new, prefer_const_constructors, unused_field, deprecated_member_use, unnecessary_import, depend_on_referenced_packages

// import 'package:finpay/theme_old/config_theme/textstyle.dart';
// import 'package:finpay/theme_old/controller_theme/home_controller.dart';
// import 'package:finpay/theme_old/controller_theme/tab_controller.dart';
// import 'package:finpay/theme_old/view_theme/card/card_view.dart';

// import 'package:finpay/theme_old/view_theme/profile/profile_view.dart';
// import 'package:finpay/theme_old/view_theme/statistics/statistics_view.dart';
// import 'package:finpay/theme_old/widgets_theme/custom_button.dart';
// import 'package:finpay/view/Request/create_request/createnewincident_screen.dart';
// import 'package:finpay/view/menu/menu_screen.dart';
// import 'package:finpay/view/profile/profile_screen.dart';
// import 'package:finpay/view/request/create_request/createnewrequest_screen.dart';
// import 'package:finpay/view/home/home_view.dart';
// import 'package:finpay/view/request/view_case/view_listcase.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:simple_speed_dial/simple_speed_dial.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import 'package:rems/View/home/home_screen.dart';
import 'package:rems/View/profile/profile_screen.dart';
import 'package:rems/View/running/running_screen.dart';
import 'package:rems/theme_old/controller_theme/home_controller.dart';
import 'package:rems/theme_old/controller_theme/tab_controller.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with TickerProviderStateMixin {
  final tabController = Get.put(TabScreenController());
  final homeController = Get.put(HomeController());
  @override
  void initState() {
    tabController.customInit();
    homeController.customInit();
    super.initState();
  }

  int _currentIndex = 0;
  bool isAnimating = true;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: HexColor(AppTheme.primaryColorString!),
      //   onPressed: () {
      //     showPopup();
      //   },
      //   child: Image.asset(
      //     "assets/images/UX_Writing.png",
      //     height: MediaQuery.of(context).size.height * 0.08,
      //     width: MediaQuery.of(context).size.width * 0.08,
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        currentIndex: tabController.pageIndex.value,
        onTap: (index) {
          setState(() {
            tabController.pageIndex.value = index;
          });
        },
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141f')
            : Theme.of(context).appBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppTheme.isLightTheme == false
            ? const Color(0xffA2A0A8)
            : HexColor(AppTheme.primaryColorString!).withOpacity(0.4),
        selectedItemColor: HexColor(AppTheme.primaryColorString!),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset(
                "assets/images/Home.png",
                color: tabController.pageIndex.value == 0
                    ? HexColor(AppTheme.primaryColorString!)
                    : AppTheme.isLightTheme == false
                        ? const Color(0xffA2A0A8)
                        : HexColor(AppTheme.primaryColorString!)
                            .withOpacity(0.4),
              ),
            ),
            label: "หน้าแรก",
          ),
          // BottomNavigationBarItem(
          //   icon: SizedBox(
          //     width: MediaQuery.of(context).size.width * 0.06,
          //     child: Image.asset(
          //       "assets/images/Text_Documet.png",
          //       color: tabController.pageIndex.value == 1
          //           ? HexColor(AppTheme.primaryColorString!)
          //           : AppTheme.isLightTheme == false
          //               ? const Color(0xffA2A0A8)
          //               : HexColor(AppTheme.primaryColorString!)
          //                   .withOpacity(0.4),
          //     ),
          //   ),
          //   label: "งานบริการ",
          // ),
          BottomNavigationBarItem(
              icon: SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
                child: Image.asset(
                  "assets/images/Burger.png",
                  color: tabController.pageIndex.value == 1
                      ? HexColor(AppTheme.primaryColorString!)
                      : AppTheme.isLightTheme == false
                          ? const Color(0xffA2A0A8)
                          : HexColor(AppTheme.primaryColorString!)
                              .withOpacity(0.4),
                ),
              ),
              label: "การวิ่ง"),
          BottomNavigationBarItem(
              icon: SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
                child: Image.asset(
                  "assets/images/User.png",
                  color: tabController.pageIndex.value == 2
                      ? HexColor(AppTheme.primaryColorString!)
                      : AppTheme.isLightTheme == false
                          ? const Color(0xffA2A0A8)
                          : HexColor(AppTheme.primaryColorString!)
                              .withOpacity(0.4),
                ),
              ),
              label: "โปรไฟล์"),
        ],
      ),
      body: GetX<TabScreenController>(
        init: tabController,
        builder: (tabController) => tabController.pageIndex.value == 0
            ? HomeScreen(homeController: homeController)
            : tabController.pageIndex.value == 1
                ? const RunningScreen()
                : tabController.pageIndex.value == 2
                    ? const ProfileScreen()
                    : HomeScreen(homeController: homeController),
      ),
    );
  }

  // void showPopup() {
  //   showCupertinoModalPopup(
  //       context: context,
  //       builder: (BuildContext builder) {
  //         return CupertinoPopupSurface(
  //           isSurfacePainted: true,
  //           child: Container(
  //               padding: const EdgeInsetsDirectional.all(20),
  //               color: AppTheme.isLightTheme == false
  //                   ? HexColor('#323045')
  //                   : HexColor('#F3FBFB'),
  //               alignment: Alignment.center,
  //               width: MediaQuery.of(context).size.width,
  //               height: MediaQuery.of(context).copyWith().size.height * 0.22,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   // const SizedBox(
  //                   //   height: 20,
  //                   // ),
  //                   Text("เพิ่มคำร้อง",
  //                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
  //                           // color: Colors.black87,
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold)),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                           child: GestureDetector(
  //                         onTap: () {
  //                           Get.to(
  //                             const CreateNewIncidentScreen(),
  //                             transition: Transition.rightToLeft,
  //                             duration: const Duration(milliseconds: 500),
  //                           );
  //                         },
  //                         child: Container(
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: 15, horizontal: 10),
  //                           decoration: BoxDecoration(
  //                             color: AppTheme.isLightTheme == false
  //                                 ? HexColor('#15141f')
  //                                 : Theme.of(context)
  //                                     .appBarTheme
  //                                     .backgroundColor,
  //                             borderRadius: const BorderRadius.all(
  //                               Radius.circular(10),
  //                             ),
  //                             // border: Border.all(color: Colors.blueAccent),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: HexColor('#FE2121'),
  //                                 // blurRadius: 2,
  //                                 offset: Offset(4, 4), // Shadow position
  //                               ),
  //                             ],
  //                           ),
  //                           child: Row(
  //                             children: [
  //                               Expanded(
  //                                 flex: 0,
  //                                 child: Image.asset(
  //                                   "assets/images/UX_Writing.png",
  //                                   height: MediaQuery.of(context).size.height *
  //                                       0.05,
  //                                   // width:
  //                                   //     MediaQuery.of(context).size.width * 0.05,
  //                                   color: HexColor('#FE2121'),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 3)),
  //                               Expanded(
  //                                 child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: RichText(
  //                                       textAlign: TextAlign.center,
  //                                       text: TextSpan(children: <TextSpan>[
  //                                         TextSpan(
  //                                           text: "เพิ่มคำร้องแบบ",
  //                                           style: Theme.of(context)
  //                                               .textTheme
  //                                               .bodyText2!
  //                                               .copyWith(
  //                                                 fontSize: 16,
  //                                                 fontWeight: FontWeight.bold,
  //                                               ),
  //                                         ),
  //                                         TextSpan(
  //                                           text: " Incident",
  //                                           style: Theme.of(context)
  //                                               .textTheme
  //                                               .bodyText2!
  //                                               .copyWith(
  //                                                 fontSize: 17,
  //                                                 fontWeight: FontWeight.bold,
  //                                                 color: HexColor('#FE2121'),
  //                                               ),
  //                                         ),
  //                                       ]),
  //                                     )),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       )),
  //                       Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
  //                       Expanded(
  //                           child: GestureDetector(
  //                         onTap: () {
  //                           Get.to(
  //                             const CreateNewRequestScreen(),
  //                             transition: Transition.rightToLeft,
  //                             duration: const Duration(milliseconds: 500),
  //                           );
  //                         },
  //                         child: Container(
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: 15, horizontal: 10),
  //                           decoration: BoxDecoration(
  //                             color: AppTheme.isLightTheme == false
  //                                 ? HexColor('#15141f')
  //                                 : Theme.of(context)
  //                                     .appBarTheme
  //                                     .backgroundColor,
  //                             borderRadius: const BorderRadius.all(
  //                               Radius.circular(10),
  //                             ),
  //                             // border: Border.all(color: Colors.blueAccent),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: HexColor('#1DBF73'),
  //                                 // blurRadius: 5,
  //                                 offset: Offset(4, 4), // Shadow position
  //                               ),
  //                             ],
  //                           ),
  //                           child: Row(
  //                             children: [
  //                               Expanded(
  //                                 flex: 0,
  //                                 child: Image.asset(
  //                                   "assets/images/UX_Writing.png",
  //                                   height: MediaQuery.of(context).size.height *
  //                                       0.05,
  //                                   // width:
  //                                   //     MediaQuery.of(context).size.width * 0.05,
  //                                   color: HexColor('#1DBF73'),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 3)),
  //                               Expanded(
  //                                 child: Align(
  //                                     alignment: Alignment.center,
  //                                     child: RichText(
  //                                       textAlign: TextAlign.center,
  //                                       text: TextSpan(children: <TextSpan>[
  //                                         TextSpan(
  //                                           text: "เพิ่มคำร้องแบบ",
  //                                           style: Theme.of(context)
  //                                               .textTheme
  //                                               .bodyText2!
  //                                               .copyWith(
  //                                                 fontSize: 16,
  //                                                 fontWeight: FontWeight.bold,
  //                                               ),
  //                                         ),
  //                                         TextSpan(
  //                                           text: " Request",
  //                                           style: Theme.of(context)
  //                                               .textTheme
  //                                               .bodyText2!
  //                                               .copyWith(
  //                                                 fontSize: 17,
  //                                                 fontWeight: FontWeight.bold,
  //                                                 color: HexColor('#1DBF73'),
  //                                               ),
  //                                         ),
  //                                       ]),
  //                                     )),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       )),
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     height: 15,
  //                   ),
  //                 ],
  //               )),
  //         );
  //       });
  // }
}
