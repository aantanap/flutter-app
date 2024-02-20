// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use, unused_field, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print, duplicate_ignore, prefer_const_constructors, unused_import, duplicate_import, prefer_final_fields, use_build_context_synchronously, unused_element, non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:rems/View/running/running_screen.dart';
import 'package:rems/model/data/data_model.dart';
import 'package:rems/services/pref_data.dart';
import 'package:rems/services/ticket/ticket_api.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:rems/theme_old/controller_theme/signup_controller.dart';
import 'package:rems/theme_old/widgets_theme/custom_buttom.dart';
import 'package:rems/theme_old/widgets_theme/custom_textformfield.dart';
// import 'package:rems/view/test_screen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:timelines/timelines.dart' as timeline;
import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rems/services/data/data_api.dart';
// import 'package:roundcheckbox/roundcheckbox.dart';
// import 'package:loading_indicator/loading_indicator.dart' as load;
// import 'package:open_file/open_file.dart';
import 'package:open_file_plus/open_file_plus.dart';
// import 'package:flutter_guid/flutter_guid.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';

import '../event/viewevent_screen.dart';
import '../tab_screen.dart';

const kTileHeight = 50.0;

const completeColor = Color(0xFF5E6172);
const inProgressColor = Color(0xFF3A56A0);
const todoColor = Color(0xffd1d2d7);

class RegisterEventScreen extends StatefulWidget {
  const RegisterEventScreen({Key? key}) : super(key: key);

  @override
  State<RegisterEventScreen> createState() => _RegisterEventScreenState();
}

class _RegisterEventScreenState extends State<RegisterEventScreen> {
  final createNewRequestController = Get.put(CreateNewRequestController());
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

  // group 1 page 1
  final selectSubjectCtrl = TextEditingController(); // หน่วยงาน
  final selectProvinceCtrl = TextEditingController(); // จังหวัด
  final selectCategoryCtrl = TextEditingController(); // ครุภัณฑ์ที่แจ้งซ่อม
  final selectSubCategoryCtrl = TextEditingController(); // รุ่น/รายการ
  final selectImpactCtrl = TextEditingController(); // ผลกระทบ
  final selectUrgencyCtrl = TextEditingController(); // ความเร่งด่วน
  final selectPriorityCtrl = TextEditingController(); //ความสำคัญ

  // group 2 page 1
  final selectTechGroupCtrl = TextEditingController(); // กลุ่มของผู้ให้บริการ
  final selectTechCtrl = TextEditingController(); // ผู้ให้บริการ
  final selectStatusCtrl = TextEditingController(); // สถานะงาน

  // group 1 page 2
  final selectAssetCtrl = TextEditingController(); // ชนิดของอุปกรณ์
  final selectSymptomCtrl = TextEditingController(); // ปัญหา/อาการเสีย

  // group 1 page 3
  final selectRequesterCtrl = TextEditingController(); // ชนิดของอุปกรณ์

  TextEditingController searchController = TextEditingController();

  // final selectCtrl = TextEditingController();
  // final selectOtherCtrl = TextEditingController();

  // final selectUserIDCtrl = TextEditingController();
  bool _isShowSubCategory = false;
  bool _isShowSymptomOther = false;
  bool _isShowFile = false;
  bool _isShowImage = false;
  bool _isShowEquipment = false;
  bool _isLoading = false;
  int _processIndex = 0;
  var index = 0;
  bool _value = false;
  int? symptomID;
  String? agentID;

  // นำเข้าไฟล์
  File? _file;
  List<File> _files = [];
  List<Files> uploadFileItem = [];
  String? img64;
  SendRequest requester = SendRequest();

  get requestDataByID => null;

  getMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      List<File>? file = result.paths.map((path) => File(path!)).toList();
      _files = file;
      if (_files.isNotEmpty) {
        uploadImage.clear();
        for (var i in _files) {
          String? name = i.path;
          if (i.path.split(".").last == "png" ||
              i.path.split(".").last == "jpg" ||
              i.path.split(".").last == "jpeg") {
            uploadImage.add(name);
          } else {}
        }
        print(uploadImage);
      }
      setState(() {});
    } else {
      // User canceled the picker and didn't
      // select atleast 1 file from device
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select atleast 1 file'),
      ));
    }
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false;
    });

    setState(() {
      // futureSubject.then((value) => )
    });
    await futureSubject;
  }

  getIDcreater() async {
    creater = await PrefData.getID();
    setState(() {});
  }

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = <String>[];
  bool loading = false;
  String serialNum_ = "";
  List<ShowDevices> devicesItem = [];

  String? requesterName;
  String? requesterEmail;
  String? requesterPhone;
  String? requesterOfficePhone;

  // ปั้นข้อมูล
  int? departmentID;
  int? ciType;
  int? province;
  String? manufacture;
  int? impactID;
  int? urgencyID;
  int? priorityID;
  int? techgroupID;
  String? technician;
  String? creater;

  List<Devices> devices = [];

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  List<String> uploadImage = [];
  List<String> nullItems = ["กำลังโหลดข้อมูล..."];
  Future<List<Subject>>? futureSubject;
  List<Subject> listSubject = [];
  List<String> subjectsItems = [];

  Future<List<Impact>>? futureImpact;
  List<Impact> listImpact = [];
  List<String> impactsItems = [];

  Future<List<Urgency>>? futureUrgency;
  List<Urgency> listUrgency = [];
  List<String> urgencyItems = [];

  Future<List<Priority>>? futurePriority;
  List<Priority> listPriority = [];
  List<String> priorityItems = [];

  Future<List<Province>>? futureProvince;
  List<Province> listProvince = [];
  List<String> provinceItems = [];

  Future<List<Category>>? futureCategory;
  List<Category> listCategory = [];
  List<String> categoryItems = [];
  List<int> categoryIDItems = [];
  int parentID_default = 0;

  String? parentID_str;
  int? parentID;

  Future<List<Category>>? futureSubCategory;
  List<Category> listSubCategory = [];
  List<String> subcategoryItems = [];
  List<int> subcategoryIDItems = [];

  Future<List<Techgroup>>? futureTechgroup;
  List<Techgroup> listTechgroup = [];
  List<String> techgroupItems = [];

  Future<List<Tech>>? futureTech;
  List<Tech> listTech = [];
  List<String> techItems = [];

  Future<List<Status>>? futureStatus;
  List<Status> listStatus = [];
  List<String> statusItems = [];

  Future<List<Asset>>? futureAsset;
  List<Asset> listAsset = [];
  List<String> assetItems = [];

  Future<List<DeviceListByCIType>>? futureDeviceListByCIType;
  List<DeviceListByCIType> listDeviceListByCIType = [];
  List<String> deviceListByCITypeItems = [];
  int? cITypeID;

  Future<List<SymptomListByCIType>>? futureSymptomListByCIType;
  List<SymptomListByCIType> listSymptomListByCIType = [];
  List<String> symptomListByCITypeItems = [];

  Future<List<Requester>>? futureRequester;
  List<Requester> listRequester = [];
  List<String> requesterItems = [];
  String? requesterID;

  Future<DetailUser>? futureDetailUser;
  DetailUser listDetailUser = DetailUser();
  // creater = PrefData.getID().toString();

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();

    getIDcreater();
    futureSubject = DataAPI().getSubjectList();
    futureSubject!.then((value) async {
      setState(() {
        listSubject = value;
        if (listSubject.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            subjectsItems.add(name!);
          }
        }
      });
    });

    futureImpact = DataAPI().getImpactList();
    futureImpact!.then((value) async {
      setState(() {
        listImpact = value;
        if (listImpact.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            impactsItems.add(name!);
          }
        }
      });
    });

    futureUrgency = DataAPI().getUrgencyList();
    futureUrgency!.then((value) async {
      setState(() {
        listUrgency = value;
        if (listUrgency.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            urgencyItems.add(name!);
          }
        }
      });
    });

    futurePriority = DataAPI().getPriorityList();
    futurePriority!.then((value) async {
      setState(() {
        listPriority = value;
        if (listPriority.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            priorityItems.add(name!);
          }
        }
      });
    });

    futureProvince = DataAPI().getProvinceList();
    futureProvince!.then((value) async {
      setState(() {
        listProvince = value;
        if (listProvince.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            provinceItems.add(name!);
          }
        }
      });
    });

    futureCategory = DataAPI().getCategoryDefaultList(parentID_default);
    futureCategory!.then((value) async {
      setState(() {
        listCategory = value;
        if (listCategory.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            int? id = i.id;
            categoryItems.add(name!);
            categoryIDItems.add(id!);
          }
        }
      });
    });

    futureTechgroup = DataAPI().getTechgroupList();
    futureTechgroup!.then((value) async {
      setState(() {
        listTechgroup = value;
        if (listTechgroup.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            techgroupItems.add(name!);
          }
        }
      });
    });

    futureTech = DataAPI().getTechList();
    futureTech!.then((value) async {
      setState(() {
        listTech = value;
        if (listTech.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            techItems.add(name!);
          }
        }
      });
    });

    futureStatus = DataAPI().getStatusList();
    futureStatus!.then((value) async {
      setState(() {
        listStatus = value;
        if (listStatus.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            statusItems.add(name!);
          }
        }
      });
    });

    futureAsset = DataAPI().getAssetList();
    futureAsset!.then((value) async {
      setState(() {
        listAsset = value;
        if (listAsset.isNotEmpty) {
          for (var i in value) {
            String? name = i.name;
            assetItems.add(name!);
          }
        }
      });
    });

    futureRequester = DataAPI().getRequesterList();
    futureRequester!.then((value) async {
      setState(() {
        listRequester = value;
        if (listRequester.isNotEmpty) {
          for (var i in value) {
            String? name = i.iDs;
            requesterItems.add(name!);
          }
        }
      });
    });
  }

  int _selectedIndex = 0;
  TextEditingController editFirstNameController = TextEditingController();
  TextEditingController editLastNameController = TextEditingController();
  TextEditingController editPasswordController = TextEditingController();
  TextEditingController editPositionController = TextEditingController();
  TextEditingController editBirthDayController = TextEditingController();

  TextEditingController editEmployeeIDController = TextEditingController();
  TextEditingController editOfficePhoneController = TextEditingController();
  TextEditingController editAlternateEmailController = TextEditingController();

  TextEditingController editEmailController = TextEditingController();
  TextEditingController editNationalIDController = TextEditingController();

  TextEditingController editLocationController = TextEditingController();
  TextEditingController editBuildingController = TextEditingController();
  TextEditingController editAddressController = TextEditingController();
  TextEditingController editTypeIDController = TextEditingController();
  TextEditingController editDepartmentController = TextEditingController();
  TextEditingController editLayerController = TextEditingController();
  TextEditingController editMore1Controller = TextEditingController();
  TextEditingController editMore2Controller = TextEditingController();

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
                "ลงทะเบียน",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              // RichText(
              //   textAlign: TextAlign.left,
              //   text: TextSpan(children: <TextSpan>[
              //     TextSpan(
              //       text: "ชนิดคำร้อง: ",
              //       style: Theme.of(context).textTheme.bodyText2!.copyWith(
              //             fontWeight: FontWeight.w500,
              //             fontSize: 14,
              //             color: AppTheme.isLightTheme == false
              //                 ? const Color(0xffA2A0A8)
              //                 : const Color(0xff211F32),
              //           ),
              //     ),
              //     TextSpan(
              //         text: "Incident",
              //         style: Theme.of(context).textTheme.bodyText2!.copyWith(
              //             fontWeight: FontWeight.w500,
              //             fontSize: 14,
              //             color: HexColor('#FE2121')))
              //   ]),
              // )
            ],
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : const Color(0xffFFFFFF),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Card(
                  elevation: 0,
                  color: AppTheme.isLightTheme == false
                      ? const Color(0xff211F32)
                      : const Color(0xffFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 75,
                            child: timeline.Timeline.tileBuilder(
                              theme: timeline.TimelineThemeData(
                                direction: Axis.horizontal,
                                connectorTheme:
                                    const timeline.ConnectorThemeData(
                                  space: 40.0,
                                  thickness: 3.0,
                                ),
                              ),
                              builder: timeline.TimelineTileBuilder.connected(
                                connectionDirection:
                                    timeline.ConnectionDirection.before,
                                itemExtentBuilder: (_, __) =>
                                    MediaQuery.of(context).size.height / 8,
                                contentsBuilder: (context, index) {
                                  return Text(
                                    _processes[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: getColor(index),
                                    ),
                                  );
                                },
                                indicatorBuilder: (_, index) {
                                  var color;
                                  var child;
                                  if (index == _processIndex) {
                                    color = inProgressColor;
                                    child = const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.0,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      ),
                                    );
                                  } else if (index < _processIndex) {
                                    color = completeColor;
                                    child = Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15.0,
                                    );
                                  } else {
                                    color = todoColor;
                                  }

                                  if (index <= _processIndex) {
                                    return Stack(
                                      children: [
                                        CustomPaint(
                                          size: Size(0.0, 0.0),
                                          painter: _BezierPainter(
                                            color: color,
                                            drawStart: index > 0,
                                            drawEnd: index < _processIndex,
                                          ),
                                        ),
                                        timeline.DotIndicator(
                                          size: 35.0,
                                          color: color,
                                          child: child,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Stack(
                                      children: [
                                        CustomPaint(
                                          size: Size(0.0, 0.0),
                                          painter: _BezierPainter(
                                            color: color,
                                            drawEnd:
                                                index < _processes.length - 1,
                                          ),
                                        ),
                                        timeline.OutlinedDotIndicator(
                                          borderWidth: 4.0,
                                          size: 25.0,
                                          color: color,
                                        ),
                                      ],
                                    );
                                  }
                                },
                                connectorBuilder: (_, index, type) {
                                  if (index > 0) {
                                    if (index == _processIndex) {
                                      final prevColor = getColor(index - 1);
                                      final color = getColor(index);
                                      List<Color> gradientColors;
                                      if (type ==
                                          timeline.ConnectorType.start) {
                                        gradientColors = [
                                          Color.lerp(prevColor, color, 0.5)!,
                                          color
                                        ];
                                      } else {
                                        gradientColors = [
                                          prevColor,
                                          Color.lerp(prevColor, color, 0.5)!
                                        ];
                                      }
                                      return timeline.DecoratedLineConnector(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: gradientColors,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return timeline.SolidLineConnector(
                                        color: getColor(index),
                                      );
                                    }
                                  } else {
                                    return null;
                                  }
                                },
                                itemCount: _processes.length,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _processIndex == 0
                              ? Section1()
                              : _processIndex == 1
                                  ? Section2()
                                  : Section3()
                        ]),
                  ),
                ),
              ),
            )));
  }

  Widget Section1() {
    return Expanded(
      child: Scrollbar(
        thickness: 5,
        radius: const Radius.circular(20),
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ListView(
            // physics: ClampingScrollPhysics(),
            // shrinkWrap: true,
            children: [
              Column(
                children: [
                  Text("โปรดระบุข้อมูลผู้สมัคร",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          )),
                  const SizedBox(height: 10),
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  // Visibility(
                  //   visible: _isShowSubCategory,
                  //   child: Column(
                  //     children: [
                  //       Align(
                  //           alignment: Alignment.centerLeft,
                  //           child: RichText(
                  //             textAlign: TextAlign.left,
                  //             text: TextSpan(children: <TextSpan>[
                  //               TextSpan(
                  //                   text: "รุ่น/รายการ (1)",
                  //                   style: Theme.of(context)
                  //                       .textTheme
                  //                       .bodyText2!
                  //                       .copyWith(
                  //                         fontSize: 16,
                  //                         fontWeight: FontWeight.bold,
                  //                       )),
                  //               TextSpan(
                  //                 text: "*",
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodyText2!
                  //                     .copyWith(
                  //                         fontSize: 16,
                  //                         fontWeight: FontWeight.bold,
                  //                         color: Colors.red),
                  //               ),
                  //               TextSpan(
                  //                 text: ":",
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodyText2!
                  //                     .copyWith(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //               ),
                  //             ]),
                  //           )),
                  //       CustomDropdown.search(
                  //         hintText: 'เลือก',
                  //         hintStyle: TextStyle(
                  //             color: AppTheme.isLightTheme == false
                  //                 ? const Color(0xffF4F4F4)
                  //                 : const Color(0xff353045),
                  //             fontSize: 16),
                  //         items: subcategoryItems.isEmpty
                  //             ? nullItems
                  //             : subcategoryItems,
                  //         controller: selectSubCategoryCtrl,
                  //         onChanged: (x) {
                  //           if (x.isNotEmpty) {
                  //             var result = listSubject
                  //                 .where((element) => element.name == x);
                  //             manufacture = x;
                  //             print("manufacture = " + manufacture.toString());
                  //           }
                  //         },
                  //         fillColor: AppTheme.isLightTheme == false
                  //             ? const Color(0xff353045)
                  //             : const Color(0xffF4F4F4),
                  //         selectedStyle: TextStyle(
                  //             color: AppTheme.isLightTheme == false
                  //                 ? const Color(0xffF4F4F4)
                  //                 : const Color(0xff353045),
                  //             fontSize: 16),
                  //         listItemStyle: TextStyle(
                  //             color: AppTheme.isLightTheme == false
                  //                 ? const Color(0xff353045)
                  //                 : const Color(0xff353045),
                  //             fontSize: 16),
                  //         excludeSelected: false,
                  //       ),
                  //       const SizedBox(height: 15),
                  //     ],
                  //   ),
                  // ),
                  // /////////////////////////////////////////////////////////// ผลกระทบ dropdown
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: RichText(
                  //       textAlign: TextAlign.left,
                  //       text: TextSpan(children: <TextSpan>[
                  //         TextSpan(
                  //             text: "ผลกระทบ",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText2!
                  //                 .copyWith(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.bold,
                  //                 )),
                  //         TextSpan(
                  //           text: ":",
                  //           style:
                  //               Theme.of(context).textTheme.bodyText2!.copyWith(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //         ),
                  //       ]),
                  //     )),
                  // CustomDropdown.search(
                  //   hintText: 'เลือก',
                  //   hintStyle: TextStyle(
                  //       color: AppTheme.isLightTheme == false
                  //           ? const Color(0xffF4F4F4)
                  //           : const Color(0xff353045),
                  //       fontSize: 16),
                  //   items: impactsItems.isEmpty ? nullItems : impactsItems,
                  //   controller: selectImpactCtrl,
                  //   onChanged: (x) {
                  //     if (x.isNotEmpty) {
                  //       var result =
                  //           listImpact.where((element) => element.name == x);
                  //       impactID = result.last.id;
                  //       print("impactID = " + impactID.toString());
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
                  // const SizedBox(height: 15),
                  // /////////////////////////////////////////////////////////// ผลกระทบ TextSpan
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: RichText(
                  //       textAlign: TextAlign.left,
                  //       text: TextSpan(children: <TextSpan>[
                  //         TextSpan(
                  //             text: "รายละเอียดผลกระทบเพิ่มเติม",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText2!
                  //                 .copyWith(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.bold,
                  //                 )),
                  //       ]),
                  //     )),
                  // CustomTextFormField2(
                  //   focusNode: _focusNodes[1],
                  //   hintText: "ระบุรายละเอียดผลกระทบ...",
                  //   inputType: TextInputType.text,
                  //   textEditingController: createNewRequestController
                  //       .impactDescriptionController.value,
                  //   capitalization: TextCapitalization.words,
                  //   maxLine: 3,
                  // ),
                  // const SizedBox(height: 15),
                  // /////////////////////////////////////////////////////////// ความเร่งด่วน dropdown
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: RichText(
                  //       textAlign: TextAlign.left,
                  //       text: TextSpan(children: <TextSpan>[
                  //         TextSpan(
                  //             text: "ความเร่งด่วน",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText2!
                  //                 .copyWith(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.bold,
                  //                 )),
                  //         TextSpan(
                  //           text: ":",
                  //           style:
                  //               Theme.of(context).textTheme.bodyText2!.copyWith(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //         ),
                  //       ]),
                  //     )),
                  // CustomDropdown.search(
                  //   hintText: 'เลือก',
                  //   hintStyle: TextStyle(
                  //       color: AppTheme.isLightTheme == false
                  //           ? const Color(0xffF4F4F4)
                  //           : const Color(0xff353045),
                  //       fontSize: 16),
                  //   items: urgencyItems.isEmpty ? nullItems : urgencyItems,
                  //   controller: selectUrgencyCtrl,
                  //   onChanged: (x) {
                  //     if (x.isNotEmpty) {
                  //       var result =
                  //           listUrgency.where((element) => element.name == x);
                  //       urgencyID = result.last.id;
                  //       print("urgencyID = " + urgencyID.toString());
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
                  // const SizedBox(height: 15),
                  // /////////////////////////////////////////////////////////// ความสำคัญ dropdown
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: RichText(
                  //       textAlign: TextAlign.left,
                  //       text: TextSpan(children: <TextSpan>[
                  //         TextSpan(
                  //             text: "ความสำคัญ",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText2!
                  //                 .copyWith(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.bold,
                  //                 )),
                  //         TextSpan(
                  //           text: ":",
                  //           style:
                  //               Theme.of(context).textTheme.bodyText2!.copyWith(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //         ),
                  //       ]),
                  //     )),
                  // CustomDropdown.search(
                  //   hintText: 'เลือก',
                  //   hintStyle: TextStyle(
                  //       color: AppTheme.isLightTheme == false
                  //           ? const Color(0xffF4F4F4)
                  //           : const Color(0xff353045),
                  //       fontSize: 16),
                  //   items: priorityItems.isEmpty ? nullItems : priorityItems,
                  //   controller: selectPriorityCtrl,
                  //   onChanged: (x) {
                  //     if (x.isNotEmpty) {
                  //       var result =
                  //           listPriority.where((element) => element.name == x);
                  //       priorityID = result.last.id;
                  //       print("priorityID = " + priorityID.toString());
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
                  // const SizedBox(height: 15),
                  const SizedBox(height: 15),
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  // CustomDropdown.search(
                  //   hintText: 'เลือก',
                  //   hintStyle: TextStyle(
                  //       color: AppTheme.isLightTheme == false
                  //           ? const Color(0xffF4F4F4)
                  //           : const Color(0xff353045),
                  //       fontSize: 16),
                  //   items: techgroupItems.isEmpty ? nullItems : techgroupItems,
                  //   controller: selectTechGroupCtrl,
                  //   onChanged: (x) {
                  //     if (x.isNotEmpty) {
                  //       var result =
                  //           listTechgroup.where((element) => element.name == x);
                  //       techgroupID = result.last.id;
                  //       print("techgroupID = " + techgroupID.toString());
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  const SizedBox(height: 15),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "ปัญหาสุขภาพหรือโรคประจำตัว",
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ]),
                      )),
                  CustomTextFormField2(
                    focusNode: _focusNodes[1],
                    hintText: "ระบุรายละเอียด...",
                    inputType: TextInputType.text,
                    textEditingController: createNewRequestController
                        .descriptionIncidentController.value,
                    capitalization: TextCapitalization.words,
                    maxLine: 3,
                  ),
                  // CustomTextFormField2(
                  //   readOnly: true,
                  //   focusNode: _focusNodes[2],
                  //   hintText: "เปิดงาน",
                  //   inputType: TextInputType.text,
                  //   textEditingController:
                  //       createNewRequestController.serialNumberController.value,
                  //   capitalization: TextCapitalization.words,
                  //   maxLine: 1,
                  // ),
                  // CustomDropdown.search(
                  //   hintText: 'เลือก',
                  //   hintStyle: TextStyle(
                  //       color: AppTheme.isLightTheme == false
                  //           ? const Color(0xffF4F4F4)
                  //           : const Color(0xff353045),
                  //       fontSize: 16),
                  //   items: statusItems.isEmpty ? nullItems : statusItems,
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
                  // const SizedBox(height: 15),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: RichText(
                  //       textAlign: TextAlign.left,
                  //       text: TextSpan(children: <TextSpan>[
                  //         TextSpan(
                  //             text: "ประเภทงาน:",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText2!
                  //                 .copyWith(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.bold,
                  //                 )),
                  //       ]),
                  //     )),
                  // CustomDropdown.search(
                  //   hintText: 'เลือก',
                  //   hintStyle: TextStyle(
                  //       color: AppTheme.isLightTheme == false
                  //           ? const Color(0xffF4F4F4)
                  //           : const Color(0xff353045),
                  //       fontSize: 16),
                  //   items: const ['Critical', 'High', 'Medium', 'Low'],
                  //   controller: selectCategoryCtrl,
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
                  // const SizedBox(height: 15),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: RichText(
                  //       textAlign: TextAlign.left,
                  //       text: TextSpan(children: <TextSpan>[
                  //         TextSpan(
                  //             text: "ประเภทงานย่อย (1):",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText2!
                  //                 .copyWith(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.bold,
                  //                 )),
                  //       ]),
                  //     )),
                  // CustomDropdown.search(
                  //   hintText: 'เลือก',
                  //   hintStyle: TextStyle(
                  //       color: AppTheme.isLightTheme == false
                  //           ? const Color(0xffF4F4F4)
                  //           : const Color(0xff353045),
                  //       fontSize: 16),
                  //   items: const ['Critical', 'High', 'Medium', 'Low'],
                  //   controller: selectSubCategoryCtrl,
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
                  const SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "กรณีฉุกเฉิน",
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
                        ]),
                      )),
                  //
                  //   onTap: () {
                  //     getMultipleFile();
                  //     // Get.to(
                  //     //   const Home(),
                  //     //   transition: Transition.downToUp,
                  //     //   duration: const Duration(milliseconds: 500),
                  //     // );
                  //     print(_files);
                  //     print("กด");
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(3.0),
                  //     child: DottedBorder(
                  //       borderType: BorderType.RRect,
                  //       radius: Radius.circular(20),
                  //       dashPattern: [5, 5, 5, 5, 5, 5],
                  //       color: const Color(0xFF3A56A0),
                  //       strokeWidth: 2,
                  //       child: Container(
                  //           width: double.infinity,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(20),
                  //               color: Color.fromARGB(255, 221, 230, 251)),
                  //           child: Padding(
                  //             padding:
                  //                 const EdgeInsets.only(top: 15, bottom: 15),
                  //             child: Column(
                  //               children: [
                  //                 Image.asset(
                  //                   "assets/images/Archive.png",
                  //                   width: MediaQuery.of(context).size.width *
                  //                       0.08,
                  //                   color: Color(0xFF849BD4)
                  //                 ),
                  //                 const SizedBox(height: 5),
                  //                 const Text(
                  //                   "เพิ่มไฟล์แนบ",
                  //                   style: TextStyle(
                  //                       color: Color(0xff595959),
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.w600),
                  //                 ),
                  //               ],
                  //             ),
                  //           )),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 5),
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  const SizedBox(height: 15),
                  // Visibility(
                  //   visible: _files.isEmpty
                  //       ? _isShowFile = false
                  //       : _isShowFile = true,
                  //   child: Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: RichText(
                  //         textAlign: TextAlign.left,
                  //         text: TextSpan(children: <TextSpan>[
                  //           TextSpan(
                  //               text: "ไฟล์ที่อัพโหลด",
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .bodyText2!
                  //                   .copyWith(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Color(0xff9F9F9F),
                  //                   )),
                  //         ]),
                  //       )),
                  // ),
                  // const SizedBox(height: 5),
                  // Visibility(
                  //   visible: _files.isEmpty
                  //       ? _isShowFile = false
                  //       : _isShowFile = true,
                  //   child: ListView(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     children: [
                  //       Container(
                  //         // height:
                  //         //     MediaQuery.of(context).copyWith().size.height * 0.3,
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             color: HexColor(AppTheme.primaryColorString!),
                  //           ),
                  //           borderRadius: BorderRadius.circular(20),
                  //           // color: const Color(0xffE3F6F5)
                  //         ),
                  //         padding: EdgeInsets.symmetric(vertical: 5),
                  //         child: Scrollbar(
                  //             thickness: 5,
                  //             radius: const Radius.circular(20),
                  //             scrollbarOrientation: ScrollbarOrientation.right,
                  //             child: ListView.builder(
                  //               physics: ScrollPhysics(),
                  //               shrinkWrap: true,
                  //               itemCount: _files.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 return Column(
                  //                   children: [
                  //                     GestureDetector(
                  //                         onTap: () {
                  //                           // ignore: unused_local_variable
                  //                           var openResult = 'Unknown';
                  //                           final filePath = _files[index].path;
                  //                           final result =
                  //                               OpenFile.open(filePath);
                  //                           // final bytes =
                  //                           //     File(filePath).readAsBytesSync();
                  //                           // img64 = base64Encode(bytes);
                  //                           // setState(() {
                  //                           //   img64;
                  //                           // });

                  //                           print(_files[index].path);
                  //                           print("ชื่อไฟล์: " +
                  //                               _files[index]
                  //                                   .path
                  //                                   .split("/")
                  //                                   .last);
                  //                           print("นามสกุลไฟล์: " +
                  //                               _files[index]
                  //                                   .path
                  //                                   .split(".")
                  //                                   .last);
                  //                           print("img64: " + img64!);

                  //                           // OpenFile.open(_files[index].path);
                  //                         },
                  //                         child: _files[index]
                  //                                     .path
                  //                                     .split(".")
                  //                                     .last ==
                  //                                 "xls"
                  //                             ? // xls
                  //                             Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.all(5),
                  //                                 child: Row(
                  //                                   children: [
                  //                                     Expanded(
                  //                                       flex: 0,
                  //                                       child: Image.asset(
                  //                                         "assets/images/xls(2).png",
                  //                                         width: 50,
                  //                                         height: 50,
                  //                                       ),
                  //                                     ),
                  //                                     Expanded(
                  //                                         child: Padding(
                  //                                       padding:
                  //                                           const EdgeInsets
                  //                                                   .symmetric(
                  //                                               horizontal: 5),
                  //                                       child: Column(
                  //                                         crossAxisAlignment:
                  //                                             CrossAxisAlignment
                  //                                                 .start,
                  //                                         children: [
                  //                                           Text(_files[index]
                  //                                               .path
                  //                                               .split("/")
                  //                                               .last),
                  //                                           const SizedBox(
                  //                                             height: 7,
                  //                                           ),
                  //                                           Container(
                  //                                               height: 4,
                  //                                               width: double
                  //                                                   .infinity,
                  //                                               decoration: BoxDecoration(
                  //                                                   borderRadius:
                  //                                                       BorderRadius.circular(
                  //                                                           20),
                  //                                                   color: const Color(
                  //                                                       0xff00733B))),
                  //                                           // Divider(
                  //                                           //     color: Colors.black,
                  //                                           //     thickness: 1)
                  //                                         ],
                  //                                       ),
                  //                                     )),
                  //                                     Expanded(
                  //                                       flex: 0,
                  //                                       child: GestureDetector(
                  //                                         onTap: () {
                  //                                           _files.removeAt(
                  //                                               index);
                  //                                           setState(() {});
                  //                                         },
                  //                                         child: Image.asset(
                  //                                           "assets/images/incorrect.png",
                  //                                           width: 25,
                  //                                           height: 25,
                  //                                           color: Colors
                  //                                               .red.shade400,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               )
                  //                             : _files[index]
                  //                                         .path
                  //                                         .split(".")
                  //                                         .last ==
                  //                                     "pdf"
                  //                                 ? Padding(
                  //                                     padding:
                  //                                         const EdgeInsets.all(
                  //                                             5),
                  //                                     child: Row(
                  //                                       children: [
                  //                                         Expanded(
                  //                                           flex: 0,
                  //                                           child: Image.asset(
                  //                                             "assets/images/pdf (2).png",
                  //                                             width: 50,
                  //                                             height: 50,
                  //                                           ),
                  //                                         ),
                  //                                         Expanded(
                  //                                             child: Padding(
                  //                                           padding:
                  //                                               const EdgeInsets
                  //                                                       .symmetric(
                  //                                                   horizontal:
                  //                                                       5),
                  //                                           child: Column(
                  //                                             crossAxisAlignment:
                  //                                                 CrossAxisAlignment
                  //                                                     .start,
                  //                                             children: [
                  //                                               Text(_files[
                  //                                                       index]
                  //                                                   .path
                  //                                                   .split("/")
                  //                                                   .last),
                  //                                               SizedBox(
                  //                                                 height: 7,
                  //                                               ),
                  //                                               Container(
                  //                                                   height: 4,
                  //                                                   width: double
                  //                                                       .infinity,
                  //                                                   decoration: BoxDecoration(
                  //                                                       borderRadius:
                  //                                                           BorderRadius.circular(
                  //                                                               20),
                  //                                                       color: const Color(
                  //                                                           0xffE5252A))),
                  //                                               // Divider(
                  //                                               //     color: Colors.black,
                  //                                               //     thickness: 1)
                  //                                             ],
                  //                                           ),
                  //                                         )),
                  //                                         Expanded(
                  //                                           flex: 0,
                  //                                           child:
                  //                                               GestureDetector(
                  //                                             onTap: () {
                  //                                               _files.removeAt(
                  //                                                   index);
                  //                                               setState(() {});
                  //                                             },
                  //                                             child:
                  //                                                 Image.asset(
                  //                                               "assets/images/incorrect.png",
                  //                                               width: 25,
                  //                                               height: 25,
                  //                                               color: Colors
                  //                                                   .red
                  //                                                   .shade400,
                  //                                             ),
                  //                                           ),
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                   )
                  //                                 : _files[index]
                  //                                             .path
                  //                                             .split(".")
                  //                                             .last ==
                  //                                         "docx"
                  //                                     ? Padding(
                  //                                         padding:
                  //                                             const EdgeInsets
                  //                                                 .all(5.0),
                  //                                         child: Row(
                  //                                           children: [
                  //                                             Expanded(
                  //                                               flex: 0,
                  //                                               child:
                  //                                                   Image.asset(
                  //                                                 "assets/images/doc (2).png",
                  //                                                 width: 50,
                  //                                                 height: 50,
                  //                                               ),
                  //                                             ),
                  //                                             Expanded(
                  //                                                 child:
                  //                                                     Padding(
                  //                                               padding: const EdgeInsets
                  //                                                       .symmetric(
                  //                                                   horizontal:
                  //                                                       5),
                  //                                               child: Column(
                  //                                                 crossAxisAlignment:
                  //                                                     CrossAxisAlignment
                  //                                                         .start,
                  //                                                 children: [
                  //                                                   Text(
                  //                                                     _files[index]
                  //                                                         .path
                  //                                                         .split(
                  //                                                             "/")
                  //                                                         .last,
                  //                                                   ),
                  //                                                   SizedBox(
                  //                                                     height: 7,
                  //                                                   ),
                  //                                                   Container(
                  //                                                       height:
                  //                                                           4,
                  //                                                       width: double
                  //                                                           .infinity,
                  //                                                       decoration: BoxDecoration(
                  //                                                           borderRadius:
                  //                                                               BorderRadius.circular(20),
                  //                                                           color: const Color(0xff0263D1))),
                  //                                                   // Divider(
                  //                                                   //     color: Colors.black,
                  //                                                   //     thickness: 1)
                  //                                                 ],
                  //                                               ),
                  //                                             )),
                  //                                             Expanded(
                  //                                               flex: 0,
                  //                                               child:
                  //                                                   GestureDetector(
                  //                                                 onTap: () {
                  //                                                   _files.removeAt(
                  //                                                       index);
                  //                                                   setState(
                  //                                                       () {});
                  //                                                 },
                  //                                                 child: Image
                  //                                                     .asset(
                  //                                                   "assets/images/incorrect.png",
                  //                                                   width: 25,
                  //                                                   height: 25,
                  //                                                   color: Colors
                  //                                                       .red
                  //                                                       .shade400,
                  //                                                 ),
                  //                                               ),
                  //                                             ),
                  //                                           ],
                  //                                         ),
                  //                                       )
                  //                                     : _files[index]
                  //                                                 .path
                  //                                                 .split(".")
                  //                                                 .last ==
                  //                                             "svg"
                  //                                         ? Padding(
                  //                                             padding:
                  //                                                 const EdgeInsets
                  //                                                     .all(5.0),
                  //                                             child: Row(
                  //                                               children: [
                  //                                                 Expanded(
                  //                                                   flex: 0,
                  //                                                   child: Image
                  //                                                       .asset(
                  //                                                     "assets/images/txt.png",
                  //                                                     width: 50,
                  //                                                     height:
                  //                                                         50,
                  //                                                   ),
                  //                                                 ),
                  //                                                 Expanded(
                  //                                                     child:
                  //                                                         Padding(
                  //                                                   padding: const EdgeInsets
                  //                                                           .symmetric(
                  //                                                       horizontal:
                  //                                                           5),
                  //                                                   child:
                  //                                                       Column(
                  //                                                     crossAxisAlignment:
                  //                                                         CrossAxisAlignment
                  //                                                             .start,
                  //                                                     children: [
                  //                                                       Text(_files[index]
                  //                                                           .path
                  //                                                           .split("/")
                  //                                                           .last),
                  //                                                       SizedBox(
                  //                                                         height:
                  //                                                             7,
                  //                                                       ),
                  //                                                       Container(
                  //                                                           height:
                  //                                                               4,
                  //                                                           width:
                  //                                                               double.infinity,
                  //                                                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xffE5252A))),
                  //                                                       // Divider(
                  //                                                       //     color: Colors.black,
                  //                                                       //     thickness: 1)
                  //                                                     ],
                  //                                                   ),
                  //                                                 )),
                  //                                                 Expanded(
                  //                                                   flex: 0,
                  //                                                   child:
                  //                                                       GestureDetector(
                  //                                                     onTap:
                  //                                                         () {
                  //                                                       _files.removeAt(
                  //                                                           index);
                  //                                                       setState(
                  //                                                           () {});
                  //                                                     },
                  //                                                     child: Image
                  //                                                         .asset(
                  //                                                       "assets/images/incorrect.png",
                  //                                                       width:
                  //                                                           25,
                  //                                                       height:
                  //                                                           25,
                  //                                                       color: Colors
                  //                                                           .red
                  //                                                           .shade400,
                  //                                                     ),
                  //                                                   ),
                  //                                                 ),
                  //                                               ],
                  //                                             ),
                  //                                           )
                  //                                         : _files[index]
                  //                                                     .path
                  //                                                     .split(
                  //                                                         ".")
                  //                                                     .last ==
                  //                                                 "pdf"
                  //                                             ? Padding(
                  //                                                 padding:
                  //                                                     const EdgeInsets
                  //                                                             .all(
                  //                                                         5.0),
                  //                                                 child: Row(
                  //                                                   children: [
                  //                                                     Expanded(
                  //                                                       flex: 0,
                  //                                                       child: Image
                  //                                                           .asset(
                  //                                                         "assets/images/svg (1).png",
                  //                                                         width:
                  //                                                             50,
                  //                                                         height:
                  //                                                             50,
                  //                                                       ),
                  //                                                     ),
                  //                                                     Expanded(
                  //                                                         child:
                  //                                                             Padding(
                  //                                                       padding:
                  //                                                           const EdgeInsets.symmetric(horizontal: 5),
                  //                                                       child:
                  //                                                           Column(
                  //                                                         crossAxisAlignment:
                  //                                                             CrossAxisAlignment.start,
                  //                                                         children: [
                  //                                                           Text(_files[index].path.split("/").last),
                  //                                                           SizedBox(
                  //                                                             height: 7,
                  //                                                           ),
                  //                                                           Container(
                  //                                                               height: 4,
                  //                                                               width: double.infinity,
                  //                                                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xffE5252A))),
                  //                                                           // Divider(
                  //                                                           //     color: Colors.black,
                  //                                                           //     thickness: 1)
                  //                                                         ],
                  //                                                       ),
                  //                                                     )),
                  //                                                     Expanded(
                  //                                                       flex: 0,
                  //                                                       child:
                  //                                                           GestureDetector(
                  //                                                         onTap:
                  //                                                             () {
                  //                                                           _files.removeAt(index);
                  //                                                           setState(() {});
                  //                                                         },
                  //                                                         child:
                  //                                                             Image.asset(
                  //                                                           "assets/images/incorrect.png",
                  //                                                           width:
                  //                                                               25,
                  //                                                           height:
                  //                                                               25,
                  //                                                           color:
                  //                                                               Colors.red.shade400,
                  //                                                         ),
                  //                                                       ),
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                               )
                  //                                             : _files[index]
                  //                                                         .path
                  //                                                         .split(".")
                  //                                                         .last ==
                  //                                                     "jpg"
                  //                                                 ? Center()
                  //                                                 : _files[index].path.split(".").last == "jpeg"
                  //                                                     ? Center()
                  //                                                     : _files[index].path.split(".").last == "png"
                  //                                                         ? Center()
                  //                                                         // pdf

                  //                                                         : Padding(
                  //                                                             padding: const EdgeInsets.all(5.0),
                  //                                                             child: Row(
                  //                                                               children: [
                  //                                                                 Expanded(
                  //                                                                   flex: 0,
                  //                                                                   child: Image.asset(
                  //                                                                     "assets/images/file.png",
                  //                                                                     width: 50,
                  //                                                                     height: 50,
                  //                                                                   ),
                  //                                                                 ),
                  //                                                                 Expanded(
                  //                                                                     child: Padding(
                  //                                                                   padding: const EdgeInsets.symmetric(horizontal: 5),
                  //                                                                   child: Column(
                  //                                                                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                                                                     children: [
                  //                                                                       Text(_files[index].path.split("/").last),
                  //                                                                       SizedBox(
                  //                                                                         height: 7,
                  //                                                                       ),
                  //                                                                       Container(height: 4, width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xffE5252A))),
                  //                                                                       // Divider(
                  //                                                                       //     color: Colors.black,
                  //                                                                       //     thickness: 1)
                  //                                                                     ],
                  //                                                                   ),
                  //                                                                 )),
                  //                                                                 Expanded(
                  //                                                                   flex: 0,
                  //                                                                   child: GestureDetector(
                  //                                                                     onTap: () {
                  //                                                                       if (_files[index].path == uploadImage[index]) {
                  //                                                                         _files.removeAt(index);
                  //                                                                         uploadImage.removeAt(index);
                  //                                                                       }
                  //                                                                       setState(() {});
                  //                                                                     },
                  //                                                                     child: Image.asset(
                  //                                                                       "assets/images/incorrect.png",
                  //                                                                       width: 25,
                  //                                                                       height: 25,
                  //                                                                       color: Colors.red.shade400,
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                 ),
                  //                                                               ],
                  //                                                             ),
                  //                                                           )),
                  //                   ],
                  //                 );
                  //               },
                  //             )),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Visibility(
                  //   visible: uploadImage.isEmpty
                  //       ? _isShowImage = false
                  //       : _isShowImage = true,
                  //   child: Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: RichText(
                  //         textAlign: TextAlign.left,
                  //         text: TextSpan(children: <TextSpan>[
                  //           TextSpan(
                  //               text: "ภาพที่อัพโหลด",
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .bodyText2!
                  //                   .copyWith(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Color(0xff9F9F9F),
                  //                   )),
                  //         ]),
                  //       )),
                  // ),
                  // const SizedBox(height: 5),
                  // Visibility(
                  //   visible: uploadImage.isEmpty
                  //       ? _isShowImage = false
                  //       : _isShowImage = true,
                  //   child: Container(
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       children: [
                  //         Expanded(
                  //           // flex: 5,
                  //           child: Align(
                  //               alignment: Alignment.centerLeft,
                  //               child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Container(
                  //                           padding: EdgeInsets.only(
                  //                               left: 10, right: 10),
                  //                           child: SizedBox(
                  //                             height: 130,
                  //                             width: double.infinity,
                  //                             child: GridView.builder(
                  //                               itemCount: uploadImage.length,
                  //                               shrinkWrap: true,
                  //                               scrollDirection:
                  //                                   Axis.horizontal,
                  //                               gridDelegate:
                  //                                   SliverGridDelegateWithFixedCrossAxisCount(
                  //                                 // mainAxisExtent: 80,
                  //                                 crossAxisCount: 1,
                  //                                 crossAxisSpacing: 5.0,
                  //                                 mainAxisSpacing: 5.0,
                  //                               ),
                  //                               itemBuilder: (context, index) {
                  //                                 return LayoutBuilder(builder:
                  //                                     (context, constraints) {
                  //                                   return ClipRRect(
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             10),
                  //                                     child: GestureDetector(
                  //                                       onTap: () {
                  //                                         final filePath =
                  //                                             uploadImage[
                  //                                                 index];
                  //                                         final result =
                  //                                             OpenFile.open(
                  //                                                 filePath);
                  //                                       },
                  //                                       child: Stack(
                  //                                         children: [
                  //                                           Image.file(
                  //                                             File(uploadImage[
                  //                                                 index]),
                  //                                             fit: BoxFit.cover,
                  //                                             cacheWidth:
                  //                                                 constraints
                  //                                                     .biggest
                  //                                                     .width
                  //                                                     .ceil(),
                  //                                             cacheHeight:
                  //                                                 constraints
                  //                                                     .biggest
                  //                                                     .height
                  //                                                     .ceil(),
                  //                                           ),
                  //                                           Positioned(
                  //                                             right: -9,
                  //                                             top: -9,
                  //                                             child: Container(
                  //                                               // color: Colors.white12,
                  //                                               child:
                  //                                                   IconButton(
                  //                                                 icon: Image
                  //                                                     .asset(
                  //                                                   "assets/images/incorrect.png",
                  //                                                   width: 25,
                  //                                                   height: 25,
                  //                                                 ),
                  //                                                 color: Colors
                  //                                                     .red
                  //                                                     .shade400,
                  //                                                 onPressed:
                  //                                                     () {
                  //                                                   if (uploadImage.removeAt(
                  //                                                           index) ==
                  //                                                       _files[index]
                  //                                                           .path) {
                  //                                                     _files.removeAt(
                  //                                                         index);
                  //                                                     uploadImage
                  //                                                         .removeAt(
                  //                                                             index);
                  //                                                   }
                  //                                                   setState(
                  //                                                       () {});
                  //                                                   // PortfolioImage[index].lastIndexOf('/');
                  //                                                   // print(PortfolioImage[index].lastIndexOf('/'));
                  //                                                   // String deleteImg = PortfolioImage[index].substring(PortfolioImage[index].lastIndexOf('/') + 1, PortfolioImage[index].lastIndexOf('.png'));
                  //                                                   // print(deleteImg);
                  //                                                   // UserAPI().popImagejobApi(deleteImg).then((value) {
                  //                                                   //   if (value == "200") {
                  //                                                   //     PortfolioImage.removeAt(index);
                  //                                                   //     setState(() {});
                  //                                                   //   }
                  //                                                   // }
                  //                                                   // );
                  //                                                 },
                  //                                               ),
                  //                                             ),
                  //                                           ),
                  //                                         ],
                  //                                       ),
                  //                                     ),
                  //                                   );
                  //                                 });
                  //                               },
                  //                             ),
                  //                           )),
                  //                     )
                  //                   ])),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      // if (_files.length > 0) {
                      //   _files.forEach((element) {
                      //     Uint8List base64 =
                      //         File(element.path).readAsBytesSync();
                      //     // final bytes =
                      //     //                 File(filePath).readAsBytesSync();
                      //     img64 = base64Encode(base64);

                      //     Files addFile = Files(
                      //         fileId: Guid.newGuid.toString(),
                      //         fileName: element.path.split("/").last,
                      //         contentBase64: img64);

                      //     uploadFileItem.add(addFile);
                      //   });
                      // }

                      setState(() {
                        _processIndex = (_processIndex + 1) % _processes.length;
                      });
                    },
                    child: customButton(
                        HexColor(AppTheme.primaryColorString!),
                        "ต่อไป",
                        HexColor(AppTheme.secondaryColorString!),
                        context),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Widget Section2() {
    return Expanded(
      child: ListView(
          // physics: ClampingScrollPhysics(),
          // shrinkWrap: true,
          children: [
            Column(
              children: [
                Text("โปรดระบุระยะทาง,ขนาดเสื้อและที่อยู่จัดส่ง",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "ระยะทาง",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ]),
                    )),
                // const SizedBox(height: 3),
                CustomDropdown(
                  hintText: 'เลือก',
                  hintStyle: TextStyle(
                      color: AppTheme.isLightTheme == false
                          ? const Color(0xffF4F4F4)
                          : const Color(0xff353045),
                      fontSize: 16),
                  items: const [
                    '1-9 กิโลเมตร',
                    '10-20 กิโลเมตร',
                    '21-40 กิโลเมตร',
                    '41 กิโลเมตรขึ้นไป',
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
                //   items: assetItems.isEmpty ? nullItems : assetItems,
                //   controller: selectAssetCtrl,
                //   onChanged: (x) {
                //     selectSymptomCtrl.text = "";
                //     if (x.isNotEmpty) {
                //       var result =
                //           listAsset.where((element) => element.name == x);
                //       cITypeID = result.last.id;
                //       futureDeviceListByCIType =
                //           DataAPI().getDeviceListByCIType(cITypeID!, "", 2);
                //       futureDeviceListByCIType!.then((value) async {
                //         setState(() {
                //           listDeviceListByCIType = value;
                //         });
                //       });

                //       futureSymptomListByCIType =
                //           DataAPI().getSymptomListByCIType(cITypeID!);
                //       futureSymptomListByCIType!.then((value) async {
                //         setState(() {
                //           symptomListByCITypeItems.clear();
                //           listSymptomListByCIType = value;

                //           if (listSymptomListByCIType.isNotEmpty) {
                //             for (var i in value) {
                //               String? name = i.name;
                //               symptomListByCITypeItems.add(name!);
                //             }
                //             print(symptomListByCITypeItems);
                //             String? other = "กำหนดเอง";
                //             symptomListByCITypeItems.add(other);
                //             print(symptomListByCITypeItems);
                //           }
                //         });
                //       });
                //       print("cITypeID = " + cITypeID.toString());
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
                            text: "เสื้อ",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                        // TextSpan(
                        //   text: "*",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText2!
                        //       .copyWith(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.red),
                        // ),
                        // TextSpan(
                        //   text: ":",
                        //   style:
                        //       Theme.of(context).textTheme.bodyText2!.copyWith(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        // ),
                      ]),
                    )),
                // const SizedBox(height: 3),
                Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Image.asset(
                        "assets/images/person1.webp",
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "ขนาดเสื้อ",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                        // TextSpan(
                        //   text: "*",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText2!
                        //       .copyWith(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.red),
                        // ),
                        // TextSpan(
                        //   text: ":",
                        //   style:
                        //       Theme.of(context).textTheme.bodyText2!.copyWith(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        // ),
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
                    'XS',
                    'S',
                    'M',
                    'L',
                    'XL',
                    '2XL',
                    '3XL',
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
                // Row(
                //   children: [
                //     Expanded(
                //       child: CustomTextFormField2(
                //         readOnly: true,
                //         focusNode: _focusNodes[2],
                //         hintText: serialNum_ == "" ? "เลือก" : serialNum_,
                //         inputType: TextInputType.text,
                //         textEditingController: createNewRequestController
                //             .serialNumberController.value,
                //         capitalization: TextCapitalization.words,
                //         maxLine: 1,
                //       ),
                //     ),
                //     Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                //     Expanded(
                //         flex: 0,
                //         child: GestureDetector(
                //           onTap: () {
                //             showSerialNumber(listDeviceListByCIType);
                //           },
                //           child: Container(
                //             width: 50,
                //             child: Image.asset(
                //               "assets/images/search_all.png",
                //               // width: 15,
                //             ),
                //           ),
                //         )),
                // Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                // Expanded(
                //     flex: 0,
                //     child: GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         width: 50,
                //         child: Image.asset(
                //           "assets/images/search_me.png",
                //           // width: 15,
                //         ),
                //       ),
                //     )),
                // ],
                // ),
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
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "ที่อยู่จัดส่ง",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                      ]),
                    )),
                const SizedBox(height: 5),
                // Align(
                //     alignment: Alignment.centerLeft,
                //     child: RichText(
                //       textAlign: TextAlign.left,
                //       text: TextSpan(children: <TextSpan>[
                //         TextSpan(
                //             text: "ที่อยู่",
                //             style:
                //                 Theme.of(context).textTheme.bodyText2!.copyWith(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                     )),
                //         TextSpan(
                //           text: "*",
                //           style: Theme.of(context)
                //               .textTheme
                //               .bodyText2!
                //               .copyWith(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.red),
                //         ),
                //         TextSpan(
                //           text: ":",
                //           style:
                //               Theme.of(context).textTheme.bodyText2!.copyWith(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //         ),
                //       ]),
                //     )),
                // const SizedBox(height: 3),

                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "บ้านเลขที่:",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  hintText: "บ้านเลขที่",
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  hintText: "ตำบล/แขวง",
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  hintText: "อำเภอ/เขต",
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  hintText: "จังหวัด",
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  hintText: "รหัสไปรษณีย์",
                  inputType: TextInputType.text,
                  textEditingController: editLayerController,
                  capitalization: TextCapitalization.words,
                  maxLine: 1,
                  sufix: Icon(Icons.edit),
                ),
                SizedBox(
                  height: 15,
                ),

                // CustomDropdown.search(
                //   hintText: 'เลือก',
                //   hintStyle: TextStyle(
                //       color: AppTheme.isLightTheme == false
                //           ? const Color(0xffF4F4F4)
                //           : const Color(0xff353045),
                //       fontSize: 16),
                //   items: symptomListByCITypeItems.isEmpty
                //       ? nullItems
                //       : symptomListByCITypeItems,
                //   controller: selectSymptomCtrl,
                //   onChanged: (x) {
                //     _isShowSymptomOther = false;
                //     if (x.isNotEmpty) {
                //       if (x == "กำหนดเอง") {
                //         symptomID = -1;
                //         _isShowSymptomOther = true;
                //       } else {
                //         var result = listSymptomListByCIType
                //             .where((element) => element.name == x);
                //         symptomID = result.last.id;
                //       }
                //       setState(() {});

                //       print("symptomID = " + symptomID.toString());
                //       print(_isShowSymptomOther);
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

                // const SizedBox(height: 15),
                // Visibility(
                //   visible: _isShowSymptomOther,
                //   child: Column(
                //     children: [
                //       Align(
                //           alignment: Alignment.centerLeft,
                //           child: RichText(
                //             textAlign: TextAlign.left,
                //             text: TextSpan(children: <TextSpan>[
                //               TextSpan(
                //                   text: "กำหนดเอง",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .bodyText2!
                //                       .copyWith(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.bold,
                //                       )),
                //               TextSpan(
                //                 text: "*",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .bodyText2!
                //                     .copyWith(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.red),
                //               ),
                //               TextSpan(
                //                 text: ":",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .bodyText2!
                //                     .copyWith(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //               ),
                //             ]),
                //           )),
                //       CustomTextFormField2(
                //         // readOnly: true,
                //         focusNode: _focusNodes[4],
                //         hintText: "ระบุอาการ...",
                //         inputType: TextInputType.text,
                //         textEditingController: createNewRequestController
                //             .symptomOtherController.value,
                //         capitalization: TextCapitalization.words,
                //         maxLine: 1,
                //       ),
                //       const SizedBox(height: 15),
                //     ],
                //   ),
                // ),

                // Align(
                //     alignment: Alignment.centerLeft,
                //     child: RichText(
                //       textAlign: TextAlign.left,
                //       text: TextSpan(children: <TextSpan>[
                //         TextSpan(
                //             text: "รายละเอียดเพิ่มเติมอื่น ๆ",
                //             style:
                //                 Theme.of(context).textTheme.bodyText2!.copyWith(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                     )),
                //       ]),
                //     )),
                // CustomTextFormField2(
                //   focusNode: _focusNodes[5],
                //   hintText: "ระบุรายละเอียด...",
                //   inputType: TextInputType.text,
                //   textEditingController:
                //       createNewRequestController.symptomDetailController.value,
                //   capitalization: TextCapitalization.words,
                //   maxLine: 3,
                // ),
                // const SizedBox(height: 15),
                // Row(
                //   children: [
                //     Expanded(
                //       child: InkWell(
                //         focusColor: Colors.transparent,
                //         highlightColor: Colors.transparent,
                //         hoverColor: Colors.transparent,
                //         splashColor: Colors.transparent,
                //         onTap: () {
                //           ShowDevices deviceadd = ShowDevices(
                //               agentID: agentID,
                //               symptom: symptomID,
                //               symptomOther: createNewRequestController
                //                       .symptomOtherController.value.text ??
                //                   "",
                //               symptomDetail: createNewRequestController
                //                       .symptomDetailController.value.text ??
                //                   "",
                //               asset: selectAssetCtrl.text,
                //               serialNumber: serialNum_,
                //               symptomName: selectSymptomCtrl.text);

                //           devicesItem.add(deviceadd);

                //           // devicesItem.isEmpty
                //           //     ? _isShowEquipment = false
                //           //     : _isShowEquipment = true;

                //           print(devicesItem.length);
                //           setState(() {});
                //         },
                //         child: customButton(
                //             HexColor(AppTheme.primaryColorString!),
                //             "เพิ่ม",
                //             HexColor(AppTheme.secondaryColorString!),
                //             context),
                //       ),
                //     ),
                //     Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                //     Expanded(
                //       child: Center(),
                //     ),
                //   ],
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
                // const SizedBox(height: 15),
                // Visibility(
                //   visible: devicesItem.isEmpty
                //       ? _isShowEquipment = false
                //       : _isShowEquipment = true,
                //   child: ListView(
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     children: [
                //       Container(
                //         // height:
                //         //     MediaQuery.of(context).copyWith().size.height * 0.3,
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: HexColor(AppTheme.primaryColorString!),
                //           ),
                //           borderRadius: BorderRadius.circular(20),
                //           // color: const Color(0xffE3F6F5)
                //         ),
                //         padding: EdgeInsets.symmetric(vertical: 5),
                //         child: Scrollbar(
                //           thickness: 5,
                //           radius: const Radius.circular(20),
                //           scrollbarOrientation: ScrollbarOrientation.right,
                //           child: ListView.builder(
                //               physics: ScrollPhysics(),
                //               scrollDirection: Axis.vertical,
                //               shrinkWrap: true,
                //               itemCount: devicesItem.length,
                //               itemBuilder: (context, index) {
                //                 return devicesItem.isNotEmpty
                //                     ? Column(
                //                         children: [
                //                           Container(
                //                               padding: const EdgeInsets.all(5),
                //                               // color: const Color(0xffE3F6F5),
                //                               child: Row(
                //                                 // mainAxisAlignment: MainAxisAlignment.start,
                //                                 children: [
                //                                   Expanded(
                //                                     flex: 0,
                //                                     child: GestureDetector(
                //                                       onTap: () {
                //                                         devicesItem
                //                                             .removeAt(index);
                //                                         setState(() {});
                //                                       },
                //                                       child: Padding(
                //                                         padding:
                //                                             const EdgeInsets
                //                                                 .all(10.0),
                //                                         child: Image.asset(
                //                                           "assets/images/Trash.png",
                //                                           width: 25,
                //                                           height: 25,
                //                                         ),
                //                                       ),
                //                                     ),
                //                                   ),
                //                                   Expanded(
                //                                       child: Column(
                //                                     crossAxisAlignment:
                //                                         CrossAxisAlignment
                //                                             .start,
                //                                     children: [
                //                                       Text(
                //                                           devicesItem[index]
                //                                               .serialNumber!,
                //                                           style: Theme.of(
                //                                                   context)
                //                                               .textTheme
                //                                               .bodyText2!
                //                                               .copyWith(
                //                                                   fontSize: 16,
                //                                                   fontWeight:
                //                                                       FontWeight
                //                                                           .bold,
                //                                                   decoration:
                //                                                       TextDecoration
                //                                                           .underline,
                //                                                   color: HexColor(
                //                                                       AppTheme
                //                                                           .primaryColorString!))),
                //                                       const Padding(
                //                                           padding:
                //                                               EdgeInsets.only(
                //                                                   bottom: 3)),
                //                                       Text(
                //                                           devicesItem[index]
                //                                                       .symptomName! !=
                //                                                   "กำหนดเอง"
                //                                               ? devicesItem[
                //                                                       index]
                //                                                   .symptomName!
                //                                               : devicesItem[
                //                                                       index]
                //                                                   .symptomOther!,
                //                                           style:
                //                                               Theme.of(context)
                //                                                   .textTheme
                //                                                   .bodyText2!
                //                                                   .copyWith(
                //                                                     fontSize:
                //                                                         16,
                //                                                     fontWeight:
                //                                                         FontWeight
                //                                                             .normal,
                //                                                   )),
                //                                     ],
                //                                   )),
                //                                 ],
                //                               )),
                //                           // if (devicesItem.length != 1 &&  devicesItem.last)
                //                           devicesItem.length != 1
                //                               ? index !=
                //                                       (devicesItem.length - 1)
                //                                   ? Padding(
                //                                       padding: const EdgeInsets
                //                                               .symmetric(
                //                                           horizontal: 25),
                //                                       child: Divider(
                //                                         height: 2,
                //                                         thickness: 2,
                //                                         indent: 30,
                //                                         endIndent: 30,
                //                                         color:
                //                                             AppTheme.isLightTheme ==
                //                                                     false
                //                                                 ? const Color(
                //                                                     0xff353045)
                //                                                 : const Color(
                //                                                     0xffF4F4F4),
                //                                       ),
                //                                     )
                //                                   : Center()
                //                               : Center()
                //                         ],
                //                       )
                //                     : Center(
                //                         child: Text("ไม่มีข้อมูล",
                //                             style: Theme.of(context)
                //                                 .textTheme
                //                                 .bodyText2!
                //                                 .copyWith(
                //                                   fontSize: 16,
                //                                   fontWeight: FontWeight.normal,
                //                                 )));
                //               }),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _processIndex =
                                (_processIndex - 1) % _processes.length;
                          });
                          // Get.to(
                          //   const LoginScreen(),
                          //   transition:
                          //       Transition.rightToLeft,
                          //   duration: const Duration(
                          //       milliseconds: 500),
                          // );
                        },
                        child: customButton(
                            AppTheme.isLightTheme == false
                                ? const Color(0xffE9F8F7)
                                : const Color(0xffE9F8F7),
                            "ย้อนกลับ",
                            AppTheme.isLightTheme == false
                                ? HexColor(AppTheme.primaryColorString!)
                                : HexColor(AppTheme.primaryColorString!),
                            context),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Expanded(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _processIndex =
                                (_processIndex + 1) % _processes.length;
                          });
                        },
                        child: customButton(
                            HexColor(AppTheme.primaryColorString!),
                            "ต่อไป",
                            HexColor(AppTheme.secondaryColorString!),
                            context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
    );
  }

  // Widget Section3() {
  //   return Expanded(
  //     child: Scrollbar(
  //       thickness: 5,
  //       radius: const Radius.circular(20),
  //       scrollbarOrientation: ScrollbarOrientation.right,
  //       child: ListView(
  //           physics: ClampingScrollPhysics(),
  //           shrinkWrap: true,
  //           children: [
  //             Column(
  //               children: [
  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "ชื่อผู้ใช้:",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyText2!
  //                                 .copyWith(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 )),
  //                       ]),
  //                     )),
  //                 // const SizedBox(height: 3),
  //                 CustomDropdown.search(
  //                   hintText: 'เลือก',
  //                   hintStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xffF4F4F4)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   items: requesterItems.isEmpty ? nullItems : requesterItems,
  //                   controller: selectRequesterCtrl,
  //                   onChanged: (x) {
  //                     // selectRequesterCtrl.text = "";
  //                     if (x.isNotEmpty) {
  //                       // var result =
  //                       //     listRequester.where((element) => element.name == x);
  //                       requesterID = x;
  //                       futureDetailUser =
  //                           DataAPI().getDetailUser(requesterID!);
  //                       futureDetailUser!.then((value) async {
  //                         setState(() {
  //                           listDetailUser = value;
  //                           String firstname = listDetailUser.firstname!;
  //                           String lastname = listDetailUser.lastname!;
  //                           // ignore: prefer_interpolation_to_compose_strings
  //                           requesterName = firstname + " " + lastname;
  //                           requesterEmail = listDetailUser.email!;

  //                           // if (requesterEmail == null ||
  //                           //     requesterEmail == "") {
  //                           //   createNewRequestController.emailController.value =
  //                           //       "ไม่ได้ระบุอีเมล" as TextEditingController;
  //                           // } else {
  //                           //   createNewRequestController.emailController.value =
  //                           //       listDetailUser.email as TextEditingController;
  //                           // }

  //                           // createNewRequestController.emailController.value = requesterEmail.isEmpty ||
  //                           // requesterPhone= listDetailUser.p!;
  //                           // requesterOfficePhone;
  //                         });
  //                       });

  //                       // print("requesterID = " + requesterID!);
  //                       print(listDetailUser.toString());
  //                     }
  //                   },
  //                   fillColor: AppTheme.isLightTheme == false
  //                       ? const Color(0xff353045)
  //                       : const Color(0xffF4F4F4),
  //                   selectedStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xffF4F4F4)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   listItemStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xff353045)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   excludeSelected: false,
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "ชื่อ - สกุล:",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyText2!
  //                                 .copyWith(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 )),
  //                       ]),
  //                     )),
  //                 CustomTextFormField2(
  //                   readOnly: true,
  //                   focusNode: _focusNodes[6],
  //                   hintText: requesterName ?? "-",
  //                   inputType: TextInputType.text,
  //                   textEditingController:
  //                       createNewRequestController.fullnameController.value,
  //                   capitalization: TextCapitalization.words,
  //                   maxLine: 1,
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "อีเมล:",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyText2!
  //                                 .copyWith(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 )),
  //                       ]),
  //                     )),
  //                 CustomTextFormField2(
  //                   // readOnly: true,
  //                   focusNode: _focusNodes[7],
  //                   hintText: requesterEmail == null || requesterEmail == ""
  //                       ? "ระบุอีเมล..."
  //                       : requesterEmail!,
  //                   inputType: TextInputType.emailAddress,
  //                   textEditingController:
  //                       createNewRequestController.emailController.value,
  //                   capitalization: TextCapitalization.words,
  //                   maxLine: 1,
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "เบอร์มือถือ:",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyText2!
  //                                 .copyWith(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 )),
  //                       ]),
  //                     )),
  //                 CustomTextFormField2(
  //                   // readOnly: true,
  //                   focusNode: _focusNodes[8],
  //                   hintText: "ระบุเบอร์มือถือ...",
  //                   inputType: TextInputType.phone,
  //                   textEditingController:
  //                       createNewRequestController.phoneController.value,
  //                   capitalization: TextCapitalization.words,
  //                   maxLine: 1,
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "เบอร์ออฟฟิศ:",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyText2!
  //                                 .copyWith(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                 )),
  //                       ]),
  //                     )),
  //                 CustomTextFormField2(
  //                   // readOnly: true,
  //                   focusNode: _focusNodes[9],
  //                   hintText: "ระบุเบอร์ออฟฟิศ...",
  //                   inputType: TextInputType.phone,
  //                   textEditingController:
  //                       createNewRequestController.officePhoneController.value,
  //                   capitalization: TextCapitalization.words,
  //                   maxLine: 1,
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: InkWell(
  //                         focusColor: Colors.transparent,
  //                         highlightColor: Colors.transparent,
  //                         hoverColor: Colors.transparent,
  //                         splashColor: Colors.transparent,
  //                         onTap: () {
  //                           setState(() {
  //                             _processIndex =
  //                                 (_processIndex - 1) % _processes.length;
  //                           });
  //                           // Get.to(
  //                           //   const LoginScreen(),
  //                           //   transition:
  //                           //       Transition.rightToLeft,
  //                           //   duration: const Duration(
  //                           //       milliseconds: 500),
  //                           // );
  //                         },
  //                         child: customButton(
  //                             AppTheme.isLightTheme == false
  //                                 ? const Color(0xffE9F8F7)
  //                                 : const Color(0xffE9F8F7),
  //                             "ย้อนกลับ",
  //                             AppTheme.isLightTheme == false
  //                                 ? HexColor(AppTheme.primaryColorString!)
  //                                 : HexColor(AppTheme.primaryColorString!),
  //                             context),
  //                       ),
  //                     ),
  //                     Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
  //                     Expanded(
  //                       child: InkWell(
  //                         focusColor: Colors.transparent,
  //                         highlightColor: Colors.transparent,
  //                         hoverColor: Colors.transparent,
  //                         splashColor: Colors.transparent,
  //                         onTap: () {
  //                           setState(() {
  //                             _processIndex =
  //                                 (_processIndex + 1) % _processes.length;
  //                           });
  //                         },
  //                         child: customButton(
  //                             HexColor(AppTheme.primaryColorString!),
  //                             "ต่อไป",
  //                             HexColor(AppTheme.secondaryColorString!),
  //                             context),
  //                       ),
  //                       // child: InkWell(
  //                       //   focusColor: Colors.transparent,
  //                       //   highlightColor: Colors.transparent,
  //                       //   hoverColor: Colors.transparent,
  //                       //   splashColor: Colors.transparent,
  //                       //   onTap: () {
  //                       //     uploadFileItem.clear();
  //                       //     devices.clear();
  //                       //     if (_files.length > 0) {
  //                       //       _files.forEach((element) {
  //                       //         Uint8List base64 =
  //                       //             File(element.path).readAsBytesSync();
  //                       //         img64 = base64Encode(base64);

  //                       //         Files addFile = Files(
  //                       //             fileId: Guid.newGuid.toString(),
  //                       //             fileName: element.path.split("/").last,
  //                       //             contentBase64: img64);

  //                       //         uploadFileItem.add(addFile);
  //                       //       });
  //                       //     }

  //                       //     if (devicesItem.length > 0) {
  //                       //       devicesItem.forEach((element) {
  //                       //         Devices addDevices = Devices(
  //                       //             agentID: element.agentID,
  //                       //             symptom: element.symptom,
  //                       //             symptomOther: element.symptomOther ?? "",
  //                       //             symptomDetail: element.symptomDetail ?? "");

  //                       //         devices.add(addDevices);
  //                       //       });
  //                       //     }

  //                       //     SendRequest sendRequest = SendRequest(
  //                       //         userID: requesterID,
  //                       //         fullname: requesterName,
  //                       //         email: createNewRequestController
  //                       //                     .emailController.value.text ==
  //                       //                 ""
  //                       //             ? requesterEmail
  //                       //             : createNewRequestController
  //                       //                 .emailController.value.text,
  //                       //         phone: createNewRequestController
  //                       //             .phoneController.value.text,
  //                       //         officePhone: createNewRequestController
  //                       //             .officePhoneController.value.text);

  //                       //     TicketAPI ticket = new TicketAPI();
  //                       //     SaveIncidentTicket saveIncidentTicket =
  //                       //         SaveIncidentTicket();
  //                       //     saveIncidentTicket.id = 0;
  //                       //     saveIncidentTicket.departmentID = departmentID;
  //                       //     saveIncidentTicket.ciType = parentID;
  //                       //     saveIncidentTicket.manufacture = manufacture;
  //                       //     saveIncidentTicket.province = province;
  //                       //     saveIncidentTicket.description =
  //                       //         createNewRequestController
  //                       //             .descriptionIncidentController.value.text;
  //                       //     saveIncidentTicket.techgroup = techgroupID;
  //                       //     saveIncidentTicket.technician = technician;
  //                       //     saveIncidentTicket.statusID = 9;
  //                       //     saveIncidentTicket.creater = creater;
  //                       //     saveIncidentTicket.files = uploadFileItem;
  //                       //     saveIncidentTicket.requester = sendRequest;
  //                       //     saveIncidentTicket.devices = devices;

  //                       //     ticket
  //                       //         .saveIncidentTicket(saveIncidentTicket)
  //                       //         .then((value) {
  //                       //       print(value);
  //                       //       if (value.statusCode == "200") {
  //                       //         AwesomeDialog(
  //                       //           context: context,
  //                       //           dialogType: DialogType.success,
  //                       //           animType: AnimType.rightSlide,
  //                       //           title: 'บันทึกคำร้องสำเร็จ',
  //                       //           desc: "หมายเลขคำร้อง : ${value.data}",
  //                       //           btnOkOnPress: () {
  //                       //             Navigator.pop(context);
  //                       //           },
  //                       //         ).show();
  //                       //       } else {
  //                       //         AwesomeDialog(
  //                       //           context: context,
  //                       //           dialogType: DialogType.error,
  //                       //           animType: AnimType.rightSlide,
  //                       //           title: 'เกิดข้อผิดพลาด',
  //                       //           desc:
  //                       //               "ไม่สามารถบันทึกคำร้องได้ กรุณาดำเนินการใหม่อีกครั้ง",
  //                       //           btnOkOnPress: () {},
  //                       //         ).show();
  //                       //       }
  //                       //     });

  //                       //     print("saveIncidentTicket" +
  //                       //         saveIncidentTicket.toString());
  //                       //         Navigator.push(
  //                       //           context,
  //                       //           MaterialPageRoute(builder: (context) {
  //                       //             var requestDataByID2 = RequestDataByID;
  //                       //             return ViewEventScreen(requestDataByID: requestDataByID,);
  //                       //           }),);
  //                       //   },
  //                       //   child: customButton(
  //                       //       HexColor(AppTheme.primaryColorString!),
  //                       //       "บันทึก",
  //                       //       HexColor(AppTheme.secondaryColorString!),
  //                       //       context),
  //                       // ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ]),
  //     ),
  //   );
  // }

  // Widget Section4() {
  //     return Expanded(
  //       child: ListView(
  //           // physics: ClampingScrollPhysics(),
  //           // shrinkWrap: true,
  //           children: [
  //             Column(
  //               children: [
  //                 Text(
  //                     "โปรดระบุครุภัณฑ์และซีเรียลนัมเบอร์เครื่องที่ต้องการแจ้งปัญหา",
  //                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.normal,
  //                         )),
  //                 const SizedBox(height: 10),
  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "ชนิดของอุปกรณ์",
  //                             style:
  //                                 Theme.of(context).textTheme.bodyText2!.copyWith(
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.bold,
  //                                     )),
  //                         TextSpan(
  //                           text: "*",
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .bodyText2!
  //                               .copyWith(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.red),
  //                         ),
  //                         TextSpan(
  //                           text: ":",
  //                           style:
  //                               Theme.of(context).textTheme.bodyText2!.copyWith(
  //                                     fontSize: 16,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                         ),
  //                       ]),
  //                     )),
  //                 // const SizedBox(height: 3),
  //                 CustomDropdown.search(
  //                   hintText: 'เลือก',
  //                   hintStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xffF4F4F4)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   items: assetItems.isEmpty ? nullItems : assetItems,
  //                   controller: selectAssetCtrl,
  //                   onChanged: (x) {
  //                     selectSymptomCtrl.text = "";
  //                     if (x.isNotEmpty) {
  //                       var result =
  //                           listAsset.where((element) => element.name == x);
  //                       cITypeID = result.last.id;
  //                       futureDeviceListByCIType =
  //                           DataAPI().getDeviceListByCIType(cITypeID!, "", 2);
  //                       futureDeviceListByCIType!.then((value) async {
  //                         setState(() {
  //                           listDeviceListByCIType = value;
  //                         });
  //                       });

  //                       futureSymptomListByCIType =
  //                           DataAPI().getSymptomListByCIType(cITypeID!);
  //                       futureSymptomListByCIType!.then((value) async {
  //                         setState(() {
  //                           symptomListByCITypeItems.clear();
  //                           listSymptomListByCIType = value;

  //                           if (listSymptomListByCIType.isNotEmpty) {
  //                             for (var i in value) {
  //                               String? name = i.name;
  //                               symptomListByCITypeItems.add(name!);
  //                             }
  //                             print(symptomListByCITypeItems);
  //                             String? other = "กำหนดเอง";
  //                             symptomListByCITypeItems.add(other);
  //                             print(symptomListByCITypeItems);
  //                           }
  //                         });
  //                       });
  //                       print("cITypeID = " + cITypeID.toString());
  //                       print(x);
  //                     }
  //                   },
  //                   fillColor: AppTheme.isLightTheme == false
  //                       ? const Color(0xff353045)
  //                       : const Color(0xffF4F4F4),
  //                   selectedStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xffF4F4F4)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   listItemStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xff353045)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   excludeSelected: false,
  //                 ),

  //                 const SizedBox(height: 15),
  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "ซีเรียลนัมเบอร์",
  //                             style:
  //                                 Theme.of(context).textTheme.bodyText2!.copyWith(
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.bold,
  //                                     )),
  //                         TextSpan(
  //                           text: "*",
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .bodyText2!
  //                               .copyWith(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.red),
  //                         ),
  //                         TextSpan(
  //                           text: ":",
  //                           style:
  //                               Theme.of(context).textTheme.bodyText2!.copyWith(
  //                                     fontSize: 16,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                         ),
  //                       ]),
  //                     )),
  //                 // const SizedBox(height: 3),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: CustomTextFormField2(
  //                         readOnly: true,
  //                         focusNode: _focusNodes[2],
  //                         hintText: serialNum_ == "" ? "เลือก" : serialNum_,
  //                         inputType: TextInputType.text,
  //                         textEditingController: createNewRequestController
  //                             .serialNumberController.value,
  //                         capitalization: TextCapitalization.words,
  //                         maxLine: 1,
  //                       ),
  //                     ),
  //                     Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
  //                     Expanded(
  //                         flex: 0,
  //                         child: GestureDetector(
  //                           onTap: () {
  //                             showSerialNumber(listDeviceListByCIType);
  //                           },
  //                           child: Container(
  //                             width: 50,
  //                             child: Image.asset(
  //                               "assets/images/search_all.png",
  //                               // width: 15,
  //                             ),
  //                           ),
  //                         )),
  //                     // Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
  //                     // Expanded(
  //                     //     flex: 0,
  //                     //     child: GestureDetector(
  //                     //       onTap: () {},
  //                     //       child: Container(
  //                     //         width: 50,
  //                     //         child: Image.asset(
  //                     //           "assets/images/search_me.png",
  //                     //           // width: 15,
  //                     //         ),
  //                     //       ),
  //                     //     )),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "ปัญหา/อาการเสีย",
  //                             style:
  //                                 Theme.of(context).textTheme.bodyText2!.copyWith(
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.bold,
  //                                     )),
  //                         TextSpan(
  //                           text: "*",
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .bodyText2!
  //                               .copyWith(
  //                                   fontSize: 16,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.red),
  //                         ),
  //                         TextSpan(
  //                           text: ":",
  //                           style:
  //                               Theme.of(context).textTheme.bodyText2!.copyWith(
  //                                     fontSize: 16,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                         ),
  //                       ]),
  //                     )),
  //                 // const SizedBox(height: 3),
  //                 CustomDropdown.search(
  //                   hintText: 'เลือก',
  //                   hintStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xffF4F4F4)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   items: symptomListByCITypeItems.isEmpty
  //                       ? nullItems
  //                       : symptomListByCITypeItems,
  //                   controller: selectSymptomCtrl,
  //                   onChanged: (x) {
  //                     _isShowSymptomOther = false;
  //                     if (x.isNotEmpty) {
  //                       if (x == "กำหนดเอง") {
  //                         symptomID = -1;
  //                         _isShowSymptomOther = true;
  //                       } else {
  //                         var result = listSymptomListByCIType
  //                             .where((element) => element.name == x);
  //                         symptomID = result.last.id;
  //                       }
  //                       setState(() {});

  //                       print("symptomID = " + symptomID.toString());
  //                       print(_isShowSymptomOther);
  //                       print(x);
  //                     }
  //                   },
  //                   fillColor: AppTheme.isLightTheme == false
  //                       ? const Color(0xff353045)
  //                       : const Color(0xffF4F4F4),
  //                   selectedStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xffF4F4F4)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   listItemStyle: TextStyle(
  //                       color: AppTheme.isLightTheme == false
  //                           ? const Color(0xff353045)
  //                           : const Color(0xff353045),
  //                       fontSize: 16),
  //                   excludeSelected: false,
  //                 ),

  //                 const SizedBox(height: 15),
  //                 Visibility(
  //                   visible: _isShowSymptomOther,
  //                   child: Column(
  //                     children: [
  //                       Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: RichText(
  //                             textAlign: TextAlign.left,
  //                             text: TextSpan(children: <TextSpan>[
  //                               TextSpan(
  //                                   text: "กำหนดเอง",
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .bodyText2!
  //                                       .copyWith(
  //                                         fontSize: 16,
  //                                         fontWeight: FontWeight.bold,
  //                                       )),
  //                               TextSpan(
  //                                 text: "*",
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodyText2!
  //                                     .copyWith(
  //                                         fontSize: 16,
  //                                         fontWeight: FontWeight.bold,
  //                                         color: Colors.red),
  //                               ),
  //                               TextSpan(
  //                                 text: ":",
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodyText2!
  //                                     .copyWith(
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                               ),
  //                             ]),
  //                           )),
  //                       CustomTextFormField2(
  //                         // readOnly: true,
  //                         focusNode: _focusNodes[4],
  //                         hintText: "ระบุอาการ...",
  //                         inputType: TextInputType.text,
  //                         textEditingController: createNewRequestController
  //                             .symptomOtherController.value,
  //                         capitalization: TextCapitalization.words,
  //                         maxLine: 1,
  //                       ),
  //                       const SizedBox(height: 15),
  //                     ],
  //                   ),
  //                 ),

  //                 Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: RichText(
  //                       textAlign: TextAlign.left,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: "รายละเอียดเพิ่มเติมอื่น ๆ",
  //                             style:
  //                                 Theme.of(context).textTheme.bodyText2!.copyWith(
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.bold,
  //                                     )),
  //                       ]),
  //                     )),
  //                 CustomTextFormField2(
  //                   focusNode: _focusNodes[5],
  //                   hintText: "ระบุรายละเอียด...",
  //                   inputType: TextInputType.text,
  //                   textEditingController:
  //                       createNewRequestController.symptomDetailController.value,
  //                   capitalization: TextCapitalization.words,
  //                   maxLine: 3,
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: InkWell(
  //                         focusColor: Colors.transparent,
  //                         highlightColor: Colors.transparent,
  //                         hoverColor: Colors.transparent,
  //                         splashColor: Colors.transparent,
  //                         onTap: () {
  //                           ShowDevices deviceadd = ShowDevices(
  //                               agentID: agentID,
  //                               symptom: symptomID,
  //                               symptomOther: createNewRequestController
  //                                       .symptomOtherController.value.text ??
  //                                   "",
  //                               symptomDetail: createNewRequestController
  //                                       .symptomDetailController.value.text ??
  //                                   "",
  //                               asset: selectAssetCtrl.text,
  //                               serialNumber: serialNum_,
  //                               symptomName: selectSymptomCtrl.text);

  //                           devicesItem.add(deviceadd);

  //                           // devicesItem.isEmpty
  //                           //     ? _isShowEquipment = false
  //                           //     : _isShowEquipment = true;

  //                           print(devicesItem.length);
  //                           setState(() {});
  //                         },
  //                         child: customButton(
  //                             HexColor(AppTheme.primaryColorString!),
  //                             "เพิ่ม",
  //                             HexColor(AppTheme.secondaryColorString!),
  //                             context),
  //                       ),
  //                     ),
  //                     Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
  //                     Expanded(
  //                       child: Center(),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 25),
  //                   child: DottedLine(
  //                     dashLength: 10,
  //                     lineThickness: 2,
  //                     dashColor: AppTheme.isLightTheme == false
  //                         ? const Color(0xff353045)
  //                         : const Color(0xffF4F4F4),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Visibility(
  //                   visible: devicesItem.isEmpty
  //                       ? _isShowEquipment = false
  //                       : _isShowEquipment = true,
  //                   child: ListView(
  //                     shrinkWrap: true,
  //                     physics: NeverScrollableScrollPhysics(),
  //                     children: [
  //                       Container(
  //                         // height:
  //                         //     MediaQuery.of(context).copyWith().size.height * 0.3,
  //                         width: double.infinity,
  //                         decoration: BoxDecoration(
  //                           border: Border.all(
  //                             color: HexColor(AppTheme.primaryColorString!),
  //                           ),
  //                           borderRadius: BorderRadius.circular(20),
  //                           // color: const Color(0xffE3F6F5)
  //                         ),
  //                         padding: EdgeInsets.symmetric(vertical: 5),
  //                         child: Scrollbar(
  //                           thickness: 5,
  //                           radius: const Radius.circular(20),
  //                           scrollbarOrientation: ScrollbarOrientation.right,
  //                           child: ListView.builder(
  //                               physics: ScrollPhysics(),
  //                               scrollDirection: Axis.vertical,
  //                               shrinkWrap: true,
  //                               itemCount: devicesItem.length,
  //                               itemBuilder: (context, index) {
  //                                 return devicesItem.isNotEmpty
  //                                     ? Column(
  //                                         children: [
  //                                           Container(
  //                                               padding: const EdgeInsets.all(5),
  //                                               // color: const Color(0xffE3F6F5),
  //                                               child: Row(
  //                                                 // mainAxisAlignment: MainAxisAlignment.start,
  //                                                 children: [
  //                                                   Expanded(
  //                                                     flex: 0,
  //                                                     child: GestureDetector(
  //                                                       onTap: () {
  //                                                         devicesItem
  //                                                             .removeAt(index);
  //                                                         setState(() {});
  //                                                       },
  //                                                       child: Padding(
  //                                                         padding:
  //                                                             const EdgeInsets
  //                                                                 .all(10.0),
  //                                                         child: Image.asset(
  //                                                           "assets/images/Trash.png",
  //                                                           width: 25,
  //                                                           height: 25,
  //                                                         ),
  //                                                       ),
  //                                                     ),
  //                                                   ),
  //                                                   Expanded(
  //                                                       child: Column(
  //                                                     crossAxisAlignment:
  //                                                         CrossAxisAlignment
  //                                                             .start,
  //                                                     children: [
  //                                                       Text(
  //                                                           devicesItem[index]
  //                                                               .serialNumber!,
  //                                                           style: Theme.of(
  //                                                                   context)
  //                                                               .textTheme
  //                                                               .bodyText2!
  //                                                               .copyWith(
  //                                                                   fontSize: 16,
  //                                                                   fontWeight:
  //                                                                       FontWeight
  //                                                                           .bold,
  //                                                                   decoration:
  //                                                                       TextDecoration
  //                                                                           .underline,
  //                                                                   color: HexColor(
  //                                                                       AppTheme
  //                                                                           .primaryColorString!))),
  //                                                       const Padding(
  //                                                           padding:
  //                                                               EdgeInsets.only(
  //                                                                   bottom: 3)),
  //                                                       Text(
  //                                                           devicesItem[index]
  //                                                                       .symptomName! !=
  //                                                                   "กำหนดเอง"
  //                                                               ? devicesItem[
  //                                                                       index]
  //                                                                   .symptomName!
  //                                                               : devicesItem[
  //                                                                       index]
  //                                                                   .symptomOther!,
  //                                                           style:
  //                                                               Theme.of(context)
  //                                                                   .textTheme
  //                                                                   .bodyText2!
  //                                                                   .copyWith(
  //                                                                     fontSize:
  //                                                                         16,
  //                                                                     fontWeight:
  //                                                                         FontWeight
  //                                                                             .normal,
  //                                                                   )),
  //                                                     ],
  //                                                   )),
  //                                                 ],
  //                                               )),
  //                                           // if (devicesItem.length != 1 &&  devicesItem.last)
  //                                           devicesItem.length != 1
  //                                               ? index !=
  //                                                       (devicesItem.length - 1)
  //                                                   ? Padding(
  //                                                       padding: const EdgeInsets
  //                                                               .symmetric(
  //                                                           horizontal: 25),
  //                                                       child: Divider(
  //                                                         height: 2,
  //                                                         thickness: 2,
  //                                                         indent: 30,
  //                                                         endIndent: 30,
  //                                                         color:
  //                                                             AppTheme.isLightTheme ==
  //                                                                     false
  //                                                                 ? const Color(
  //                                                                     0xff353045)
  //                                                                 : const Color(
  //                                                                     0xffF4F4F4),
  //                                                       ),
  //                                                     )
  //                                                   : Center()
  //                                               : Center()
  //                                         ],
  //                                       )
  //                                     : Center(
  //                                         child: Text("ไม่มีข้อมูล",
  //                                             style: Theme.of(context)
  //                                                 .textTheme
  //                                                 .bodyText2!
  //                                                 .copyWith(
  //                                                   fontSize: 16,
  //                                                   fontWeight: FontWeight.normal,
  //                                                 )));
  //                               }),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),

  //                 const SizedBox(height: 15),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: InkWell(
  //                         focusColor: Colors.transparent,
  //                         highlightColor: Colors.transparent,
  //                         hoverColor: Colors.transparent,
  //                         splashColor: Colors.transparent,
  //                         onTap: () {
  //                           setState(() {
  //                             _processIndex =
  //                                 (_processIndex - 1) % _processes.length;
  //                           });
  //                           // Get.to(
  //                           //   const LoginScreen(),
  //                           //   transition:
  //                           //       Transition.rightToLeft,
  //                           //   duration: const Duration(
  //                           //       milliseconds: 500),
  //                           // );
  //                         },
  //                         child: customButton(
  //                             AppTheme.isLightTheme == false
  //                                 ? const Color(0xffE9F8F7)
  //                                 : const Color(0xffE9F8F7),
  //                             "ย้อนกลับ",
  //                             AppTheme.isLightTheme == false
  //                                 ? HexColor(AppTheme.primaryColorString!)
  //                                 : HexColor(AppTheme.primaryColorString!),
  //                             context),
  //                       ),
  //                     ),
  //                     Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
  //                     Expanded(
  //                       child: InkWell(
  //                         focusColor: Colors.transparent,
  //                         highlightColor: Colors.transparent,
  //                         hoverColor: Colors.transparent,
  //                         splashColor: Colors.transparent,
  //                         onTap: () {
  //                           setState(() {
  //                             _processIndex =
  //                                 (_processIndex + 1) % _processes.length;
  //                           });
  //                         },
  //                         child: customButton(
  //                             HexColor(AppTheme.primaryColorString!),
  //                             "ต่อไป",
  //                             HexColor(AppTheme.secondaryColorString!),
  //                             context),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ]),
  //     );
  //   }

  Widget Section3() {
    return Expanded(
      child: ListView(
          // physics: ClampingScrollPhysics(),
          // shrinkWrap: true,
          children: [
            Column(
              children: [
                Text("การชำระเงิน",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "สรุปรายการ",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                        // TextSpan(
                        //   text: "*",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText2!
                        //       .copyWith(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.red),
                        // ),
                        // TextSpan(
                        //   text: ":",
                        //   style:
                        //       Theme.of(context).textTheme.bodyText2!.copyWith(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        // ),
                      ]),
                    )),
                Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(child: Center()),
                    //     Expanded(
                    //         flex: 0,
                    //         child: Container(
                    //             padding:
                    //                 const EdgeInsets.symmetric(
                    //                     vertical: 5,
                    //                     horizontal: 15),
                    //             decoration: BoxDecoration(
                    //               color: AppTheme
                    //                           .isLightTheme ==
                    //                       false
                    //                   ? Color.fromARGB(
                    //                       255, 92, 88, 124)
                    //                   : Color.fromARGB(
                    //                       255, 208, 201, 255),
                    //               borderRadius:
                    //                   const BorderRadius.all(
                    //                 Radius.circular(10),
                    //               ),
                    //             ),
                    //             child: Text("เดือนนี้"))),
                    //   ],
                    // ),

                    // Text(
                    //   //  ((listAutogenerated.incident??0)+(listAutogenerated.request??0)).toString(),
                    //   "null",
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .headline6!
                    //         .copyWith(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16,
                    //         )),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Text("งานทั้งหมดในเดือนนี้",
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodyText2!
                    //         .copyWith(
                    //           fontWeight: FontWeight.normal,
                    //           fontSize: 14,
                    //           // color:
                    //           //     const Color(0xff9CA3AF)
                    //         )),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AppTheme.isLightTheme == false
                                        ? Color.fromARGB(255, 255, 150, 150)
                                        : const Color(0xffFFD3D3),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    ),
                                    //     const BorderRadius.all(
                                    //   Radius.circular(10),
                                    // ),
                                  ),
                                  child: Column(
                                    children: [
                                      //         Row(
                                      //           children: [
                                      //             // Image.asset(
                                      //             //   "assets/images/icon_incident.png",
                                      //             //   width: 25,
                                      //             //   height: 25,
                                      //             // ),
                                      //             Padding(
                                      //                 padding: EdgeInsets
                                      //                     .symmetric(
                                      //                         horizontal:
                                      //                             3)),
                                      //             Text("ค่าสมัคร",
                                      //                 style: Theme.of(
                                      //                         context)
                                      //                     .textTheme
                                      //                     .bodyText2!
                                      //                     .copyWith(
                                      //                       fontWeight:
                                      //                           FontWeight
                                      //                               .normal,
                                      //                       fontSize:
                                      //                           16,
                                      //                     )),
                                      //                     Text("งาน",
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyText2!
                                      //     .copyWith(
                                      //       fontWeight:
                                      //           FontWeight.normal,
                                      //       fontSize: 14,
                                      //     )),
                                      //           ],
                                      //         ),
                                      Row(
                                        children: [
                                          Text(
                                            // listAutogenerated.incident.toString() ?? "0",
                                            "ค่าลงทะเบียน",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1)),
                                          //                 Text("500",
                                          //                     style: Theme.of(
                                          //                             context)
                                          //                         .textTheme
                                          //                         .bodyText2!
                                          //                         .copyWith(
                                          //                           fontWeight:
                                          //                               FontWeight
                                          //                                   .normal,
                                          //                           fontSize:
                                          //                               14,
                                          //                         )),
                                          //                         Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 5)),
                                          // Text("บาท",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            // listAutogenerated.incident.toString() ?? "0",
                                            "ค่าจัดส่ง",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1)),
                                          // Text("50",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                          // Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 5)),
                                          // Text("บาท",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            // listAutogenerated.incident.toString() ?? "0",
                                            "รวม",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1)),
                                          // Text("550",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                          // Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 5)),
                                          // Text("บาท",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                        ],
                                      ),
                                    ],
                                  ))),
                          // Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Expanded(
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AppTheme.isLightTheme == false
                                        ? Color.fromARGB(255, 255, 150, 150)
                                        : const Color(0xffFFD3D3),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                    //     const BorderRadius.all(
                                    //   Radius.circular(10),
                                    // ),
                                  ),
                                  child: Column(
                                    children: [
                                      //         Row(
                                      //           children: [
                                      //             // Image.asset(
                                      //             //   "assets/images/icon_incident.png",
                                      //             //   width: 25,
                                      //             //   height: 25,
                                      //             // ),
                                      //             Padding(
                                      //                 padding: EdgeInsets
                                      //                     .symmetric(
                                      //                         horizontal:
                                      //                             3)),
                                      //             Text("ค่าสมัคร",
                                      //                 style: Theme.of(
                                      //                         context)
                                      //                     .textTheme
                                      //                     .bodyText2!
                                      //                     .copyWith(
                                      //                       fontWeight:
                                      //                           FontWeight
                                      //                               .normal,
                                      //                       fontSize:
                                      //                           16,
                                      //                     )),
                                      //                     Text("งาน",
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyText2!
                                      //     .copyWith(
                                      //       fontWeight:
                                      //           FontWeight.normal,
                                      //       fontSize: 14,
                                      //     )),
                                      //           ],
                                      //         ),
                                      Row(
                                        children: [
                                          Text(
                                            // listAutogenerated.incident.toString() ?? "0",
                                            "500 บาท",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                          ),

                                          // Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 10)),
                                          //                 Text("500",
                                          //                     style: Theme.of(
                                          //                             context)
                                          //                         .textTheme
                                          //                         .bodyText2!
                                          //                         .copyWith(
                                          //                           fontWeight:
                                          //                               FontWeight
                                          //                                   .normal,
                                          //                           fontSize:
                                          //                               14,
                                          //                         )),
                                          //                         Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 5)),
                                          // Text("บาท",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            // listAutogenerated.incident.toString() ?? "0",
                                            "50 บาท",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          // Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 1)),
                                          // Text("50",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                          // Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 5)),
                                          // Text("บาท",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            // listAutogenerated.incident.toString() ?? "0",
                                            "550 บาท",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          // Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 1)),
                                          // Text("550",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                          // Padding(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 5)),
                                          // Text("บาท",
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText2!
                                          //         .copyWith(
                                          //           fontWeight:
                                          //               FontWeight.normal,
                                          //           fontSize: 14,
                                          //         )),
                                        ],
                                      ),
                                    ],
                                  ))),
                          // Expanded(
                          //     child: Container(
                          //         padding: const EdgeInsets
                          //                 .symmetric(
                          //             vertical: 15,
                          //             horizontal: 15),
                          //         decoration: BoxDecoration(
                          //           color: AppTheme
                          //                       .isLightTheme ==
                          //                   false
                          //               ? Color.fromARGB(
                          //                   255, 94, 192, 146)
                          //               : Color(0xffD2F2E3),
                          //           borderRadius:
                          //               const BorderRadius.all(
                          //             Radius.circular(10),
                          //           ),
                          //         ),
                          // child: Column(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         // Image.asset(
                          //         //   "assets/images/icon_request.png",
                          //         //   width: 25,
                          //         //   height: 25,
                          //         // ),
                          //         Padding(
                          //             padding: EdgeInsets
                          //                 .symmetric(
                          //                     horizontal:
                          //                         3)),
                          //         Text("Request",
                          //             style: Theme.of(
                          //                     context)
                          //                 .textTheme
                          //                 .bodyText2!
                          //                 .copyWith(
                          //                   fontWeight:
                          //                       FontWeight
                          //                           .normal,
                          //                   fontSize:
                          //                       14,
                          //                 )),
                          //       ],
                          //     ),
                          //     Row(
                          //       children: [
                          //         Text(
                          //           // listAutogenerated
                          //           //         .request
                          //           //         .toString() ??
                          //           //     "0",
                          //           "null",
                          //           style: Theme.of(
                          //                   context)
                          //               .textTheme
                          //               .headline6!
                          //               .copyWith(
                          //                 fontWeight:
                          //                     FontWeight
                          //                         .w800,
                          //                 fontSize: 24,
                          //               ),
                          //         ),
                          //         Padding(
                          //             padding: EdgeInsets
                          //                 .symmetric(
                          //                     horizontal:
                          //                         3)),
                          //         Text("งาน",
                          //             style: Theme.of(
                          //                     context)
                          //                 .textTheme
                          //                 .bodyText2!
                          //                 .copyWith(
                          //                   fontWeight:
                          //                       FontWeight
                          //                           .normal,
                          //                   fontSize:
                          //                       14,
                          //                 )),
                          //       ],
                          //     ),
                          //   ],
                          // )
                          // )
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
                // const SizedBox(height: 3),
                const SizedBox(height: 15),
                // CustomDropdown.search(
                //   hintText: 'เลือก',
                //   hintStyle: TextStyle(
                //       color: AppTheme.isLightTheme == false
                //           ? const Color(0xffF4F4F4)
                //           : const Color(0xff353045),
                //       fontSize: 16),
                //   items: assetItems.isEmpty ? nullItems : assetItems,
                //   controller: selectAssetCtrl,
                //   onChanged: (x) {
                //     selectSymptomCtrl.text = "";
                //     if (x.isNotEmpty) {
                //       var result =
                //           listAsset.where((element) => element.name == x);
                //       cITypeID = result.last.id;
                //       futureDeviceListByCIType =
                //           DataAPI().getDeviceListByCIType(cITypeID!, "", 2);
                //       futureDeviceListByCIType!.then((value) async {
                //         setState(() {
                //           listDeviceListByCIType = value;
                //         });
                //       });

                //       futureSymptomListByCIType =
                //           DataAPI().getSymptomListByCIType(cITypeID!);
                //       futureSymptomListByCIType!.then((value) async {
                //         setState(() {
                //           symptomListByCITypeItems.clear();
                //           listSymptomListByCIType = value;

                //           if (listSymptomListByCIType.isNotEmpty) {
                //             for (var i in value) {
                //               String? name = i.name;
                //               symptomListByCITypeItems.add(name!);
                //             }
                //             print(symptomListByCITypeItems);
                //             String? other = "กำหนดเอง";
                //             symptomListByCITypeItems.add(other);
                //             print(symptomListByCITypeItems);
                //           }
                //         });
                //       });
                //       print("cITypeID = " + cITypeID.toString());
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

                const SizedBox(height: 5),
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "ช่องทางการชำระเงิน",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                      ]),
                    )),
                Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Image.asset(
                        "assets/images/qrcode.jpg",
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    )
                  ],
                ),
                // const SizedBox(height: 3),
                // Row(
                //   children: [
                //     Expanded(
                //       child: CustomTextFormField2(
                //         readOnly: true,
                //         focusNode: _focusNodes[2],
                //         hintText: serialNum_ == "" ? "เลือก" : serialNum_,
                //         inputType: TextInputType.text,
                //         textEditingController: createNewRequestController
                //             .serialNumberController.value,
                //         capitalization: TextCapitalization.words,
                //         maxLine: 1,
                //       ),
                //     ),
                //     Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                //     Expanded(
                //         flex: 0,
                //         child: GestureDetector(
                //           onTap: () {
                //             showSerialNumber(listDeviceListByCIType);
                //           },
                //           child: Container(
                //             width: 50,
                //             child: Image.asset(
                //               "assets/images/search_all.png",
                //               // width: 15,
                //             ),
                //           ),
                //         )),
                //     // Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                //     // Expanded(
                //     //     flex: 0,
                //     //     child: GestureDetector(
                //     //       onTap: () {},
                //     //       child: Container(
                //     //         width: 50,
                //     //         child: Image.asset(
                //     //           "assets/images/search_me.png",
                //     //           // width: 15,
                //     //         ),
                //     //       ),
                //     //     )),
                //   ],
                // ),
                const SizedBox(height: 15),
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "แจ้งการชำระเงิน",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ]),
                    )),
                GestureDetector(
                  onTap: () {
                    getMultipleFile();
                    // Get.to(
                    //   const Home(),
                    //   transition: Transition.downToUp,
                    //   duration: const Duration(milliseconds: 500),
                    // );
                    print(_files);
                    print("กด");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(20),
                      dashPattern: [5, 5, 5, 5, 5, 5],
                      color: const Color(0xFF3A56A0),
                      strokeWidth: 2,
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 221, 230, 251)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Column(
                              children: [
                                Image.asset("assets/images/Archive.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    color: Color(0xFF849BD4)),
                                const SizedBox(height: 5),
                                const Text(
                                  "เพิ่มไฟล์แนบ",
                                  style: TextStyle(
                                      color: Color(0xff595959),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
                // const SizedBox(height: 3),

                // CustomDropdown.search(
                //   hintText: 'เลือก',
                //   hintStyle: TextStyle(
                //       color: AppTheme.isLightTheme == false
                //           ? const Color(0xffF4F4F4)
                //           : const Color(0xff353045),
                //       fontSize: 16),
                //   items: symptomListByCITypeItems.isEmpty
                //       ? nullItems
                //       : symptomListByCITypeItems,
                //   controller: selectSymptomCtrl,
                //   onChanged: (x) {
                //     _isShowSymptomOther = false;
                //     if (x.isNotEmpty) {
                //       if (x == "กำหนดเอง") {
                //         symptomID = -1;
                //         _isShowSymptomOther = true;
                //       } else {
                //         var result = listSymptomListByCIType
                //             .where((element) => element.name == x);
                //         symptomID = result.last.id;
                //       }
                //       setState(() {});

                //       print("symptomID = " + symptomID.toString());
                //       print(_isShowSymptomOther);
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

                // const SizedBox(height: 15),
                // Visibility(
                // CustomTextFormField2(
                //   focusNode: _focusNodes[5],
                //   hintText: "ระบุรายละเอียด...",
                //   inputType: TextInputType.text,
                //   textEditingController:
                //       createNewRequestController.symptomDetailController.value,
                //   capitalization: TextCapitalization.words,
                //   maxLine: 3,
                // ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          ShowDevices deviceadd = ShowDevices(
                              agentID: agentID,
                              symptom: symptomID,
                              symptomOther: createNewRequestController
                                      .symptomOtherController.value.text ??
                                  "",
                              symptomDetail: createNewRequestController
                                      .symptomDetailController.value.text ??
                                  "",
                              asset: selectAssetCtrl.text,
                              serialNumber: serialNum_,
                              symptomName: selectSymptomCtrl.text);

                          devicesItem.add(deviceadd);

                          // devicesItem.isEmpty
                          //     ? _isShowEquipment = false
                          //     : _isShowEquipment = true;

                          print(devicesItem.length);
                          setState(() {});
                        },
                        child: customButton(
                            HexColor(AppTheme.primaryColorString!),
                            "เพิ่ม",
                            HexColor(AppTheme.secondaryColorString!),
                            context),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Expanded(
                      child: Center(),
                    ),
                  ],
                ),
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
                Visibility(
                  visible: devicesItem.isEmpty
                      ? _isShowEquipment = false
                      : _isShowEquipment = true,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        // height:
                        //     MediaQuery.of(context).copyWith().size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor(AppTheme.primaryColorString!),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          // color: const Color(0xffE3F6F5)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Scrollbar(
                          thickness: 5,
                          radius: const Radius.circular(20),
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: ListView.builder(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: devicesItem.length,
                              itemBuilder: (context, index) {
                                return devicesItem.isNotEmpty
                                    ? Column(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              // color: const Color(0xffE3F6F5),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 0,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        devicesItem
                                                            .removeAt(index);
                                                        setState(() {});
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Image.asset(
                                                          "assets/images/Trash.png",
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          devicesItem[index]
                                                              .serialNumber!,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  color: HexColor(
                                                                      AppTheme
                                                                          .primaryColorString!))),
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 3)),
                                                      Text(
                                                          devicesItem[index]
                                                                      .symptomName! !=
                                                                  "กำหนดเอง"
                                                              ? devicesItem[
                                                                      index]
                                                                  .symptomName!
                                                              : devicesItem[
                                                                      index]
                                                                  .symptomOther!,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  )),
                                                    ],
                                                  )),
                                                ],
                                              )),
                                          // if (devicesItem.length != 1 &&  devicesItem.last)
                                          devicesItem.length != 1
                                              ? index !=
                                                      (devicesItem.length - 1)
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 25),
                                                      child: Divider(
                                                        height: 2,
                                                        thickness: 2,
                                                        indent: 30,
                                                        endIndent: 30,
                                                        color:
                                                            AppTheme.isLightTheme ==
                                                                    false
                                                                ? const Color(
                                                                    0xff353045)
                                                                : const Color(
                                                                    0xffF4F4F4),
                                                      ),
                                                    )
                                                  : Center()
                                              : Center()
                                        ],
                                      )
                                    : Center(
                                        child: Text("ไม่มีข้อมูล",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                )));
                              }),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _processIndex =
                                (_processIndex - 1) % _processes.length;
                          });
                          // Get.to(
                          //   const LoginScreen(),
                          //   transition:
                          //       Transition.rightToLeft,
                          //   duration: const Duration(
                          //       milliseconds: 500),
                          // );
                        },
                        child: customButton(
                            AppTheme.isLightTheme == false
                                ? const Color(0xffE9F8F7)
                                : const Color(0xffE9F8F7),
                            "ย้อนกลับ",
                            AppTheme.isLightTheme == false
                                ? HexColor(AppTheme.primaryColorString!)
                                : HexColor(AppTheme.primaryColorString!),
                            context),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Expanded(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2,
                            ),
                            width: 280,
                            buttonsBorderRadius: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                            dismissOnTouchOutside: true,
                            dismissOnBackKeyPress: false,
                            // onDismissCallback: (type) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       content: Text('Dismissed by $type'),
                            //     ),
                            //   );
                            // },
                            headerAnimationLoop: false,
                            animType: AnimType.bottomSlide,
                            title: 'ลงทะเบียนเสร็จสิ้น',
                            // desc:
                            //     'This Dialog can be dismissed touching outside',
                            showCloseIcon: true,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              Get.to(
                                const TabScreen(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 500),
                              );
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
          ]),
    );
  }

  //

  void showSerialNumber(List<DeviceListByCIType> listDeviceListByCIType) {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        // showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        builder: (context) {
          return SizedBox(
              height: MediaQuery.of(context).copyWith().size.height * 0.85,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  // flex: 1,
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )),
                              Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("ค้นหาหมายเลขอุปกรณ์",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            )),
                                  )),
                              Expanded(
                                  // flex: 1,
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: HexColor(
                                          AppTheme.primaryColorString!)),
                                ),
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomTextFormFieldSearch2(
                            radius: 16,
                            onChanged: (value) {
                              // filterSearchResults(value);
                            },
                            cursorColor: HexColor(AppTheme.primaryColorString!),
                            suffixIconColor:
                                HexColor(AppTheme.primaryColorString!),
                            focusNode: _focusNodes[3],
                            hintText: "ระบุชื่ออุปกรณ์",
                            inputType: TextInputType.text,
                            textEditingController: searchController,
                            capitalization: TextCapitalization.words,
                            maxLine: 1,
                            sufix: Icon(Icons.search),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CustomDropdown.search(
                                  hintText: 'เลือก',
                                  hintStyle: TextStyle(
                                      color: AppTheme.isLightTheme == false
                                          ? const Color(0xffF4F4F4)
                                          : const Color(0xff353045),
                                      fontSize: 16),
                                  items: assetItems.isEmpty
                                      ? nullItems
                                      : assetItems,
                                  controller: selectAssetCtrl,
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
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3)),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    String keyword = searchController.text;
                                    listDeviceListByCIType.clear();
                                    futureDeviceListByCIType = DataAPI()
                                        .getDeviceListByCIType(
                                            cITypeID!, keyword, 2);
                                    futureDeviceListByCIType!
                                        .then((value) async {
                                      setState(() {
                                        listDeviceListByCIType = value;
                                        loading = true;
                                      });
                                    });
                                  },
                                  child: customButton2(
                                      AppTheme.isLightTheme == false
                                          ? const Color(0xffE9F8F7)
                                          : const Color(0xffE9F8F7),
                                      "ค้นหา",
                                      AppTheme.isLightTheme == false
                                          ? HexColor(
                                              AppTheme.primaryColorString!)
                                          : HexColor(
                                              AppTheme.primaryColorString!),
                                      context),
                                ),
                              ),
                            ],
                          ),
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
                        ],
                      ),
                    ),
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await Future.delayed(const Duration(seconds: 3));

                        setState(() {
                          _isLoading = false;
                        });
                        setState(() {
                          listDeviceListByCIType;
                        });

                        print(listDeviceListByCIType);
                      },
                      child: Scrollbar(
                          thickness: 5,
                          radius: const Radius.circular(20),
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, bottom: 20),
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: listDeviceListByCIType.length,
                                  itemBuilder: (context, index) {
                                    // var ballPulse;
                                    return Column(children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // _value = true;
                                            serialNum_ =
                                                listDeviceListByCIType[index]
                                                    .serialnumber!;
                                            agentID =
                                                listDeviceListByCIType[index]
                                                    .agentId!;
                                            print("เลือก" + serialNum_);
                                            print("เลือก" + agentID!);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          width: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height,
                                          decoration: BoxDecoration(
                                              color:
                                                  AppTheme.isLightTheme == false
                                                      ? const Color(0xff211F32)
                                                      : const Color(0xffF9F9FA),
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            listDeviceListByCIType[
                                                                        index]
                                                                    .serialnumber! ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            listDeviceListByCIType[
                                                                        index]
                                                                    .ciType! ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                )),
                                                      ],
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //     flex: 0,
                                                  //     child: _value == true
                                                  //         ? RoundCheckBox(
                                                  //             isChecked: true,
                                                  //             size: MediaQuery.of(
                                                  //                         context)
                                                  //                     .size
                                                  //                     .height *
                                                  //                 0.035,
                                                  //             onTap:
                                                  //                 (selected) {},
                                                  //           )
                                                  //         : RoundCheckBox(
                                                  //             isChecked:
                                                  //                 false,
                                                  //             size: MediaQuery.of(
                                                  //                         context)
                                                  //                     .size
                                                  //                     .height *
                                                  //                 0.035,
                                                  //             onTap:
                                                  //                 (selected) {},
                                                  //           ))
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("ยี่ห้อ",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  )),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                              listDeviceListByCIType[
                                                                          index]
                                                                      .brand! ??
                                                                  "",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                        ],
                                                      )),
                                                      Expanded(
                                                          child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("รุ่น",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  )),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                              listDeviceListByCIType[
                                                                          index]
                                                                      .model! ??
                                                                  "",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                        ],
                                                      )),
                                                    ],
                                                  )),
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Owner name",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  )),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                          listDeviceListByCIType[
                                                                      index]
                                                                  .owner! ??
                                                              "",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                    ],
                                                  )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      )
                                    ]);
                                  }))),
                    ))
                  ]));
        });
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}

//   void filterSearchResults(String query) {
//   setState(() {
//     items = duplicateItems
//         .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   });
// }

/// hardcoded bezier painter

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) 
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) 
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'ข้อมูล',
  'กิจกรรม',
  'ชำระเงิน',
];
