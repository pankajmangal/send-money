import 'package:flutter/material.dart';
import 'package:send_money/utils/ColorUtils.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final Color? color;
  final VoidCallback onTap;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? innerPadding;
  final Color? bgColor;
  final double? textSize;

  const CustomOutlinedButton(
      {super.key,
        this.label,
        this.color,
        this.child,
        required this.onTap,
        this.borderRadius,
        this.textColor,
        this.innerPadding,
        this.bgColor,
        this.textSize});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor ?? ColorUtils.primaryColor,
        side: BorderSide(color: color ?? ColorUtils.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        backgroundColor: bgColor,
        textStyle: TextStyle(
            color: textColor ?? ColorUtils.darkPrimary,
            fontFamily: 'poppins',
            fontSize: textSize ?? 14),
      ),
      child: Padding(
        padding: innerPadding ?? EdgeInsets.zero,
        child: child ?? Text(label!),
      ),
    );
  }
}