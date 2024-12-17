import 'package:flutter/material.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final Color? color;
  final double? width;
  final VoidCallback? onTap;
  final double? borderRadius;
  final bool darkTitle;
  final EdgeInsetsGeometry? innerPadding;
  final double? textSize;

  const CustomElevatedButton(
      {super.key,
      this.label,
      this.color,
      this.child,
      this.onTap,
      this.borderRadius,
        this.width,
      this.darkTitle = false,
      this.innerPadding,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        textStyle: darkTitle
            ? StyleUtils.elevatedButtonStyleDark
            : StyleUtils.elevatedButtonStyleLight,
        backgroundColor: color ?? ColorUtils.whiteColor,
        surfaceTintColor: color ?? ColorUtils.whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
      ),
      child: Container(
        width: width ?? screenSize.width * 0.85,
        padding: innerPadding ?? EdgeInsets.zero,
        child: child ??
            Text(
              label!,
              style: darkTitle
                  ? StyleUtils.elevatedButtonStyleDark
                      .copyWith(fontSize: textSize ?? 13, color: Colors.white)
                  : StyleUtils.elevatedButtonStyleLight.copyWith(
                      fontSize: textSize ?? 13, color: ColorUtils.blackColor),
            ),
      ),
    );
  }
}