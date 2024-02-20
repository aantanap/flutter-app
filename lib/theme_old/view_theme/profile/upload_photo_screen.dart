// ignore_for_file: sized_box_for_whitespace, prefer_const_declarations, deprecated_member_use, unused_import, unused_field, prefer_final_fields, avoid_print, use_build_context_synchronously

import 'package:rems/theme_old/config_theme/images.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
// import 'package:rems/theme_old/view_theme/profile/upload_id_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../model/data/data_model.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({Key? key}) : super(key: key);

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  
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

  //  Future<void> _pullRefresh() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await Future.delayed(const Duration(seconds: 3));

  //   setState(() {
  //     _isLoading = false;
  //   });

  //   setState(() {
  //     // futureSubject.then((value) => )
  //   });
  //   await futureSubject;
  // }
  List<String> uploadImage = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppTheme.isLightTheme == false
                    ? const Color(0xff15141F)
                    : const Color(0xff7C7E8E),
                AppTheme.isLightTheme == false
                    ? const Color(0xff15141F)
                    : const Color(0xff80818E),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/images/Chevron_Left.png",
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.08,
                      color: AppTheme.isLightTheme == false
                          ? const Color(0xffFFFFFF)
                          : const Color(0xff211F32),
                    ),
                    // Icon(
                    //   Icons.arrow_back,
                    //   color: HexColor(AppTheme.secondaryColorString!),
                    // ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  // Text(
                  //   "เปลี่ยนรูปโปรไฟล์",
                  //   style: Theme.of(context).textTheme.headline6!.copyWith(
                  //       fontWeight: FontWeight.w800,
                  //       fontSize: 24,
                  //       color: HexColor(AppTheme.secondaryColorString!)),
                  // ),
                  const SizedBox(
                    height: 4,
                  ),
                  // Text(
                  //   "",
                  //   style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 16,
                  //         color: const Color(0xffCCCACF),
                  //       ),
                  // ),
                  const SizedBox(height: 20),
                  // Stack(
                    // children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30, right: 30),
                      //   child: Container(
                      //     height: 330,
                      //     width: Get.width,
                      //     child: Image.asset(
                      //       DefaultImages.idCard,
                      //       fit: BoxFit.fill,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 28, right: 28),
                      //   child: SizedBox(
                      //     height: 260,
                      //     width: Get.width,
                      //     child: Image.asset(
                      //       DefaultImages.scanPng,
                      //       fit: BoxFit.fill,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 30, right: 30, top: 254),
                      //   child: Container(
                      //     height: Get.height,
                      //     width: Get.width,
                      //     color: Colors.black.withOpacity(0.1),
                      //   ),
                      // )
                    // ],
                  // ),
                ],
              ),
            ),
          ),
          Container(
            height: 190,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppTheme.isLightTheme == false
                  ? const Color(0xff211F32)
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 6,
                    width: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xffE3E8FC)),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
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
                        // onTap: () {
                        //   Get.to(
                        //     const UploadIdScreen(),
                        //     transition: Transition.rightToLeft,
                        //     duration: const Duration(milliseconds: 500),
                        //   );
                        //   // final ImagePicker _picker = ImagePicker();
                        //   // await _picker.pickImage(source: ImageSource.gallery);
                        // },
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: SvgPicture.asset(
                            AppTheme.isLightTheme == false
                                ? DefaultImages.darkGallery
                                : DefaultImages.gallery,
                          ),
                        ),
                      ),
                      InkWell(
                        // onTap: () async {
                        //   Get.to(
                        //     const UploadIdScreen(),
                        //     transition: Transition.rightToLeft,
                        //     duration: const Duration(milliseconds: 500),
                        //   );
                        // },
                        child: SizedBox(
                          height: 96,
                          width: 96,
                          child: SvgPicture.asset(
                            AppTheme.isLightTheme == false
                                ? DefaultImages.darkPhoto
                                : DefaultImages.photo,
                          ),
                        ),
                      ),
                      InkWell(
                        // onTap: () {
                        //   Get.to(
                        //     const UploadIdScreen(),
                        //     transition: Transition.rightToLeft,
                        //     duration: const Duration(milliseconds: 500),
                        //   );
                        // },
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: SvgPicture.asset(AppTheme.isLightTheme == false
                              ? DefaultImages.darkFlash
                              : DefaultImages.flash),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = 3.0;
    final radius = 20.0;
    final tRadius = 2 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 300;
  static double height = 300;
}
