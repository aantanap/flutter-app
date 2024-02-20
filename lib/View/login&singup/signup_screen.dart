// ignore_for_file: avoid_function_literals_in_foreach_calls, deprecated_member_use, depend_on_referenced_packages, prefer_const_constructors

import 'package:rems/View/splash/welcome_screen.dart';
import 'package:rems/model/account/authenticate_model.dart';
import 'package:rems/theme_old/config_theme/images.dart';
import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:rems/theme_old/controller_theme/signup_controller.dart';
import 'package:rems/theme_old/widgets_theme/custom_buttom.dart';
import 'package:rems/theme_old/widgets_theme/custom_textformfield.dart';
import 'package:rems/View//login&singup/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rems/model/account/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  // Authenticate authenticate = Authenticate();
  Profile profile = Profile();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final signUpController = Get.put(SignUpController());
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    signUpController.isVisible.value = false;
    signUpController.isVisibleConfirm.value = false;
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
            "ลงทะเบียน",
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
              Get.to(WelcomeFirstScreen());
            },
          ),
        ),
        body: WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return true;
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
                child: Form(
                  key: formKey,
                  child: Card(
                    elevation: 0,
                    color: AppTheme.isLightTheme == false
                        ? const Color(0xff211F32)
                        : const Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Scrollbar(
                                thickness: 4,
                                radius: const Radius.circular(20),
                                scrollbarOrientation:
                                    ScrollbarOrientation.right,
                                child: ListView(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "ชื่อ:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          
                                          CustomTextFormField(
                                            // onSaved: (String? name) {
                                            //   profile.name = name;
                                            // },
                                            // onSaved: (value) => value!.isNotEmpty
                                            // ? TextEditingController.text = value.trim()
                                            // : null,


                                            
                                            validator: RequiredValidator(
                                                errorText:
                                                    "กรุณาป้อนชื่อของคุณ"),
                                            focusNode: _focusNodes[0],
                                            prefix: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: SvgPicture.asset(
                                                DefaultImages.userName,
                                                color: _focusNodes[0].hasFocus
                                                    ? HexColor(AppTheme
                                                        .primaryColorString!)
                                                    : const Color(0xffA2A0A8),
                                                // color:  HexColor(AppTheme.secondaryColorString!)
                                              ),
                                            ),
                                            hintText: "ชื่อ",
                                            inputType: TextInputType.text,
                                            textEditingController:
                                                signUpController
                                                    .nameController.value,
                                            
                                            capitalization:
                                                TextCapitalization.words,
                                            limit: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-zA-Z ]'))
                                            ],
                                            onSaved: (value) {
                                              signUpController.name.value =
                                                  value!;
                                            },
                                          ),
                                          const SizedBox(height: 15),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "นามสกุล:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          CustomTextFormField(
                                            onSaved: (String? lName) {
                                              profile.lName = lName;
                                            },
                                            validator: RequiredValidator(
                                                errorText:
                                                    "กรุณาป้อนนามสกุลของคุณ"),
                                            focusNode: _focusNodes[1],
                                            prefix: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: SvgPicture.asset(
                                                DefaultImages.userName,
                                                color: _focusNodes[1].hasFocus
                                                    ? HexColor(AppTheme
                                                        .primaryColorString!)
                                                    : const Color(0xffA2A0A8),
                                                // color:  HexColor(AppTheme.secondaryColorString!)
                                              ),
                                            ),
                                            hintText: "นามสกุล",
                                            inputType: TextInputType.text,
                                            textEditingController:
                                                signUpController
                                                    .lNameController.value,
                                            capitalization:
                                                TextCapitalization.words,
                                            limit: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-zA-Z ]'))
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "อีเมล:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          CustomTextFormField(
                                            onSaved: (String? emailAddress) {
                                              profile.emailAddress =
                                                  emailAddress;
                                            },
                                            validator: RequiredValidator(
                                                errorText:
                                                    "กรุณาป้อนอีเมลของคุณ"),
                                            focusNode: _focusNodes[2],
                                            prefix: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: SvgPicture.asset(
                                                DefaultImages.userName,
                                                color: _focusNodes[2].hasFocus
                                                    ? HexColor(AppTheme
                                                        .primaryColorString!)
                                                    : const Color(0xffA2A0A8),
                                                // color:  HexColor(AppTheme.secondaryColorString!)
                                              ),
                                            ),
                                            hintText: "อีเมล",
                                            inputType:
                                                TextInputType.emailAddress,
                                            textEditingController:
                                                signUpController
                                                    .emailAddreesController
                                                    .value,
                                            capitalization:
                                                TextCapitalization.words,
                                            // limit: [
                                            //   FilteringTextInputFormatter.allow(
                                            //       RegExp('[a-zA-Z ]')
                                            //       )
                                            // ],
                                          ),
                                          const SizedBox(height: 15),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "เบอร์โทรศัพท์:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          CustomTextFormField(
                                            onSaved: (String? tel) {
                                              profile.tel = tel;
                                            },
                                            validator: RequiredValidator(
                                                errorText:
                                                    "กรุณาป้อนเบอร์โทรศัพท์ของคุณ"),
                                            focusNode: _focusNodes[3],
                                            prefix: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: SvgPicture.asset(
                                                DefaultImages.userName,
                                                color: _focusNodes[3].hasFocus
                                                    ? HexColor(AppTheme
                                                        .primaryColorString!)
                                                    : const Color(0xffA2A0A8),
                                                // color:  HexColor(AppTheme.secondaryColorString!)
                                              ),
                                            ),
                                            hintText: "เบอร์โทรศัพท์",
                                            inputType: TextInputType.phone,
                                            textEditingController:
                                                signUpController
                                                    .telController.value,
                                            capitalization:
                                                TextCapitalization.none,
                                            limit: [
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "รหัสผ่าน:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          Obx(() {
                                            return CustomTextFormField(
                                              onSaved: (String? password) {
                                                profile.password = password;
                                              },
                                              validator: RequiredValidator(
                                                  errorText:
                                                      "กรุณาป้อนรหัสผ่านของคุณ"),
                                              focusNode: _focusNodes[4],
                                              sufix: InkWell(
                                                focusColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                onTap: () {
                                                  signUpController
                                                          .isVisible.value =
                                                      !signUpController
                                                          .isVisible.value;
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: SvgPicture.asset(
                                                    DefaultImages.eye,
                                                    // color:  HexColor(AppTheme.secondaryColorString!)
                                                  ),
                                                ),
                                              ),
                                              prefix: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: SvgPicture.asset(
                                                  DefaultImages.pswd,
                                                  color: _focusNodes[4].hasFocus
                                                      ? HexColor(AppTheme
                                                          .primaryColorString!)
                                                      : const Color(0xffA2A0A8),
                                                  // color:  HexColor(AppTheme.secondaryColorString!)
                                                ),
                                              ),
                                              hintText: "Password",
                                              obscure: signUpController
                                                          .isVisible.value ==
                                                      true
                                                  ? false
                                                  : true,
                                              textEditingController:
                                                  signUpController
                                                      .passwordController.value,
                                              capitalization:
                                                  TextCapitalization.none,
                                              limit: [
                                                FilteringTextInputFormatter
                                                    .singleLineFormatter,
                                              ],
                                              inputType:
                                                  TextInputType.visiblePassword,
                                            );
                                          }),
                                          const SizedBox(height: 16),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "ยืนยันรหัสผ่าน:",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          Obx(() {
                                            return CustomTextFormField(
                                              onSaved:
                                                  (String? confirmpassword) {
                                                profile.confirmpassword =
                                                    confirmpassword;

                                                return null;
                                              },
                                              validator: RequiredValidator(
                                                  errorText:
                                                      "กรุณาป้อนรหัสผ่านของคุณ"),
                                              focusNode: _focusNodes[5],
                                              sufix: InkWell(
                                                focusColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                onTap: () {
                                                  signUpController
                                                          .isVisibleConfirm
                                                          .value =
                                                      !signUpController
                                                          .isVisibleConfirm
                                                          .value;
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: SvgPicture.asset(
                                                    DefaultImages.eye,
                                                    // color:  HexColor(AppTheme.secondaryColorString!)
                                                  ),
                                                ),
                                              ),
                                              prefix: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: SvgPicture.asset(
                                                  DefaultImages.pswd,
                                                  color: _focusNodes[5].hasFocus
                                                      ? HexColor(AppTheme
                                                          .primaryColorString!)
                                                      : const Color(0xffA2A0A8),
                                                  // color:  HexColor(AppTheme.secondaryColorString!)
                                                ),
                                              ),
                                              hintText: "Password",
                                              obscure: signUpController
                                                          .isVisibleConfirm
                                                          .value ==
                                                      true
                                                  ? false
                                                  : true,
                                              textEditingController:
                                                  signUpController
                                                      .ConfirmpasswordController
                                                      .value,
                                              capitalization:
                                                  TextCapitalization.none,
                                              limit: [
                                                FilteringTextInputFormatter
                                                    .singleLineFormatter,
                                              ],
                                              inputType:
                                                  TextInputType.visiblePassword,
                                            );
                                          }),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // children: [
                                            // InkWell(
                                            //   focusColor: Colors.transparent,
                                            //   highlightColor:
                                            //       Colors.transparent,
                                            //   hoverColor: Colors.transparent,
                                            //   splashColor: Colors.transparent,
                                            //   onTap: () {
                                            //     setState(() {
                                            //       signUpController
                                            //               .isAgree.value =
                                            //           !signUpController
                                            //               .isAgree.value;
                                            //     });
                                            //   },
                                            // child: Container(
                                            //   height: 24,
                                            //   width: 24,
                                            //   decoration: BoxDecoration(
                                            //       border: Border.all(
                                            //           color: const Color(
                                            //               0xffDCDBE0)),
                                            //       color: signUpController
                                            //               .isAgree.value
                                            //           ? HexColor(AppTheme
                                            //               .primaryColorString!)
                                            //           : Colors.transparent,
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               8)),
                                            //   child: Icon(
                                            //     Icons.check,
                                            //     size: 15,
                                            //     color: signUpController
                                            //             .isAgree.value
                                            //         ? Colors.white
                                            //         : Colors.transparent,
                                            //   ),
                                            // ),
                                            // ),
                                            // const SizedBox(
                                            //   width: 16,
                                            // ),
                                            // Expanded(
                                            //     child: RichText(
                                            //   textAlign: TextAlign.left,
                                            //   text:
                                            //       TextSpan(children: <TextSpan>[
                                            //     TextSpan(
                                            //       text:
                                            //           "จากการสร้างบัญชีผู้ใช้ ฉันยอมรับ",
                                            //       style: Theme.of(context)
                                            //           .textTheme
                                            //           .bodyText2!
                                            //           .copyWith(
                                            //             fontWeight:
                                            //                 FontWeight.w500,
                                            //             fontSize: 14,
                                            //             color:
                                            //                 AppTheme.isLightTheme ==
                                            //                         false
                                            //                     ? const Color(
                                            //                         0xffA2A0A8)
                                            //                     : const Color(
                                            //                         0xff211F32),
                                            //           ),
                                            //     ),
                                            //     TextSpan(
                                            //         text: "ข้อกำหนด",
                                            //         style: Theme.of(context)
                                            //             .textTheme
                                            //             .bodyText2!
                                            //             .copyWith(
                                            //                 fontWeight:
                                            //                     FontWeight.w500,
                                            //                 fontSize: 14,
                                            //                 color: HexColor(AppTheme
                                            //                     .primaryColorString!))),
                                            //     TextSpan(
                                            //       text: " และ",
                                            //       style: Theme.of(context)
                                            //           .textTheme
                                            //           .bodyText2!
                                            //           .copyWith(
                                            //             fontWeight:
                                            //                 FontWeight.w500,
                                            //             fontSize: 14,
                                            //             color:
                                            //                 AppTheme.isLightTheme ==
                                            //                         false
                                            //                     ? const Color(
                                            //                         0xffA2A0A8)
                                            //                     : const Color(
                                            //                         0xff211F32),
                                            //           ),
                                            //     ),
                                            //     TextSpan(
                                            //         text: "เงื่อนไข",
                                            //         style: Theme.of(context)
                                            //             .textTheme
                                            //             .bodyText2!
                                            //             .copyWith(
                                            //                 fontWeight:
                                            //                     FontWeight.w500,
                                            //                 fontSize: 14,
                                            //                 color: HexColor(AppTheme
                                            //                     .primaryColorString!))),
                                            //     TextSpan(
                                            //       text: "ของบริการ",
                                            //       style: Theme.of(context)
                                            //           .textTheme
                                            //           .bodyText2!
                                            //           .copyWith(
                                            //             fontWeight:
                                            //                 FontWeight.w500,
                                            //             fontSize: 14,
                                            //             color:
                                            //                 AppTheme.isLightTheme ==
                                            //                         false
                                            //                     ? const Color(
                                            //                         0xffA2A0A8)
                                            //                     : const Color(
                                            //                         0xff211F32),
                                            //           ),
                                            //     ),
                                            //   ]),
                                            // ))
                                            // ],
                                          ),
                                          const SizedBox(height: 32),
                                          InkWell(
                                            focusColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () async {
                                              if (formKey.currentState?.validate()?? false) {
                                                formKey.currentState?.save();
                                                try {
                                                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                      email: signUpController.emailAddreesController.value.text,
                                                      password: signUpController.passwordController.value.text,
                                                    );
                                                    // Registration successful
                                                  } on FirebaseAuthException catch (e) {
                                                    print('Firebase Authentication Error: ${e.message}');
                                                    // Handle specific authentication errors
                                                  } catch (e) {
                                                    print('Unexpected Error: $e');
                                                    // Handle other unexpected errors
                                                  }


                                              }
                                          
                                            },

                                            // onTap: () {
                                            //   formKey.currentState?.save();

                                            //   if (formKey.currentState
                                            //           ?.validate() ??
                                            //       false) {
                                            //     print(
                                            //       "name = ${signUpController.nameController.value.text} " +
                                            //           "lName = ${signUpController.lNameController.value.text} " +
                                            //           "emailAddress = ${signUpController.emailAddreesController.value.text} " +
                                            //           "tel = ${signUpController.telController.value.text} " +
                                            //           "password = ${signUpController.passwordController.value.text}",
                                            //     );
                                            //   }

                                               // Get.to(
                                               //   const LoginScreen(),
                                               //   transition:
                                               //       Transition.rightToLeft,
                                               //   duration: const Duration(
                                               //       milliseconds: 500),
                                               // );
                                            //},
                                            child: customButton(
                                                HexColor(AppTheme
                                                    .primaryColorString!),
                                                "ลงทะเบียน",
                                                HexColor(AppTheme
                                                    .secondaryColorString!),
                                                context),
                                          ),
                                          InkWell(
                                            focusColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              Get.to(
                                                const LoginScreen(),
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 24),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "มีบัญชีอยู่แล้วใช่ไหม? ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xff9CA3AF))),
                                                  Text(" เข้าสู่ระบบ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                    ]),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            )));
  }
}
