// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use, unused_import, non_constant_identifier_names, prefer_const_constructors

import 'package:rems/theme_old/config_theme/images.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:rems/theme_old/controller_theme/signup_controller.dart';
import 'package:rems/theme_old/widgets_theme/custom_buttom.dart';
import 'package:rems/theme_old/widgets_theme/custom_textfield.dart';
import 'package:rems/theme_old/widgets_theme/custom_textformfield.dart';
// import 'package:rems/view/login/login_screen.dart';
// import 'package:rems/view/menu/announcement/announce_detail_screen.dart';
// import 'package:rems/view/menu/knowledge_base/knowledgeBase_detail_screen.dart';
// import 'package:rems/view/request/view_case/viewcase_incident.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:timelines/timelines.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
import 'package:dotted_border/dotted_border.dart';

import '../running/view_results.dart';

const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff1DB7AF);
const todoColor = Color(0xffd1d2d7);

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final createNewRequestController = Get.put(CreateNewRequestController());
  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = <String>[];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    items = duplicateItems;

    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.isLightTheme == false
            ? const Color(0xff15141F)
            : const Color(0xffFAF9FF),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.095,
          title: Column(
            children: [
              Text(
                "การแจ้งเตือน",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppTheme.isLightTheme == false
              ? const Color(0xff15141F)
              : const Color(0xffFAF9FF),
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
        ),
        body: WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
          child: InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
              padding: const EdgeInsets.only(
                // top: 10,
                bottom: 20,
                right: 15,
                left: 15,
              ),
              child: Card(
                elevation: 0,
                color: AppTheme.isLightTheme == false
                    ? const Color(0xff211F32)
                    : const Color(0xffFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Section1(),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Section2(),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }

  Widget Section1() {
    return Expanded(
        flex: 0,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: HexColor('#E9F8F7'),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Row(
            children: [
              Expanded(flex: 1, child: Center()),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 13),
                  child: CustomTextFormFieldSearch(
                    radius: 25,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    cursorColor: HexColor("#1DB7AF"),
                    suffixIconColor: HexColor("#1DB7AF"),
                    focusNode: _focusNodes[0],
                    hintText: "ค้นหา",
                    inputType: TextInputType.text,
                    textEditingController: editingController,
                    capitalization: TextCapitalization.words,
                    maxLine: 1,
                    sufix: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget Section2() {
    return Expanded(
        child: Scrollbar(
            thickness: 5,
            radius: const Radius.circular(20),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      ListDetail(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: DottedLine(
                          dashLength: 10,
                          lineThickness: 2,
                          dashColor: AppTheme.isLightTheme == false
                              ? const Color(0xff353045)
                              : const Color(0xffF4F4F4),
                        ),
                      ),
                      ListDetail(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: DottedLine(
                          dashLength: 10,
                          lineThickness: 2,
                          dashColor: AppTheme.isLightTheme == false
                              ? const Color(0xff353045)
                              : const Color(0xffF4F4F4),
                        ),
                      ),
                    ],
                  )
                ])));
  }

  Widget ListDetail() {
    return GestureDetector(
      onTap: () {
        // Get.to(
        //   const ViewCaseIncidentScreen(),
        //   transition: Transition.leftToRight,
        //   duration: const Duration(milliseconds: 500),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Text(
                      "ระบบได้รับคำร้อง แจ้งซ่อมอุปกรณ์หมายเลข 25660608-184 ของท่านแล้วหัวข้อ: SKI สถาะนะการดำเนินงาน: Open, ข้อมูลอาการ: พัง",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Row(children: [
                          Image.asset(
                            "assets/images/Calendar_1.png",
                            width: MediaQuery.of(context).size.width * 0.05,
                            color: HexColor('#1DB7AF'),
                          ),
                          Text(
                            "  26 ก.ย. 2565 เวลา 15.11 น.",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                          )
                        ])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  const ViewResultsScreen(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 500),
                );
              },
              child: Expanded(
                flex: 0,
                child: Image.asset(
                  "assets/images/Chevron_Right.png",
                  width: MediaQuery.of(context).size.width * 0.08,
                  color: HexColor('#1DB7AF'),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
