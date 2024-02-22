// import 'dart:async';
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'package:finpay/model/data/data_model.dart';
// import 'package:finpay/model/ticket/ticket_model.dart';
// import 'package:finpay/services/ticket/ticket_api.dart';
// import 'package:finpay/theme_old/config_theme/textstyle.dart';
// import 'package:finpay/theme_old/view_theme/profile/setting_screen.dart';
// import 'package:finpay/view/request/view_case/viewcase_incident.dart';
// import 'package:finpay/view/request/view_case/viewcase_request.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../menu/knowledge_base/knowledgeBase_detail_screen.dart';

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, deprecated_member_use, unnecessary_import

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:rems/theme_old/controller_theme/home_controller.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../theme_old/widgets_theme/custom_buttom.dart';
import '../notifications/notifications_screen.dart';
import '../running/registerevent_screen.dart';
import '../setting/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  final HomeController homeController;
  const HomeScreen({super.key, required this.homeController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final List<GlobalObjectKey<FormState>> formKeyList =
      List.generate(10, (index) => GlobalObjectKey<FormState>(index));
  // final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  final GlobalKey<ExpansionTileCardState> card3 = GlobalKey();
  // final GlobalKey<ExpansionTileCardState> card4 = GlobalKey();
  final selectStatusCtrl = TextEditingController();

  int? id = 0;

  // Future<List<RequestLists>>? futureRequest;
  // List<RequestLists> listRequest = [];
  // RequestLists Request = RequestLists();

  // Future<void> _pullRefresh() async {
  //   futureRequest = TicketAPI().GetRequestLists();
  //   futureRequest!.then((value) async {
  //     setState(() {
  //       listRequest = value;
  //       selectStatusCtrl.clear();
  //     });
  //   });
  //   print(listRequest);
  // }

  // @override
  // void initState() {
  //   futureRequest = TicketAPI().GetRequestLists();
  //   futureRequest!.then((value) async {
  //     setState(() {
  //       listRequest = value;
  //       print(listRequest);
  //     });
  //   });
  //   super.initState();
  // }

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
                  "กิจกรรม",
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
                      
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown.search(
                              hintText: 'ชื่องาน',
                              hintStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xffF4F4F4)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              items: const [
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                              ],
                              controller: selectStatusCtrl,
                              fillColor: AppTheme.isLightTheme == false
                                  ? const Color(0xff353045)
                                  : const Color(0xffF4F4F4),
                              selectedStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xffF4F4F4)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              listItemStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xff353045)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              excludeSelected: false,
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Expanded(
                            child: CustomDropdown.search(
                              hintText: 'ระยะทาง',
                              hintStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xffF4F4F4)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              items: const [
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                              ],
                              controller: selectStatusCtrl,
                              fillColor: AppTheme.isLightTheme == false
                                  ? const Color(0xff353045)
                                  : const Color(0xffF4F4F4),
                              selectedStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xffF4F4F4)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              listItemStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xff353045)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              excludeSelected: false,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdown.search(
                              hintText: 'วันที่',
                              hintStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xffF4F4F4)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              items: const [
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                              ],
                              controller: selectStatusCtrl,
                              fillColor: AppTheme.isLightTheme == false
                                  ? const Color(0xff353045)
                                  : const Color(0xffF4F4F4),
                              selectedStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xffF4F4F4)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              listItemStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xff353045)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              excludeSelected: false,
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Expanded(
                            child: CustomDropdown.search(
                              hintText: 'จังหวัด',
                              hintStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xffF4F4F4)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              items: const [
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                                'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                              ],
                              controller: selectStatusCtrl,
                              fillColor: AppTheme.isLightTheme == false
                                  ? const Color(0xff353045)
                                  : const Color(0xffF4F4F4),
                              selectedStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xffF4F4F4)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              listItemStyle: TextStyle(
                                  color: AppTheme.isLightTheme == false
                                      ? const Color(0xff353045)
                                      : const Color(0xff353045),
                                  fontSize: 16),
                              excludeSelected: false,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      customButton(
                          HexColor(AppTheme.primaryColorString!),
                          "ค้นหา",
                          HexColor(AppTheme.secondaryColorString!),
                          context),

                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: DottedLine(
                          dashLength: 10,
                          lineThickness: 2,
                          dashColor: AppTheme.isLightTheme == false
                              ? const Color(0xff353045)
                              : const Color(0xffF4F4F4),
                        ),
                      ),

                      const SizedBox(height: 15),
                      Case1(),
                      const SizedBox(height: 15),
                      // Case2(),
                      // const SizedBox(height: 15),
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
                                "ระยะทาง",
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
                                                    "สมัคร",
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
    return Container(
      margin: EdgeInsets.only(right: 5),
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
            key: card3,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    "ชื่องาน",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
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
                          "ดำเนินการเสร็จสิ้น",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#0437F2')),
                        )))
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  "ประเภทงาน",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "วันที่ :",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "15 พ.ย. 2566",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "จังหวัด:",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "ปทุมธานี",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
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
                  // height: MediaQuery.of(context).size.height,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: DottedLine(
                            dashLength: 8,
                            lineThickness: 2,
                            dashColor: AppTheme.isLightTheme == false
                                ? const Color(0xff353045)
                                : const Color(0xffF4F4F4),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "เวลา: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      )),
                              TextSpan(
                                text: "11:00 น. - 15:00 น.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: HexColor('#1DBF73'),
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
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "สถานที่: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      )),
                              TextSpan(
                                text: "มทร.ธัญบุรี",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: HexColor('#111111'),
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
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "รับสมัครเมื่อ: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      )),
                              TextSpan(
                                text: "10 ต.ค. 2566",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: HexColor('#111111'),
                                    ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
