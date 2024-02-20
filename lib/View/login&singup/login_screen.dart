// ignore_for_file: avoid_function_literals_in_foreach_calls, library_private_types_in_public_api, deprecated_member_use, depend_on_referenced_packages, prefer_const_constructors

import 'package:rems/View/login&singup/signup_screen.dart';
import 'package:rems/View/tab_screen.dart';
import 'package:rems/theme_old/controller_theme/login_controller.dart';
import 'package:rems/View/splash/welcome_screen.dart';
import 'package:rems/theme_old/config_theme/images.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:rems/theme_old/widgets_theme/custom_buttom.dart';
import 'package:rems/theme_old/widgets_theme/custom_textformfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    loginController.isVisible.value = false;
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.isLightTheme == false
          ? const Color(0xff15141F)
          : const Color(0xffFAF9FF),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: Text(
          "เข้าสู่ระบบ",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppTheme.isLightTheme == false
            ? HexColor('#15141F')
            : HexColor(AppTheme.primaryColorString!),
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
            Get.offAll(WelcomeFirstScreen());
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          // SystemNavigator.pop();
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.36,
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
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   "เข้าสู่ระบบ",
                        //   style:
                        //       Theme.of(context).textTheme.bodyText2!.copyWith(
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        // ),
                        Expanded(
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Column(
                                children: [
                                  // const SizedBox(height: 30),
                                  Obx(() {
                                    return CustomTextFormField(
                                      focusNode: _focusNodes[0],
                                      prefix: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Image.asset(
                                          "assets/images/User.png",
                                          color: _focusNodes[0].hasFocus
                                              ? HexColor(
                                                  AppTheme.primaryColorString!)
                                              : const Color(0xffA2A0A8),
                                          // color:  HexColor(AppTheme.secondaryColorString!)
                                        ),
                                      ),
                                      hintText: "ชื่อผู้ใช้งาน",
                                      inputType: TextInputType.name,
                                      textEditingController: loginController
                                          .mobileController.value,
                                      capitalization: TextCapitalization.none,
                                      // limit: [
                                      //   LengthLimitingTextInputFormatter(10),
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                    );
                                  }),
                                  const SizedBox(height: 24),
                                  Obx(() {
                                    return CustomTextFormField(
                                      focusNode: _focusNodes[1],
                                      sufix: InkWell(
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          loginController.isVisible.value =
                                              !loginController.isVisible.value;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: SvgPicture.asset(
                                            DefaultImages.eye,
                                            // color:  HexColor(AppTheme.secondaryColorString!)
                                          ),
                                        ),
                                      ),
                                      prefix: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: SvgPicture.asset(
                                          DefaultImages.pswd,
                                          color: _focusNodes[1].hasFocus
                                              ? HexColor(
                                                  AppTheme.primaryColorString!)
                                              : const Color(0xffA2A0A8),
                                          // color:  HexColor(AppTheme.secondaryColorString!)
                                        ),
                                      ),
                                      hintText: "รหัสผ่าน",
                                      obscure:
                                          loginController.isVisible.value ==
                                                  true
                                              ? false
                                              : true,
                                      textEditingController:
                                          loginController.pswdController.value,
                                      capitalization: TextCapitalization.none,
                                      limit: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      inputType: TextInputType.visiblePassword,
                                    );
                                  }),
                                  const SizedBox(height: 32),
                                  InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      Get.to(
                                        const TabScreen(),
                                        transition: Transition.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 500),
                                      );
                                      // AccountAPI account = new AccountAPI();
                                      // Authenticate activity =
                                      //     new Authenticate();
                                      // activity.username = loginController
                                      //     .mobileController.value.text;
                                      // activity.password = loginController
                                      //         .pswdController.value.text ??
                                      //     "";

                                      // account
                                      //         .autenticate(activity)
                                      //         .then((value) {
                                      //         if (value.statuscode == "200") {
                                      //           PrefData.setToken(value.res!.token!);
                                      //           PrefData.setID(value.res!.id!);
                                      //           PrefData.setFullname(
                                      //               value.res!.fullName!);
                                      //           PrefData.setUsername(
                                      //               value.res!.username!);
                                      //           PrefData.setLogIn(true);
                                      //           Get.to(
                                      //             const TabScreen(),
                                      //             transition: Transition.rightToLeft,
                                      //             duration: const Duration(
                                      //                 milliseconds: 500),
                                      //           )?.then((result) {
                                      //         // This code will be executed after navigating to TabScreen
                                      //         print(
                                      //             "Navigation to TabScreen completed.");
                                      //       });
                                      //           print("token: " +
                                      //               value.res!.token!.toString());
                                      //           print("ID: " +
                                      //               value.res!.id!.toString());
                                      //         } else {
                                      //           print("incorrect");
                                      //         }
                                      //       }
                                      //      );
                                    },
                                    child: customButton(
                                        HexColor(AppTheme.primaryColorString!),
                                        "เข้าสู่ระบบ",
                                        HexColor(
                                            AppTheme.secondaryColorString!),
                                        context),
                                  ),
                                  InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      Get.to(
                                        const SignUpScreen(),
                                        transition: Transition.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 500),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("ยังไม่มีบัญชีใช่ไหม?",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16,
                                                      color: const Color(
                                                          0xff9CA3AF))),
                                          Text(" ลงทะเบียน",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: HexColor(AppTheme
                                                        .primaryColorString!),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
