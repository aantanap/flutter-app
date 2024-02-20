// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customButton(
    Color bgClr, String text, Color txtClr, BuildContext context) {
  return Container(
    height: 50,
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: bgClr,
    ),
    child: Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: txtClr,
            ),
      ),
    ),
  );
}

Widget customButton2(
    Color bgClr, String text, Color txtClr, BuildContext context) {
  return Container(
    height: 50,
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: bgClr,
    ),
    child: Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: txtClr,
            ),
      ),
    ),
  );
}
