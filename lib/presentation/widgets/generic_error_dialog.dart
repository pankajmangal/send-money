import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/utils/ColorUtils.dart';

typedef DialogueOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialogue<T>(
    {required BuildContext context,
    required String title,
    required String content,
    required DialogueOptionBuilder optionBuilder}) {
  final options = optionBuilder();
  return showDialog<T?>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: ColorUtils.whiteColor,
          surfaceTintColor: ColorUtils.whiteColor,
          title: Center(
              child: Text(
            title,
            style: TextStyle(fontSize: 18.sp,
            color: Colors.redAccent),
          )),
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp),
          ),
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorUtils.primaryColor),
                onPressed: () {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(optionTitle,
                    style: TextStyle(
                        fontSize: 14.sp, color: ColorUtils.whiteColor)));
          }).toList()));
}
