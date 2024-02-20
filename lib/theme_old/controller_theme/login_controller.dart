// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
//login
  Rx<TextEditingController> mobileController = TextEditingController().obs;
  Rx<TextEditingController> pswdController = TextEditingController().obs;
  RxBool isVisible = false.obs;
}
