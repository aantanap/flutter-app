// ignore_for_file: prefer_const_constructors, deprecated_member_use, non_constant_identifier_names, unnecessary_import, avoid_function_literals_in_foreach_calls

// import 'package:dotted_line/dotted_line.dart';
// import 'package:rems/theme_old/config_theme/images.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:rems/theme_old/widgets_theme/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../../theme_old/config_theme/images.dart';
import '../../theme_old/view_theme/profile/upload_photo_screen.dart';
import '../../theme_old/widgets_theme/custom_buttom.dart';
import '../notifications/notifications_screen.dart';
import '../setting/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<String> profileData;
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    profileData = fetchProfileData();
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<String> fetchProfileData() async {
    // Replace this with your actual data retrieval logic
    await Future.delayed(Duration(seconds: 2));
    return "Your Profile Data";
  }

  int _selectedIndex = 0;
  TextEditingController editFirstNameController = TextEditingController();
  TextEditingController editLastNameController = TextEditingController();
  TextEditingController editPasswordController = TextEditingController();
  TextEditingController editEmployeeIDController = TextEditingController();
  TextEditingController editPositionController = TextEditingController();
  TextEditingController editBirthDayController = TextEditingController();

  TextEditingController editEmailController = TextEditingController();
  TextEditingController editAlternateEmailController = TextEditingController();
  TextEditingController editOfficePhoneController = TextEditingController();
  TextEditingController editNationalIDController = TextEditingController();

  TextEditingController editLocationController = TextEditingController();
  TextEditingController editBuildingController = TextEditingController();
  TextEditingController editAddressController = TextEditingController();
  TextEditingController editTypeIDController = TextEditingController();
  TextEditingController editDepartmentController = TextEditingController();
  TextEditingController editLayerController = TextEditingController();
  TextEditingController editMore1Controller = TextEditingController();
  TextEditingController editMore2Controller = TextEditingController();

  final selectStatusCtrl = TextEditingController();

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
                  "โปรไฟล์",
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
                ))
                
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: AppTheme.isLightTheme == false
                  ? const Color(0xff211F32)
                  : const Color(0xffFAF9FF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: WillPopScope(
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
                child: Card(
                  elevation: 0,
                  color: AppTheme.isLightTheme == false
                      ? const Color(0xff211F32)
                      : const Color(0xffFAF9FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppTheme.isLightTheme == false
                                ? const Color(0xffF5F7FE)
                                : HexColor(AppTheme.primaryColorString!)
                                    .withOpacity(0.05),
                            foregroundImage: const AssetImage(
                              DefaultImages.profile,
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                Get.to(
                                  const UploadPhotoScreen(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              child: SizedBox(
                                height: 28,
                                width: 28,
                                child: SvgPicture.asset(
                                  DefaultImages.camera,
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "รูปโปรไฟล์",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      FutureBuilder<String>(
                        future: profileData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While data is being fetched, you can show a loading indicator or a placeholder
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // If an error occurs during data retrieval, handle it here
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // If data is successfully retrieved, update the Text widget
                            return Text(
                              'Profile Data: ${snapshot.data}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Header(),
                      _selectedIndex == 0
                          ? profile()
                          : _selectedIndex == 1
                              ? contact()
                              : address()
                    ],
                  ),
                  // Expanded(child: Text("hi"))
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget Header() {
    return Expanded(
        flex: 0,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: HexColor('#F4F4F4'),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                    gap: 1,
                    activeColor: _selectedIndex == 0
                        ? HexColor('#5875bc')
                        : _selectedIndex == 1
                            ? HexColor('#5875bc')
                            : HexColor('#5875bc'),
                    iconSize: 24,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: _selectedIndex == 0
                        ? HexColor('#E6EFFE')
                        : _selectedIndex == 1
                            ? HexColor('#E6EFFE')
                            : HexColor('#E6EFFE'),
                    // color: Colors.black,
                    tabs: [
                      GButton(
                        icon: LineIcons.user,
                        iconColor: HexColor('#f27091'),
                        text: 'ข้อมูลผู้ใช้',
                      ),
                      GButton(
                        icon: LineIcons.phone,
                        iconColor: HexColor('#21723e'),
                        text: 'ติดต่อ',
                      ),
                      GButton(
                        icon: LineIcons.mapPin,
                        iconColor: HexColor('#ead415'),
                        text: 'ที่อยู่',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
              // ),
            ],
          ),
        ));
  }

  Widget profile() {
    return Expanded(
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Scrollbar(
            thickness: 5,
            radius: const Radius.circular(20),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: RichText(
                        //       textAlign: TextAlign.left,
                        //       text: TextSpan(children: <TextSpan>[
                        //         TextSpan(
                        //             text: "รูปโปรไฟล์",
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyText2!
                        //                 .copyWith(
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.bold,
                        //                 )),
                        //       ]),
                        //     )),
                        //     Column(
                        //   children: [
                        //     Expanded(
                        //       flex: 0,
                        //       child: Image.asset(
                        //         "assets/images/person1.webp",
                        //         width: MediaQuery.of(context).size.width * 0.5,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "ชื่อ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        // const SizedBox(height: 3),
                        CustomTextFormFieldProfile(
                            radius: 25,
                            onChanged: (value) {
                              // filterSearchResults(value);
                            },
                            cursorColor: HexColor("#AF87DA"),
                            suffixIconColor: HexColor("#AF87DA"),
                            focusNode: _focusNodes[0],
                            hintText: "ชื่อ",
                            inputType: TextInputType.text,
                            textEditingController: editFirstNameController,
                            capitalization: TextCapitalization.words,
                            maxLine: 1,
                            sufix: Icon(Icons.edit)),
                        // CustomDropdown.search(
                        //   hintText: 'เลือก',
                        //   hintStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   items: const [
                        //     'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                        //     'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                        //     'มหาวิทยาลัยเทคโนโลยีราชมงคลธัญบุรี',
                        //   ],
                        //   controller: selectStatusCtrl,
                        //   fillColor: AppTheme.isLightTheme == false
                        //       ? const Color(0xff353045)
                        //       : const Color(0xffF4F4F4),
                        //   selectedStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   listItemStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xff353045)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   excludeSelected: false,
                        // ),
                        // CustomDropdown.search(
                        //   hintText: 'เลือก',
                        //   hintStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   items: subjectsItems.isEmpty ? nullItems : subjectsItems,
                        //   controller: selectSubjectCtrl,
                        //   onChanged: (x) {
                        //     if (x.isNotEmpty) {
                        //       var result =
                        //           listSubject.where((element) => element.name == x);
                        //       departmentID = result.last.id;
                        //       print("departmentID = " + departmentID.toString());
                        //     }
                        //   },
                        //   fillColor: AppTheme.isLightTheme == false
                        //       ? const Color(0xff353045)
                        //       : const Color(0xffF4F4F4),
                        //   selectedStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   listItemStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xff353045)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   excludeSelected: false,
                        // ),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "นามสกุล",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: RichText(
                        //       textAlign: TextAlign.left,
                        //       text: TextSpan(children: <TextSpan>[
                        //         TextSpan(
                        //             text: "นามสกุล:",
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyText2!
                        //                 .copyWith(
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.bold,
                        //                 )),
                        //       ]),
                        //     )),
                        CustomTextFormFieldProfile(
                          radius: 25,
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          cursorColor: HexColor("#AF87DA"),
                          suffixIconColor: HexColor("#AF87DA"),
                          focusNode: _focusNodes[1],
                          hintText: "นามสกุล",
                          inputType: TextInputType.text,
                          textEditingController: editLastNameController,
                          capitalization: TextCapitalization.words,
                          maxLine: 1,
                          sufix: Icon(Icons.edit),
                        ),
                        // CustomDropdown.search(
                        //   hintText: 'เลือก',
                        //   hintStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   items: provinceItems.isEmpty ? nullItems : provinceItems,
                        //   controller: selectProvinceCtrl,
                        //   onChanged: (x) {
                        //     if (x.isNotEmpty) {
                        //       var result =
                        //           listProvince.where((element) => element.name == x);
                        //       province = result.last.id;
                        //       print("province = " + province.toString());
                        //     }
                        //   },
                        //   fillColor: AppTheme.isLightTheme == false
                        //       ? const Color(0xff353045)
                        //       : const Color(0xffF4F4F4),
                        //   selectedStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   listItemStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xff353045)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   excludeSelected: false,
                        // ),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "เพศ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),

                        CustomDropdown(
                          hintText: 'เลือก',
                          hintStyle: TextStyle(
                              color: AppTheme.isLightTheme == false
                                  ? const Color(0xffF4F4F4)
                                  : const Color(0xff353045),
                              fontSize: 16),
                          items: const [
                            'ชาย',
                            'หญิง',
                            'ไม่ระบุ',
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
                        // CustomDropdown.search(
                        //   hintText: 'เลือก',
                        //   hintStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   items: categoryItems.isEmpty ? nullItems : categoryItems,
                        //   controller: selectCategoryCtrl,
                        //   onChanged: (x) {
                        //     selectSubCategoryCtrl.text = "";
                        //     _isShowSubCategory = false;
                        //     if (x.isNotEmpty) {
                        //       var result =
                        //           listCategory.where((element) => element.name == x);
                        //       parentID = result.last.id;
                        //       _isShowSubCategory = true;
                        //       futureSubCategory =
                        //           DataAPI().getCategoryDefaultList(parentID!);
                        //       futureSubCategory!.then((value) async {
                        //         setState(() {
                        //           listSubCategory = value;
                        //           if (listSubCategory.isNotEmpty) {
                        //             subcategoryItems.clear();
                        //             subcategoryIDItems.clear();
                        //             for (var i in value) {
                        //               String? name = i.name;
                        //               int? id = i.id;
                        //               subcategoryItems.add(name!);
                        //               subcategoryIDItems.add(id!);
                        //             }
                        //           }
                        //         });
                        //       });
                        //       print("parentID = " + parentID.toString());
                        //       print(_isShowSubCategory);
                        //       print(x);
                        //     }
                        //   },
                        //   fillColor: AppTheme.isLightTheme == false
                        //       ? const Color(0xff353045)
                        //       : const Color(0xffF4F4F4),
                        //   selectedStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   listItemStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xff353045)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   excludeSelected: false,
                        // ),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "วันเดือนปีเกิด",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        CustomTextFormFieldProfile(
                          radius: 25,
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          cursorColor: HexColor("#AF87DA"),
                          suffixIconColor: HexColor("#AF87DA"),
                          focusNode: _focusNodes[3],
                          hintText: "วันเดือนปีเกิด",
                          inputType: TextInputType.text,
                          textEditingController: editBirthDayController,
                          capitalization: TextCapitalization.words,
                          maxLine: 1,
                          sufix: Icon(Icons.edit),
                        ),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "เลขประจำตัวประชาชน",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: RichText(
                        //       textAlign: TextAlign.left,
                        //       text: TextSpan(children: <TextSpan>[
                        //         TextSpan(
                        //             text: "ผู้ให้บริการ:",
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyText2!
                        //                 .copyWith(
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.bold,
                        //                 )),
                        //       ]),
                        //     )),
                        CustomTextFormFieldProfile(
                            radius: 25,
                            onChanged: (value) {
                              // filterSearchResults(value);
                            },
                            cursorColor: HexColor("#AF87DA"),
                            suffixIconColor: HexColor("#AF87DA"),
                            focusNode: _focusNodes[5],
                            hintText: "เลขประจำตัวประชาชน",
                            inputType: TextInputType.text,
                            textEditingController: editNationalIDController,
                            capitalization: TextCapitalization.words,
                            maxLine: 1,
                            sufix: Icon(Icons.edit)),
                        // CustomDropdown.search(
                        //   hintText: 'เลือก',
                        //   hintStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   items: techItems.isEmpty ? nullItems : techItems,
                        //   controller: selectTechCtrl,
                        //   onChanged: (x) {
                        //     if (x.isNotEmpty) {
                        //       var result =
                        //           listTech.where((element) => element.name == x);
                        //       technician = result.last.iDs;
                        //       print("technician = " + technician.toString());
                        //     }
                        //   },
                        //   fillColor: AppTheme.isLightTheme == false
                        //       ? const Color(0xff353045)
                        //       : const Color(0xffF4F4F4),
                        //   selectedStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xffF4F4F4)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   listItemStyle: TextStyle(
                        //       color: AppTheme.isLightTheme == false
                        //           ? const Color(0xff353045)
                        //           : const Color(0xff353045),
                        //       fontSize: 16),
                        //   excludeSelected: false,
                        // ),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "หมู่เลือด",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        CustomDropdown(
                          hintText: 'เลือก',
                          hintStyle: TextStyle(
                              color: AppTheme.isLightTheme == false
                                  ? const Color(0xffF4F4F4)
                                  : const Color(0xff353045),
                              fontSize: 16),
                          items: const [
                            'A',
                            'B',
                            'O',
                            'AB',
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

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5)),
                            Expanded(
                              child: InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.leftSlide,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.success,
                                    showCloseIcon: true,
                                    title: 'บันทึกสำเร็จ',
                                    
                                    btnOkOnPress: () {
                                      debugPrint('OnClcik');
                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDismissCallback: (type) {
                                      debugPrint(
                                          'Dialog Dissmiss from callback $type');
                                    },
                                  ).show();
                                },
                                // onTap: () {
                                //   Get.to(
                                //     const ViewEventScreen(),
                                //     transition: Transition.rightToLeft,
                                //     duration: const Duration(milliseconds: 500),
                                //   );
                                // },
                                child: customButton(
                                    HexColor(AppTheme.primaryColorString!),
                                    "บันทึก",
                                    HexColor(AppTheme.secondaryColorString!),
                                    context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ])),
      ),
    );
  }

  Widget contact() {
    return Expanded(
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Scrollbar(
            thickness: 5,
            radius: const Radius.circular(20),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "เบอร์โทรศัพท์",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        CustomTextFormFieldProfile(
                          radius: 25,
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          cursorColor: HexColor("#AF87DA"),
                          suffixIconColor: HexColor("#AF87DA"),
                          focusNode: _focusNodes[3],
                          hintText: "เบอร์โทรศัพท์",
                          inputType: TextInputType.text,
                          textEditingController: editEmployeeIDController,
                          capitalization: TextCapitalization.words,
                          maxLine: 1,
                          sufix: Icon(Icons.edit),
                        ),
                        // CustomTextFormField2(
                        //   focusNode: _focusNodes[1],
                        //   hintText: "ระบุรายละเอียด...",
                        //   inputType: TextInputType.text,
                        //   textEditingController: createNewRequestController
                        //       .descriptionIncidentController.value,
                        //   capitalization: TextCapitalization.words,
                        //   maxLine: 3,
                        // ),

                        // const SizedBox(height: 20),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 25),
                        //   child: DottedLine(
                        //     dashLength: 10,
                        //     lineThickness: 2,
                        //     dashColor: AppTheme.isLightTheme == false
                        //         ? const Color(0xff353045)
                        //         : const Color(0xffF4F4F4),
                        //   ),
                        // ),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "อีเมล",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),

                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: RichText(
                        //       textAlign: TextAlign.left,
                        //       text: TextSpan(children: <TextSpan>[
                        //         TextSpan(
                        //             text: "กลุ่มของผู้ให้บริการ:",
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyText2!
                        //                 .copyWith(
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.bold,
                        //                 )),
                        //       ]),
                        //     )),
                        CustomTextFormFieldProfile(
                            radius: 25,
                            onChanged: (value) {
                              // filterSearchResults(value);
                            },
                            cursorColor: HexColor("#AF87DA"),
                            suffixIconColor: HexColor("#AF87DA"),
                            focusNode: _focusNodes[5],
                            hintText: "ระบุอีเมล์",
                            inputType: TextInputType.text,
                            textEditingController: editEmailController,
                            capitalization: TextCapitalization.words,
                            maxLine: 1,
                            sufix: Icon(Icons.edit)),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "ชื่อ-นามสกุลผู้ติดต่อฉุกเฉิน",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        // const SizedBox(height: 3),
                        CustomTextFormFieldProfile(
                            radius: 25,
                            onChanged: (value) {
                              // filterSearchResults(value);
                            },
                            cursorColor: HexColor("#AF87DA"),
                            suffixIconColor: HexColor("#AF87DA"),
                            focusNode: _focusNodes[0],
                            hintText: "ชื่อ-นามสกุล",
                            inputType: TextInputType.text,
                            textEditingController: editFirstNameController,
                            capitalization: TextCapitalization.words,
                            maxLine: 1,
                            sufix: Icon(Icons.edit)),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "เบอร์โทรศัพท์ผู้ติดต่อฉุกเฉิน",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        // const SizedBox(height: 3),
                        CustomTextFormFieldProfile(
                            radius: 25,
                            onChanged: (value) {
                              // filterSearchResults(value);
                            },
                            cursorColor: HexColor("#AF87DA"),
                            suffixIconColor: HexColor("#AF87DA"),
                            focusNode: _focusNodes[0],
                            hintText: "เบอร์โทรศัพท์",
                            inputType: TextInputType.text,
                            textEditingController: editFirstNameController,
                            capitalization: TextCapitalization.words,
                            maxLine: 1,
                            sufix: Icon(Icons.edit)),
                        const SizedBox(height: 15),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "ความสัมพันธ์",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                TextSpan(
                                  text: "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                ),
                                TextSpan(
                                  text: ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ]),
                            )),
                        CustomDropdown(
                          hintText: 'เลือก',
                          hintStyle: TextStyle(
                              color: AppTheme.isLightTheme == false
                                  ? const Color(0xffF4F4F4)
                                  : const Color(0xff353045),
                              fontSize: 16),
                          items: const [
                            'พ่อแม่',
                            'เพื่อน',
                            'พี่น้อง',
                            'คู่สมรส',
                            'ญาติ',
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
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5)),
                            Expanded(
                              child: InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.leftSlide,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.success,
                                    showCloseIcon: true,
                                    title: 'บันทึกสำเร็จ',
                                    btnOkOnPress: () {
                                      debugPrint('OnClcik');
                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDismissCallback: (type) {
                                      debugPrint(
                                          'Dialog Dissmiss from callback $type');
                                    },
                                  ).show();
                                },
                                // onTap: () {
                                //   Get.to(
                                //     const ViewEventScreen(),
                                //     transition: Transition.rightToLeft,
                                //     duration: const Duration(milliseconds: 500),
                                //   );
                                // },
                                child: customButton(
                                    HexColor(AppTheme.primaryColorString!),
                                    "บันทึก",
                                    HexColor(AppTheme.secondaryColorString!),
                                    context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ])),
      ),
    );
  }

  Widget address() {
    return Expanded(
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Scrollbar(
            thickness: 5,
            radius: const Radius.circular(20),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "ประเทศ:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ]),
                            )),
                        CustomTextFormFieldProfile(
                            radius: 25,
                            onChanged: (value) {
                              // filterSearchResults(value);
                            },
                            cursorColor: HexColor("#AF87DA"),
                            suffixIconColor: HexColor("#AF87DA"),
                            focusNode: _focusNodes[8],
                            hintText: "แก้ไขประเทศ",
                            inputType: TextInputType.text,
                            textEditingController: editLocationController,
                            capitalization: TextCapitalization.words,
                            maxLine: 1,
                            sufix: Icon(Icons.edit)),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "บ้านเลขที่:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ]),
                            )),
                        CustomTextFormFieldProfile(
                          radius: 25,
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          cursorColor: HexColor("#AF87DA"),
                          suffixIconColor: HexColor("#AF87DA"),
                          // focusNode: _focusNodes[9],
                          hintText: "แก้ไขบ้านเลขที่",
                          inputType: TextInputType.text,
                          textEditingController: editBuildingController,
                          capitalization: TextCapitalization.words,
                          maxLine: 1,
                          sufix: Icon(Icons.edit),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "ตำบล/แขวง:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ]),
                            )),
                        CustomTextFormFieldProfile(
                          radius: 25,
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          cursorColor: HexColor("#AF87DA"),
                          suffixIconColor: HexColor("#AF87DA"),
                          // focusNode: _focusNodes[10],
                          hintText: "แก้ไขตำบล/แขวง",
                          inputType: TextInputType.text,
                          textEditingController: editAddressController,
                          capitalization: TextCapitalization.words,
                          maxLine: 1,
                          sufix: Icon(Icons.edit),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 40),
                        //   child: DottedLine(
                        //     dashLength: 10,
                        //     lineThickness: 2,
                        //     dashColor: AppTheme.isLightTheme == false
                        //         ? const Color(0xff353045)
                        //         : const Color(0xffF4F4F4),
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "อำเภอ/เขต",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ]),
                            )),
                        CustomTextFormFieldProfile(
                          radius: 25,
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          cursorColor: HexColor("#AF87DA"),
                          suffixIconColor: HexColor("#AF87DA"),
                          focusNode: _focusNodes[9],
                          hintText: "แก้ไขอำเภอ/เขต",
                          inputType: TextInputType.text,
                          textEditingController: editTypeIDController,
                          capitalization: TextCapitalization.words,
                          maxLine: 1,
                          sufix: Icon(Icons.edit),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 40),
                        //   child: DottedLine(
                        //     dashLength: 10,
                        //     lineThickness: 2,
                        //     dashColor: AppTheme.isLightTheme == false
                        //         ? const Color(0xff353045)
                        //         : const Color(0xffF4F4F4),
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "จังหวัด:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ]),
                            )),
                        CustomTextFormFieldProfile(
                          radius: 25,
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          cursorColor: HexColor("#AF87DA"),
                          suffixIconColor: HexColor("#AF87DA"),
                          focusNode: _focusNodes[10],
                          hintText: "แก้ไขจังหวัด",
                          inputType: TextInputType.text,
                          textEditingController: editDepartmentController,
                          capitalization: TextCapitalization.words,
                          maxLine: 1,
                          sufix: Icon(Icons.edit),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "รหัสไปรษณีย์:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ]),
                            )),
                        CustomTextFormFieldProfile(
                          radius: 25,
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          cursorColor: HexColor("#AF87DA"),
                          suffixIconColor: HexColor("#AF87DA"),
                          // focusNode: _focusNodes[10],
                          hintText: "แก้ไขรหัสไปรษณีย์",
                          inputType: TextInputType.text,
                          textEditingController: editLayerController,
                          capitalization: TextCapitalization.words,
                          maxLine: 1,
                          sufix: Icon(Icons.edit),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5)),
                            Expanded(
                              child: InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.leftSlide,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.success,
                                    showCloseIcon: true,
                                    title: 'บันทึกสำเร็จ',
                                    btnOkOnPress: () {
                                      debugPrint('OnClcik');
                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDismissCallback: (type) {
                                      debugPrint(
                                          'Dialog Dissmiss from callback $type');
                                    },
                                  ).show();
                                },
                                // onTap: () {
                                //   Get.to(
                                //     const ViewEventScreen(),
                                //     transition: Transition.rightToLeft,
                                //     duration: const Duration(milliseconds: 500),
                                //   );
                                // },
                                child: customButton(
                                    HexColor(AppTheme.primaryColorString!),
                                    "บันทึก",
                                    HexColor(AppTheme.secondaryColorString!),
                                    context),
                              ),
                            ),
                          ],
                        ),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: RichText(
                        //       textAlign: TextAlign.left,
                        //       text: TextSpan(children: <TextSpan>[
                        //         TextSpan(
                        //             text: "เพิ่มเติม 1:",
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyText2!
                        //                 .copyWith(
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.bold,
                        //                 )),
                        //       ]),
                        //     )),
                        // CustomTextFormFieldProfile(
                        //   radius: 25,
                        //   onChanged: (value) {
                        //     // filterSearchResults(value);
                        //   },
                        //   cursorColor: HexColor("#AF87DA"),
                        //   suffixIconColor: HexColor("#AF87DA"),
                        //   // focusNode: _focusNodes[10],
                        //   hintText: "ระบุเพิ่มเติม 1",
                        //   inputType: TextInputType.text,
                        //   textEditingController: editMore1Controller,
                        //   capitalization: TextCapitalization.words,
                        //   maxLine: 1,
                        //   // sufix: Icon(Icons.edit),
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: RichText(
                        //       textAlign: TextAlign.left,
                        //       text: TextSpan(children: <TextSpan>[
                        //         TextSpan(
                        //             text: "เพิ่มเติม 2:",
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyText2!
                        //                 .copyWith(
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.bold,
                        //                 )),
                        //       ]),
                        //     )),
                        // CustomTextFormFieldProfile(
                        //   radius: 25,
                        //   onChanged: (value) {
                        //     // filterSearchResults(value);
                        //   },
                        //   cursorColor: HexColor("#AF87DA"),
                        //   suffixIconColor: HexColor("#AF87DA"),
                        //   // focusNode: _focusNodes[10],
                        //   hintText: "ระบุเพิ่มเติม 2",
                        //   inputType: TextInputType.text,
                        //   textEditingController: editMore2Controller,
                        //   capitalization: TextCapitalization.words,
                        //   maxLine: 1,
                        //   // sufix: Icon(Icons.edit),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ])),
      ),
    );
  }
}
