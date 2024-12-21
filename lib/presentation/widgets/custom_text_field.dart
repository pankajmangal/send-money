import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/ExtensionUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

enum FieldType { eMail, password, numeric, text }

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double? borderRadius;
  final FieldType type;
  final String? hintText;
  final IconData? icon;
  final double? height;
  final IconData? postFixIcon;
  final bool? obscureText;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final VoidCallback? toggleVisibility;
  final void Function()? onEditingComplete;
  final AutovalidateMode? autoValidateMode;

  const CustomTextField(
      {this.obscureText,
        this.autoValidateMode,
        this.onChanged,
        this.height,
        this.onEditingComplete,
        this.borderRadius,
        this.toggleVisibility,
        this.postFixIcon,
        this.validator,
        this.padding,
        this.controller,
        required this.type,
        this.hintText = "Email Address",
        super.key,
        this.icon = Icons.email});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.center,
      widthFactor: 0.9,
      child: TextFormField(
          autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
          onEditingComplete: onEditingComplete,
          readOnly: false,
          textAlignVertical:
          type == FieldType.password ? TextAlignVertical.center : null,
          cursorHeight: 20.h,
          cursorColor: ColorUtils.blackColor,
          controller: controller,
          inputFormatters: [
            type == FieldType.eMail
                ? LengthLimitingTextInputFormatter(35)
                : LengthLimitingTextInputFormatter(20),
             // type == FieldType.numeric
             //    ? FilteringTextInputFormatter.allow(RegExp(""))
             //    : FilteringTextInputFormatter.deny(RegExp("")),
          ],
          keyboardType: type == FieldType.eMail
              ? TextInputType.emailAddress
              : type == FieldType.password
              ? TextInputType.visiblePassword
              : type == FieldType.numeric
              ? TextInputType.number
              : TextInputType.text,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              errorMaxLines: 1,
              hintStyle: StyleUtils.customHintStyle,
              fillColor: Colors.transparent,
              filled: true,
              suffixIcon: type == FieldType.password
                  ? IconButton(
                onPressed: toggleVisibility,
                icon: toggleVisibility != null
                    ? Icon(obscureText == null || obscureText == true
                    ? Icons.visibility_off
                    : Icons.visibility)
                    : const SizedBox.shrink(),
              )
                  : null,
              hintText: hintText,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorUtils.hintColor.withOpacity(0.5))),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorUtils.hintColor.withOpacity(0.5))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorUtils.hintColor.withOpacity(0.5))),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorUtils.hintColor.withOpacity(0.5))),
              contentPadding: const EdgeInsets.only(top: 10)),
          validator: validator ??
              (type == FieldType.eMail
                  ? (value) {
                if (value!.isNotEmpty && !value.isValidEmail) {
                  return "Invalid Email";
                } else {
                  return null;
                }
              }
                  : type == FieldType.password
                  ? (value) {
                if (value!.length < 8 && value.length > 1) {
                  return "Password should be minimum 8 characters";
                }
                // else if (!value.isValidPassword &&
                //     value.length > 1) {
                //   return "Must contain an Uppercase,Lowercase,a special char & 1 digit";
                // }
                else {
                  return null;
                }
              } : (value) {
                if (value == '' || value == null) {
                  return "$hintText Can't be empty";
                } else {
                  return null;
                }
              })),
    );
  }
}