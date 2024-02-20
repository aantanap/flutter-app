// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> lNameController = TextEditingController().obs;
  Rx<TextEditingController> emailAddreesController = TextEditingController().obs;
  Rx<TextEditingController> telController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> ConfirmpasswordController = TextEditingController().obs;

  // Define RxString properties for storing the entered values
  RxString name = ''.obs;
  RxString lName = ''.obs;
  RxString emailAddress = ''.obs;
  RxString tel = ''.obs;
  RxString password = ''.obs;
  RxBool isVisible = false.obs;
  RxBool isVisibleConfirm = false.obs;
  RxBool isAgree = false.obs;

  // Rest of your SignUpController class...
}

// class SignUpController extends GetxController {

//   Rx<TextEditingController> nameController = TextEditingController().obs;
//   Rx<TextEditingController> lNameController = TextEditingController().obs;
//   Rx<TextEditingController> emailAddreesController = TextEditingController().obs;
//   Rx<TextEditingController> telController = TextEditingController().obs;
//   Rx<TextEditingController> passwordController = TextEditingController().obs;
//   // ignore: non_constant_identifier_names
//   Rx<TextEditingController> ConfirmpasswordController = TextEditingController().obs;
//   RxBool isVisible = false.obs;
//   RxBool isVisibleConfirm = false.obs;
//   RxBool isAgree = false.obs;
// }

class CreateNewRequestController extends GetxController {
  Rx<TextEditingController> impactDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> descriptionIncidentController =
      TextEditingController().obs;
  Rx<TextEditingController> serialNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> symptomOtherController =
      TextEditingController().obs;
  Rx<TextEditingController> symptomDetailController =
      TextEditingController().obs;
  Rx<TextEditingController> fullnameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> officePhoneController = TextEditingController().obs;
  Rx<TextEditingController> requestDetailController =
      TextEditingController().obs;
  Rx<TextEditingController> otherSubjectController =
      TextEditingController().obs;
  Rx<TextEditingController> descriptionRequestController =
      TextEditingController().obs;
  // Rx<TextEditingController> lastnameController = TextEditingController().obs;
  // Rx<TextEditingController> emailController = TextEditingController().obs;
  // Rx<TextEditingController> mobileController = TextEditingController().obs;
  // Rx<TextEditingController> pswdController = TextEditingController().obs;
  // ignore: non_constant_identifier_names
  // Rx<TextEditingController> ConfirmpswdController = TextEditingController().obs;
  // RxBool isVisible = false.obs;
  // RxBool isVisibleConfirm = false.obs;
  // RxBool isAgree = false.obs;
}

class UpdateRequestController extends GetxController {
  Rx<TextEditingController> impactDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> descriptionIncidentController =
      TextEditingController().obs;
  Rx<TextEditingController> serialNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> symptomOtherController =
      TextEditingController().obs;
  Rx<TextEditingController> symptomDetailController =
      TextEditingController().obs;
  Rx<TextEditingController> fullnameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> officePhoneController = TextEditingController().obs;
  Rx<TextEditingController> requestDetailController =
      TextEditingController().obs;
  Rx<TextEditingController> otherSubjectController =
      TextEditingController().obs;
  Rx<TextEditingController> descriptionRequestController =
      TextEditingController().obs;
}
