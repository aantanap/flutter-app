// ignore_for_file: deprecated_member_use

import 'package:rems/theme_old/config_theme/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:rems/theme_old/widgets_theme/custom_textformfield.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  // final TextEditingController textEditingController;
  final Widget? sufix;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final bool obscure;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? limit;
  final TextCapitalization capitalization;
  final TextInputType? inputType;
  final bool? readOnly;
  final String? Function(String?)? onSaved;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    
    this.sufix,
    this.prefix,
    this.validator,
    this.obscure = false,
    this.limit,
    this.labelText,
    required this.capitalization,
    this.inputType,
    this.readOnly = false, this.focusNode,
    this.onSaved, required TextEditingController textEditingController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : const Color(0xffF9F9FA),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextFormField(
            // controller: textEditingController,
            obscureText: obscure,
            focusNode: focusNode,
            textCapitalization: capitalization,
            
            readOnly: readOnly!,
            inputFormatters: limit,
            decoration: InputDecoration(
                prefixIcon: prefix,
                suffixIcon: sufix,
                labelText: labelText,

                //   labelStyle: pRegular14,
                hintText: hintText,
                // hintStyle: pRegular14.copyWith(
                //   color: ConstColors.textColor.withOpacity(0.5),
                // ),
                border: InputBorder.none)),
      ),
    );
  }
}

class CustomTextFormField2 extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? sufix;
  final Widget? prefix;
  final bool obscure;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? limit;
  final TextCapitalization capitalization;
  final TextInputType? inputType;
  final bool? readOnly;
  final int? maxLine;
  final void Function(String)? onChanged;

  const CustomTextFormField2(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.sufix,
      this.prefix,
      this.obscure = false,
      this.limit,
      this.labelText,
      required this.capitalization,
      this.inputType,
      this.readOnly = false,
      this.focusNode,
      this.maxLine,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : const Color(0xffF9F9FA),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: TextFormField(
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
            maxLines: maxLine,
            onChanged: onChanged,
            controller: textEditingController,
            obscureText: obscure,
            focusNode: focusNode,
            textCapitalization: capitalization,
            keyboardType: inputType,
            readOnly: readOnly!,
            inputFormatters: limit,
            decoration: InputDecoration(
                prefixIcon: prefix,
                suffixIcon: sufix,
                labelText: labelText,

                //   labelStyle: pRegular14,
                hintText: hintText,
                // hintStyle: pRegular14.copyWith(
                //   color: ConstColors.textColor.withOpacity(0.5),
                // ),
                border: InputBorder.none)),
      ),
    );
  }
}

class CustomTextFormFieldSearch extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? sufix;
  final Widget? prefix;
  final bool obscure;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? limit;
  final TextCapitalization capitalization;
  final TextInputType? inputType;
  final bool? readOnly;
  final int? maxLine;
  final void Function(String)? onChanged;
  final Color? cursorColor;
  final Color? suffixIconColor;
  final double radius;

  const CustomTextFormFieldSearch(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.sufix,
      this.prefix,
      this.obscure = false,
      this.limit,
      this.labelText,
      required this.capitalization,
      this.inputType,
      this.readOnly = false,
      this.focusNode,
      this.maxLine,
      this.onChanged,
      this.cursorColor,
      this.suffixIconColor,
      required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : HexColor("#FFFFFF"),
          borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 16),
        child: TextFormField(
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
            maxLines: maxLine,
            cursorColor: cursorColor,
            onChanged: onChanged,
            controller: textEditingController,
            obscureText: obscure,
            focusNode: focusNode,
            textCapitalization: capitalization,
            keyboardType: inputType,
            readOnly: readOnly!,
            inputFormatters: limit,
            decoration: InputDecoration(
                prefixIcon: prefix,
                suffixIcon: sufix,
                suffixIconColor: suffixIconColor,
                labelText: labelText,
                hintText: hintText,
                border: InputBorder.none)),
      ),
    );
  }
}

class CustomTextFormFieldSearch2 extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? sufix;
  final Widget? prefix;
  final bool obscure;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? limit;
  final TextCapitalization capitalization;
  final TextInputType? inputType;
  final bool? readOnly;
  final int? maxLine;
  final void Function(String)? onChanged;
  final Color? cursorColor;
  final Color? suffixIconColor;
  final double radius;

  const CustomTextFormFieldSearch2(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.sufix,
      this.prefix,
      this.obscure = false,
      this.limit,
      this.labelText,
      required this.capitalization,
      this.inputType,
      this.readOnly = false,
      this.focusNode,
      this.maxLine,
      this.onChanged,
      this.cursorColor,
      this.suffixIconColor,
      required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : const Color(0xffF9F9FA),
          borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 16),
        child: TextFormField(
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
            maxLines: maxLine,
            cursorColor: cursorColor,
            onChanged: onChanged,
            controller: textEditingController,
            obscureText: obscure,
            focusNode: focusNode,
            textCapitalization: capitalization,
            keyboardType: inputType,
            readOnly: readOnly!,
            inputFormatters: limit,
            decoration: InputDecoration(
                prefixIcon: prefix,
                suffixIcon: sufix,
                suffixIconColor: suffixIconColor,
                labelText: labelText,
                hintText: hintText,
                border: InputBorder.none)),
      ),
    );
  }
}

class CustomTextFormFieldProfile extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? sufix;
  final Widget? prefix;
  final bool obscure;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? limit;
  final TextCapitalization capitalization;
  final TextInputType? inputType;
  final bool? readOnly;
  final int? maxLine;
  final void Function(String)? onChanged;
  final Color? cursorColor;
  final Color? suffixIconColor;
  final double radius;

  const CustomTextFormFieldProfile(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.sufix,
      this.prefix,
      this.obscure = false,
      this.limit,
      this.labelText,
      required this.capitalization,
      this.inputType,
      this.readOnly = false,
      this.focusNode,
      this.maxLine,
      this.onChanged,
      this.cursorColor,
      this.suffixIconColor,
      required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      decoration: BoxDecoration(
          color: AppTheme.isLightTheme == false
              ? const Color(0xff211F32)
              : HexColor("#F4F4F4"),
          borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 16),
        child: TextFormField(
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
            maxLines: maxLine,
            cursorColor: cursorColor,
            onChanged: onChanged,
            controller: textEditingController,
            obscureText: obscure,
            focusNode: focusNode,
            textCapitalization: capitalization,
            keyboardType: inputType,
            readOnly: readOnly!,
            inputFormatters: limit,
            decoration: InputDecoration(
                prefixIcon: prefix,
                suffixIcon: sufix,
                suffixIconColor: suffixIconColor,
                labelText: labelText,
                hintText: hintText,
                border: InputBorder.none)),
      ),
    );
  }
}
