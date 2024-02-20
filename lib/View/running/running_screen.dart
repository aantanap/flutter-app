// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, prefer_const_constructors, unnecessary_import, non_constant_identifier_names
// import 'package:rems/view/menu/announcement/announce_screen.dart';
// import 'package:rems/view/menu/knowledge_base/knowledgeBase_screen.dart';
// import 'package:rems/view/menu/notifications/notifications_screen.dart';

import 'package:dotted_line/dotted_line.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rems/View/running/registerevent_screen.dart';
import 'package:rems/View/running/view_results.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:flutter/material.dart';
import '../../theme_old/config_theme/images.dart';
import '../notifications/notifications_screen.dart';
import '../setting/setting_screen.dart';

class RunningScreen extends StatefulWidget {
  const RunningScreen({super.key});
  @override
  State<RunningScreen> createState() => _RunningScreenState();
}

class _RunningScreenState extends State<RunningScreen> {
  final GlobalKey<ExpansionTileCardState> card3 = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.isLightTheme == false
          ? HexColor('#15141F')
          : HexColor(AppTheme.primaryColorString!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      const SettingScreen(),
                      transition: Transition.leftToRight,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  child: Image.asset(
                    "assets/images/Slider.png",
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                ),
                Text(
                  "กิจกรรมที่ลงทะเบียน",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                GestureDetector(
                  onTap: () async {
                    Get.to(
                      const NotificationsScreen(),
                      transition: Transition.upToDown,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  // onTap: () {
                    // Get.to(
                    //   ViewCaseIncidentScreen(
                    //     ticketID: listRequest[index].id!,
                    //   ),
                    //   transition: Transition.downToUp,
                    //   duration: const Duration(milliseconds: 500),
                    // );
                  // },
                  child: Image.asset(
                    "assets/images/Notification_No.png",
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            // child: RefreshIndicator(
            // onRefresh: () => _pullRefresh(),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.isLightTheme == false
                    ? const Color(0xff211F32)
                    : const Color(0xffFAF9FF),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Scrollbar(
                thickness: 5,
                radius: const Radius.circular(20),
                scrollbarOrientation: ScrollbarOrientation.right,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23, vertical: 5),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    // padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(height: 15),
                      Case1(),
                      const SizedBox(height: 15),
                      Case2(),
                      const SizedBox(height: 15),
                      // Case3(),
                      // const SizedBox(height: 15),
                      // Case4()
                    ],
                  ),
                ),
              ),
            ),
            // ),
          )
        ],
      ),
    );
  }

  Widget Case1() {
    return
        // ConstrainedBox(
        //   constraints: BoxConstraints(maxHeight: 1000),
        ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            // itemCount: listRequest.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5, bottom: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: AppTheme.isLightTheme == false
                          ? HexColor('#15141f')
                          : Theme.of(context).appBarTheme.backgroundColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#FFA6A6'),
                          // blurRadius: 2,
                          offset: const Offset(4, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/banner_run.jpg",
                                width: MediaQuery.of(context).size.width * 0.8,
                              ),
                            ),
                          ),
                        ),

                        ExpansionTileCard(
                          elevation: 0.0,
                          expandedTextColor: AppTheme.isLightTheme == false
                              ? const Color(0xffFFFFFF)
                              : const Color(0xff211F32),
                          baseColor: AppTheme.isLightTheme == false
                              ? const Color(0xff211F32)
                              : const Color(0xffFFFFFF),
                          expandedColor: AppTheme.isLightTheme == false
                              ? const Color(0xff211F32)
                              : const Color(0xffFFFFFF),
                          // key: cardA,
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // listRequest[index].format.toString(),
                                  "ชื่องาน",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: HexColor('#E0E7FD'),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    // listRequest[index].status.toString(),
                                    "กำลังดำเนินงาน",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor('#0437F2')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                "ประเภทงาน",
                                // listRequest[index].subject.toString() == ""
                                //     ? "-"
                                //     : listRequest[index].subject.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "วันที่:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        Text(
                                          "11 ม.ค. 2567",
                                          // listRequest[index]
                                          //     .createDate
                                          //     .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "จังหวัด:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        Text(
                                          "ปทุมธานี",
                                          // listRequest[index]
                                          //             .dueDate
                                          //             .toString() ==
                                          //         ""
                                          //     ? "-"
                                          //     : listRequest[index]
                                          //         .dueDate
                                          //         .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AppTheme.isLightTheme == false
                                        ? const Color(0xff323045)
                                        : const Color(0xffFFFFFF),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: DottedLine(
                                          dashLength: 8,
                                          lineThickness: 2,
                                          dashColor:
                                              AppTheme.isLightTheme == false
                                                  ? const Color(0xff353045)
                                                  : const Color(0xffF4F4F4),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "เวลา: ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                        TextSpan(
                                                          text:
                                                              "11:00 น. - 15:00 น.",
                                                          // listRequest[index]
                                                          //     .type,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: HexColor(
                                                                        '#FE2121'),
                                                                  ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "สถานที่: ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                        TextSpan(
                                                          text: "มทร.ธัญบุรี",
                                                          // listRequest[
                                                          //                 index]
                                                          //             .requester
                                                          //             .toString() ==
                                                          //         ""
                                                          //     ? "-"
                                                          //     : listRequest[
                                                          //             index]
                                                          //         .requester
                                                          //         .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: HexColor(
                                                                        '#111111'),
                                                                  ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                "รับสมัครถึงวันที่: ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                        TextSpan(
                                                          text: "30 ธ.ค. 2566",
                                                          // listRequest[
                                                          //                 index]
                                                          //             .technician ==
                                                          //         ""
                                                          //     ? "-"
                                                          //     : listRequest[
                                                          //             index]
                                                          //         .technician,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: HexColor(
                                                                        '#111111'),
                                                                  ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                const ViewResultsScreen(),
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                              );
                                            },
                                            // onTap: () {
                                            //   Future<RequestDataByID>?
                                            //       futureRequestDataByID;
                                            //   RequestDataByID requestDataByID =
                                            //       RequestDataByID();
                                            //   futureRequestDataByID =
                                            //       TicketAPI().getRequestData(
                                            //           listRequest[index].id!);
                                            //   futureRequestDataByID
                                            //       .then((value) async {
                                            //     setState(() {
                                            //       requestDataByID = value;
                                            //       Get.to(
                                            //         ViewCaseRequestScreen(
                                            //           requestDataByID:
                                            //               requestDataByID,
                                            //         ),
                                            //         transition:
                                            //             Transition.downToUp,
                                            //         duration: const Duration(
                                            //             milliseconds: 500),
                                            //       );
                                            //     });
                                            //   });
                                            // },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 7),
                                              decoration: BoxDecoration(
                                                color: HexColor('#F4F4F4'),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/search-file (1).png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.065,
                                                    color: HexColor('#FFA6A6'),
                                                  ),
                                                  const SizedBox(height: 3),
                                                  const Text(
                                                    "ดู",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff595959),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            });
    // );
  }

  Widget Case2() {
    return
        // ConstrainedBox(
        //   constraints: BoxConstraints(maxHeight: 1000),
        ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            // itemCount: listRequest.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5, bottom: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: AppTheme.isLightTheme == false
                          ? HexColor('#15141f')
                          : Theme.of(context).appBarTheme.backgroundColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#A5E5C7'),
                          // blurRadius: 2,
                          offset: const Offset(4, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/banner_run.jpg",
                                width: MediaQuery.of(context).size.width * 0.8,
                              ),
                            ),
                          ),
                        ),

                        ExpansionTileCard(
                          elevation: 0.0,
                          expandedTextColor: AppTheme.isLightTheme == false
                              ? const Color(0xffFFFFFF)
                              : const Color(0xff211F32),
                          baseColor: AppTheme.isLightTheme == false
                              ? const Color(0xff211F32)
                              : const Color(0xffFFFFFF),
                          expandedColor: AppTheme.isLightTheme == false
                              ? const Color(0xff211F32)
                              : const Color(0xffFFFFFF),
                          // key: cardA,
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // listRequest[index].format.toString(),
                                  "ชื่องาน",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: HexColor('#E0E7FD'),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    // listRequest[index].status.toString(),
                                    "ดำเนินงานเสร็จสิ้น",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor('#0437F2')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                "ประเภทงาน",
                                // listRequest[index].subject.toString() == ""
                                //     ? "-"
                                //     : listRequest[index].subject.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "วันที่:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        Text(
                                          "11 ม.ค. 2567",
                                          // listRequest[index]
                                          //     .createDate
                                          //     .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "จังหวัด:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        Text(
                                          "ปทุมธานี",
                                          // listRequest[index]
                                          //             .dueDate
                                          //             .toString() ==
                                          //         ""
                                          //     ? "-"
                                          //     : listRequest[index]
                                          //         .dueDate
                                          //         .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AppTheme.isLightTheme == false
                                        ? const Color(0xff323045)
                                        : const Color(0xffFFFFFF),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: DottedLine(
                                          dashLength: 8,
                                          lineThickness: 2,
                                          dashColor:
                                              AppTheme.isLightTheme == false
                                                  ? const Color(0xff353045)
                                                  : const Color(0xffF4F4F4),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "เวลา: ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                        TextSpan(
                                                          text:
                                                              "11:00 น. - 15:00 น.",
                                                          // listRequest[index]
                                                          //     .type,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: HexColor(
                                                                        '#1DBF73'),
                                                                  ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "สถานที่: ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                        TextSpan(
                                                          text: "มทร.ธัญบุรี",
                                                          // listRequest[
                                                          //                 index]
                                                          //             .requester
                                                          //             .toString() ==
                                                          //         ""
                                                          //     ? "-"
                                                          //     : listRequest[
                                                          //             index]
                                                          //         .requester
                                                          //         .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: HexColor(
                                                                        '#111111'),
                                                                  ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                "รับสมัครถึงวันที่: ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                        TextSpan(
                                                          text: "30 ธ.ค. 2566",
                                                          // listRequest[
                                                          //                 index]
                                                          //             .technician ==
                                                          //         ""
                                                          //     ? "-"
                                                          //     : listRequest[
                                                          //             index]
                                                          //         .technician,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: HexColor(
                                                                        '#111111'),
                                                                  ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                const ViewResultsScreen(),
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                              );
                                            },
                                            // onTap: () {
                                            //   Future<RequestDataByID>?
                                            //       futureRequestDataByID;
                                            //   RequestDataByID requestDataByID =
                                            //       RequestDataByID();
                                            //   futureRequestDataByID =
                                            //       TicketAPI().getRequestData(
                                            //           listRequest[index].id!);
                                            //   futureRequestDataByID
                                            //       .then((value) async {
                                            //     setState(() {
                                            //       requestDataByID = value;
                                            //       Get.to(
                                            //         ViewCaseRequestScreen(
                                            //           requestDataByID:
                                            //               requestDataByID,
                                            //         ),
                                            //         transition:
                                            //             Transition.downToUp,
                                            //         duration: const Duration(
                                            //             milliseconds: 500),
                                            //       );
                                            //     });
                                            //   });
                                            // },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 7),
                                              decoration: BoxDecoration(
                                                color: HexColor('#F4F4F4'),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/search-file (1).png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.065,
                                                    color: HexColor('#1DBF73'),
                                                  ),
                                                  const SizedBox(height: 3),
                                                  const Text(
                                                    "ดู",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff595959),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                const RegisterEventScreen(),
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                              );
                                            },
                                            // onTap: () {
                                            //   Future<RequestDataByID>?
                                            //       futureRequestDataByID;
                                            //   RequestDataByID requestDataByID =
                                            //       RequestDataByID();
                                            //   futureRequestDataByID =
                                            //       TicketAPI().getRequestData(
                                            //           listRequest[index].id!);
                                            //   futureRequestDataByID
                                            //       .then((value) async {
                                            //     setState(() {
                                            //       requestDataByID = value;
                                            //       Get.to(
                                            //         ViewCaseRequestScreen(
                                            //           requestDataByID:
                                            //               requestDataByID,
                                            //         ),
                                            //         transition:
                                            //             Transition.downToUp,
                                            //         duration: const Duration(
                                            //             milliseconds: 500),
                                            //       );
                                            //     });
                                            //   });
                                            // },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 7),
                                              decoration: BoxDecoration(
                                                color: HexColor('#F4F4F4'),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    AppTheme.isLightTheme ==
                                                            false
                                                        ? DefaultImages
                                                            .darkGallery
                                                        : DefaultImages.gallery,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    color: HexColor('#1DBF73'),
                                                  ),
                                                  const SizedBox(height: 3),
                                                  const Text(
                                                    "รูปภาพ",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff595959),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            });
    // );
  }
}
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppTheme.isLightTheme == false
//           ? HexColor('#15141F')
//           : HexColor(AppTheme.primaryColorString!),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 50),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     Get.to(
//                 //       const LoginScreen(),
//                 //       transition: Transition.downToUp,
//                 //       duration: const Duration(milliseconds: 500),
//                 //     );
//                 //   },
//                 //   child: Image.asset(
//                 //     "assets/images/Chevron_Left.png",
//                 //     width: MediaQuery.of(context).size.width * 0.07,
//                 //   ),
//                 // ),
//                 GestureDetector(
//                   onTap: () {
//                     Get.to(
//                       const SettingScreen(),
//                       transition: Transition.downToUp,
//                       duration: const Duration(milliseconds: 500),
//                     );
//                   },
//                   child: Image.asset(
//                     "assets/images/Slider.png",
//                     width: MediaQuery.of(context).size.width * 0.07,
//                   ),
//                 ),
//                 Text(
//                   "กิจกรรมที่ลงทะเบียน",
//                   style: Theme.of(context).textTheme.headline6!.copyWith(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 Image.asset(
//                   "assets/images/Notification_No.png",
//                   width: MediaQuery.of(context).size.width * 0.07,
//                   height: MediaQuery.of(context).size.height * 0.07,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//               child: Container(
//                   decoration: BoxDecoration(
//                     color: AppTheme.isLightTheme == false
//                         ? const Color(0xff211F32)
//                         : const Color(0xffFAF9FF),
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(24),
//                       topRight: Radius.circular(24),
//                     ),
//                   ),
//                   child: Scrollbar(
//                       thickness: 5,
//                       radius: const Radius.circular(20),
//                       scrollbarOrientation: ScrollbarOrientation.right,
//                       child: Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 23, vertical: 5),
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 color: AppTheme.isLightTheme == false
//                                     ? const Color(0xff211F32)
//                                     : const Color(0xffFAF9FF),
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(24),
//                                   topRight: Radius.circular(24),
//                                 ),
//                               ),

//                               // ConstrainedBox(
//                               //   constraints: BoxConstraints(maxHeight: 1000),
//                               child: ListView.builder(
//                                   physics: ScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemCount: 2,
//                                   // itemCount: listRequest.length,
//                                   itemBuilder: (context, index) {
//                                     return Column(
//                                       children: [
//                                         Container(
//                                           margin: EdgeInsets.only(
//                                               right: 5, bottom: 5),
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 5),
//                                           decoration: BoxDecoration(
//                                             color:
//                                                 AppTheme.isLightTheme == false
//                                                     ? HexColor('#15141f')
//                                                     : Theme.of(context)
//                                                         .appBarTheme
//                                                         .backgroundColor,
//                                             borderRadius:
//                                                 const BorderRadius.all(
//                                               Radius.circular(10),
//                                             ),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: HexColor('#FFA6A6'),
//                                                 // blurRadius: 2,
//                                                 offset: const Offset(
//                                                     4, 4), // Shadow position
//                                               ),
//                                             ],
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Expanded(
//                                                 flex: 0,
//                                                 child: Image.asset(
//                                                   "assets/images/person1.webp",
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.15,
//                                                 ),
//                                               ),
//                                               ExpansionTileCard(
//                                                 elevation: 0.0,
//                                                 expandedTextColor: AppTheme
//                                                             .isLightTheme ==
//                                                         false
//                                                     ? const Color(0xffFFFFFF)
//                                                     : const Color(0xff211F32),
//                                                 baseColor: AppTheme
//                                                             .isLightTheme ==
//                                                         false
//                                                     ? const Color(0xff211F32)
//                                                     : const Color(0xffFFFFFF),
//                                                 expandedColor: AppTheme
//                                                             .isLightTheme ==
//                                                         false
//                                                     ? const Color(0xff211F32)
//                                                     : const Color(0xffFFFFFF),
//                                                 // key: cardA,
//                                                 title: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: Text(
//                                                         // listRequest[index].format.toString(),
//                                                         "ชื่องาน",
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyText2
//                                                             ?.copyWith(
//                                                                 fontSize: 16,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       flex: 0,
//                                                       child: Container(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .symmetric(
//                                                                 vertical: 4,
//                                                                 horizontal: 10),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: HexColor(
//                                                               '#E0E7FD'),
//                                                           borderRadius:
//                                                               const BorderRadius
//                                                                   .all(
//                                                             Radius.circular(8),
//                                                           ),
//                                                         ),
//                                                         child: Text(
//                                                           // listRequest[index].status.toString(),
//                                                           "สถานะงาน",
//                                                           style: Theme.of(
//                                                                   context)
//                                                               .textTheme
//                                                               .bodyText2
//                                                               ?.copyWith(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color: HexColor(
//                                                                       '#0437F2')),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 subtitle: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     const SizedBox(height: 5),
//                                                     Text(
//                                                       "ประเภทงาน",
//                                                       // listRequest[index].subject.toString() == ""
//                                                       //     ? "-"
//                                                       //     : listRequest[index].subject.toString(),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyText2
//                                                           ?.copyWith(
//                                                               fontSize: 16,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .normal),
//                                                     ),
//                                                     const SizedBox(height: 5),
//                                                     Row(
//                                                       children: [
//                                                         Expanded(
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Text(
//                                                                 "วันที่:",
//                                                                 style: Theme.of(
//                                                                         context)
//                                                                     .textTheme
//                                                                     .bodyText2
//                                                                     ?.copyWith(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.normal),
//                                                               ),
//                                                               Text(
//                                                                 "11 ธ.ค. 2566",
//                                                                 // listRequest[index]
//                                                                 //     .createDate
//                                                                 //     .toString(),
//                                                                 style: Theme.of(
//                                                                         context)
//                                                                     .textTheme
//                                                                     .bodyText2
//                                                                     ?.copyWith(
//                                                                         fontSize:
//                                                                             14,
//                                                                         fontWeight:
//                                                                             FontWeight.normal),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Text(
//                                                                 "จัดโดย:",
//                                                                 style: Theme.of(
//                                                                         context)
//                                                                     .textTheme
//                                                                     .bodyText2
//                                                                     ?.copyWith(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.normal),
//                                                               ),
//                                                               Text(
//                                                                 "มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี",
//                                                                 // listRequest[index]
//                                                                 //             .dueDate
//                                                                 //             .toString() ==
//                                                                 //         ""
//                                                                 //     ? "-"
//                                                                 //     : listRequest[index]
//                                                                 //         .dueDate
//                                                                 //         .toString(),
//                                                                 style: Theme.of(
//                                                                         context)
//                                                                     .textTheme
//                                                                     .bodyText2
//                                                                     ?.copyWith(
//                                                                         fontSize:
//                                                                             14,
//                                                                         fontWeight:
//                                                                             FontWeight.normal),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 children: <Widget>[
//                                                   SizedBox(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                               .size
//                                                               .width,
//                                                       height:
//                                                           MediaQuery.of(context)
//                                                               .size
//                                                               .height,
//                                                       child: Container(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                     .symmetric(
//                                                                 horizontal: 15),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: AppTheme
//                                                                       .isLightTheme ==
//                                                                   false
//                                                               ? const Color(
//                                                                   0xff323045)
//                                                               : const Color(
//                                                                   0xffFFFFFF),
//                                                           borderRadius:
//                                                               const BorderRadius
//                                                                   .all(
//                                                             Radius.circular(10),
//                                                           ),
//                                                         ),
//                                                         child: Column(
//                                                           children: [
//                                                             const SizedBox(
//                                                                 height: 5),
//                                                             Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       25),
//                                                               child: DottedLine(
//                                                                 dashLength: 8,
//                                                                 lineThickness:
//                                                                     2,
//                                                                 dashColor: AppTheme
//                                                                             .isLightTheme ==
//                                                                         false
//                                                                     ? const Color(
//                                                                         0xff353045)
//                                                                     : const Color(
//                                                                         0xffF4F4F4),
//                                                               ),
//                                                             ),
//                                                             const SizedBox(
//                                                                 height: 10),
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceBetween,
//                                                               children: [
//                                                                 Column(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .centerLeft,
//                                                                       child:
//                                                                           RichText(
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         text: TextSpan(
//                                                                             children: <TextSpan>[
//                                                                               TextSpan(
//                                                                                   text: "ชนิดคำร้อง: ",
//                                                                                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                                                         fontSize: 14,
//                                                                                         fontWeight: FontWeight.normal,
//                                                                                       )),
//                                                                               TextSpan(
//                                                                                 text: "Null",
//                                                                                 // listRequest[index]
//                                                                                 //     .type,
//                                                                                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                                                       fontSize: 14,
//                                                                                       fontWeight: FontWeight.normal,
//                                                                                       color: HexColor('#FE2121'),
//                                                                                     ),
//                                                                               ),
//                                                                             ]),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height: 3,
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .centerLeft,
//                                                                       child:
//                                                                           RichText(
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         text: TextSpan(
//                                                                             children: <TextSpan>[
//                                                                               TextSpan(
//                                                                                   text: "ผู้ร้องขอ: ",
//                                                                                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                                                         fontSize: 14,
//                                                                                         fontWeight: FontWeight.normal,
//                                                                                       )),
//                                                                               TextSpan(
//                                                                                 text: "Null",
//                                                                                 // listRequest[
//                                                                                 //                 index]
//                                                                                 //             .requester
//                                                                                 //             .toString() ==
//                                                                                 //         ""
//                                                                                 //     ? "-"
//                                                                                 //     : listRequest[
//                                                                                 //             index]
//                                                                                 //         .requester
//                                                                                 //         .toString(),
//                                                                                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                                                       fontSize: 14,
//                                                                                       fontWeight: FontWeight.normal,
//                                                                                       color: HexColor('#111111'),
//                                                                                     ),
//                                                                               ),
//                                                                             ]),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       height: 3,
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .centerLeft,
//                                                                       child:
//                                                                           RichText(
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         text: TextSpan(
//                                                                             children: <TextSpan>[
//                                                                               TextSpan(
//                                                                                   text: "ผู้ให้บริการ: ",
//                                                                                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                                                         fontSize: 14,
//                                                                                         fontWeight: FontWeight.normal,
//                                                                                       )),
//                                                                               TextSpan(
//                                                                                 text: "Null",
//                                                                                 // listRequest[
//                                                                                 //                 index]
//                                                                                 //             .technician ==
//                                                                                 //         ""
//                                                                                 //     ? "-"
//                                                                                 //     : listRequest[
//                                                                                 //             index]
//                                                                                 //         .technician,
//                                                                                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                                                                                       fontSize: 14,
//                                                                                       fontWeight: FontWeight.normal,
//                                                                                       color: HexColor('#111111'),
//                                                                                     ),
//                                                                               ),
//                                                                             ]),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                                 GestureDetector(
//                                                                   // onTap: () {
//                                                                   //   Future<RequestDataByID>?
//                                                                   //       futureRequestDataByID;
//                                                                   //   RequestDataByID requestDataByID =
//                                                                   //       RequestDataByID();
//                                                                   //   futureRequestDataByID =
//                                                                   //       TicketAPI().getRequestData(
//                                                                   //           listRequest[index].id!);
//                                                                   //   futureRequestDataByID
//                                                                   //       .then((value) async {
//                                                                   //     setState(() {
//                                                                   //       requestDataByID = value;
//                                                                   //       Get.to(
//                                                                   //         ViewCaseRequestScreen(
//                                                                   //           requestDataByID:
//                                                                   //               requestDataByID,
//                                                                   //         ),
//                                                                   //         transition:
//                                                                   //             Transition.downToUp,
//                                                                   //         duration: const Duration(
//                                                                   //             milliseconds: 500),
//                                                                   //       );
//                                                                   //     });
//                                                                   //   });
//                                                                   // },
//                                                                   child:
//                                                                       Container(
//                                                                     padding: const EdgeInsets
//                                                                             .symmetric(
//                                                                         horizontal:
//                                                                             10,
//                                                                         vertical:
//                                                                             7),
//                                                                     decoration:
//                                                                         BoxDecoration(
//                                                                       color: HexColor(
//                                                                           '#F4F4F4'),
//                                                                       borderRadius:
//                                                                           const BorderRadius
//                                                                               .all(
//                                                                         Radius.circular(
//                                                                             10),
//                                                                       ),
//                                                                     ),
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         Image
//                                                                             .asset(
//                                                                           "assets/images/search-file (1).png",
//                                                                           width:
//                                                                               MediaQuery.of(context).size.width * 0.065,
//                                                                           color:
//                                                                               HexColor('#FFA6A6'),
//                                                                         ),
//                                                                         const SizedBox(
//                                                                             height:
//                                                                                 3),
//                                                                         const Text(
//                                                                           "ดูคำร้อง",
//                                                                           style: TextStyle(
//                                                                               color: Color(0xff595959),
//                                                                               fontSize: 14,
//                                                                               fontWeight: FontWeight.w600),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       )),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         )
//                                       ],
//                                     );
//                                   })))
//                       //   child: Padding(
//                       //     padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
//                       //     child: Scrollbar(
//                       //       thickness: 5,
//                       //       radius: const Radius.circular(20),
//                       //       scrollbarOrientation: ScrollbarOrientation.right,
//                       //       child: ListView(
//                       //         physics: const ClampingScrollPhysics(),
//                       //         padding: EdgeInsets.zero,
//                       //         children: [
//                       //           const SizedBox(
//                       //             height: 10,
//                       //           ),
//                       //           Row(
//                       //             children: [
//                       //               Expanded(
//                       //                   child: GestureDetector(
//                       //                 onTap: () {
//                       //                   // Get.to(
//                       //                   //   const KnowledgebaseScreen(),
//                       //                   //   transition: Transition.downToUp,
//                       //                   //   duration: const Duration(milliseconds: 500),
//                       //                   // );
//                       //                 },
//                       //                 child: Container(
//                       //                     padding: const EdgeInsets.symmetric(
//                       //                         vertical: 20, horizontal: 15),
//                       //                     decoration: BoxDecoration(
//                       //                       color: Colors.white,
//                       //                       borderRadius: const BorderRadius.all(
//                       //                         Radius.circular(15),
//                       //                       ),
//                       //                     ),
//                       //                     child: Column(
//                       //                       children: [
//                       //                         Image.asset(
//                       //                           "assets/images/bt3_megaphone.png",
//                       //                           width: MediaQuery.of(context).size.width *
//                       //                               0.18,
//                       //                         ),
//                       //                         const SizedBox(
//                       //                           height: 10,
//                       //                         ),
//                       //                         Text(
//                       //                           "ฐานความรู้",
//                       //                           style: Theme.of(context)
//                       //                               .textTheme
//                       //                               .headline6!
//                       //                               .copyWith(
//                       //                                 fontSize: 16,
//                       //                                 fontWeight: FontWeight.bold,
//                       //                               ),
//                       //                         ),
//                       //                         const SizedBox(
//                       //                           height: 3,
//                       //                         ),
//                       //                         Text(
//                       //                           "(Knowledge base)",
//                       //                           style: Theme.of(context)
//                       //                               .textTheme
//                       //                               .headline6!
//                       //                               .copyWith(
//                       //                                 fontSize: 12,
//                       //                                 fontWeight: FontWeight.bold,
//                       //                               ),
//                       //                         ),
//                       //                       ],
//                       //                     )),
//                       //               )),
//                       //               Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
//                       //               Expanded(
//                       //                   child: Container(
//                       //                       padding: const EdgeInsets.symmetric(
//                       //                           vertical: 20, horizontal: 15),
//                       //                       decoration: BoxDecoration(
//                       //                         color: Colors.white,
//                       //                         borderRadius: const BorderRadius.all(
//                       //                           Radius.circular(15),
//                       //                         ),
//                       //                       ),
//                       //                       child: Column(
//                       //                         children: [
//                       //                           Image.asset(
//                       //                             "assets/images/bt3_megaphone.png",
//                       //                             width: MediaQuery.of(context).size.width *
//                       //                                 0.18,
//                       //                           ),
//                       //                           const SizedBox(
//                       //                             height: 10,
//                       //                           ),
//                       //                           Text(
//                       //                             "คำถามที่พบบ่อย",
//                       //                             style: Theme.of(context)
//                       //                                 .textTheme
//                       //                                 .headline6!
//                       //                                 .copyWith(
//                       //                                   fontSize: 16,
//                       //                                   fontWeight: FontWeight.bold,
//                       //                                 ),
//                       //                           ),
//                       //                           const SizedBox(
//                       //                             height: 3,
//                       //                           ),
//                       //                           Text(
//                       //                             "(FAQs)",
//                       //                             style: Theme.of(context)
//                       //                                 .textTheme
//                       //                                 .headline6!
//                       //                                 .copyWith(
//                       //                                   fontSize: 12,
//                       //                                   fontWeight: FontWeight.bold,
//                       //                                 ),
//                       //                           ),
//                       //                         ],
//                       //                       ))),
//                       //             ],
//                       //           ),
//                       //           const SizedBox(
//                       //             height: 20,
//                       //           ),
//                       //           Row(
//                       //             children: [
//                       //               Expanded(
//                       //                   child: GestureDetector(
//                       //                 onTap: () {
//                       //                   // Get.to(
//                       //                   //   const AnnouncementScreen(),
//                       //                   //   transition: Transition.downToUp,
//                       //                   //   duration: const Duration(milliseconds: 500),
//                       //                   // );
//                       //                 },
//                       //                 child: Container(
//                       //                     padding: const EdgeInsets.symmetric(
//                       //                         vertical: 20, horizontal: 15),
//                       //                     decoration: BoxDecoration(
//                       //                       color: Colors.white,
//                       //                       borderRadius: const BorderRadius.all(
//                       //                         Radius.circular(15),
//                       //                       ),
//                       //                     ),
//                       //                     child: Column(
//                       //                       children: [
//                       //                         Image.asset(
//                       //                           "assets/images/bt3_megaphone.png",
//                       //                           width: MediaQuery.of(context).size.width *
//                       //                               0.18,
//                       //                         ),
//                       //                         const SizedBox(
//                       //                           height: 10,
//                       //                         ),
//                       //                         Text(
//                       //                           "ประกาศต่าง ๆ",
//                       //                           style: Theme.of(context)
//                       //                               .textTheme
//                       //                               .headline6!
//                       //                               .copyWith(
//                       //                                 fontSize: 16,
//                       //                                 fontWeight: FontWeight.bold,
//                       //                               ),
//                       //                         ),
//                       //                         const SizedBox(
//                       //                           height: 3,
//                       //                         ),
//                       //                         Text(
//                       //                           "(Announcement)",
//                       //                           style: Theme.of(context)
//                       //                               .textTheme
//                       //                               .headline6!
//                       //                               .copyWith(
//                       //                                 fontSize: 12,
//                       //                                 fontWeight: FontWeight.bold,
//                       //                               ),
//                       //                         ),
//                       //                       ],
//                       //                     )),
//                       //               )),
//                       //               Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
//                       //               Expanded(
//                       //                   child: GestureDetector(
//                       //                 onTap: () {
//                       //                   // Get.to(
//                       //                   //   const NotificationsScreen(),
//                       //                   //   transition: Transition.downToUp,
//                       //                   //   duration: const Duration(milliseconds: 500),
//                       //                   // );
//                       //                 },
//                       //                 child: Container(
//                       //                     padding: const EdgeInsets.symmetric(
//                       //                         vertical: 20, horizontal: 15),
//                       //                     decoration: BoxDecoration(
//                       //                       color: Colors.white,
//                       //                       borderRadius: const BorderRadius.all(
//                       //                         Radius.circular(15),
//                       //                       ),
//                       //                     ),
//                       //                     child: Column(
//                       //                       children: [
//                       //                         Image.asset(
//                       //                           "assets/images/bt3_megaphone.png",
//                       //                           width: MediaQuery.of(context).size.width *
//                       //                               0.18,
//                       //                         ),
//                       //                         const SizedBox(
//                       //                           height: 10,
//                       //                         ),
//                       //                         Text(
//                       //                           "การแจ้งเตือน",
//                       //                           style: Theme.of(context)
//                       //                               .textTheme
//                       //                               .headline6!
//                       //                               .copyWith(
//                       //                                 fontSize: 16,
//                       //                                 fontWeight: FontWeight.bold,
//                       //                               ),
//                       //                         ),
//                       //                         const SizedBox(
//                       //                           height: 3,
//                       //                         ),
//                       //                         Text(
//                       //                           "(Notifications)",
//                       //                           style: Theme.of(context)
//                       //                               .textTheme
//                       //                               .headline6!
//                       //                               .copyWith(
//                       //                                 fontSize: 12,
//                       //                                 fontWeight: FontWeight.bold,
//                       //                               ),
//                       //                         ),
//                       //                       ],
//                       //                     )),
//                       //               )),
//                       //             ],
//                       //           ),
//                       //         ],
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ))
//                       )))
//         ],
//       ),
//     );
//   }
// }

