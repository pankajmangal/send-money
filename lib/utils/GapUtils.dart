import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:send_money/utils/ColorUtils.dart';

class VerticalGap extends StatelessWidget {
  final double? gap;

  const VerticalGap({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: gap);
  }
}

class HorizontalGap extends StatelessWidget {
  final double gap;
  const HorizontalGap({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: gap);
  }
}

class HorizontalDivider extends StatelessWidget {
  final double strokeWidth;
  final Color? color;
  final double width;
  const HorizontalDivider({super.key,
    required this.strokeWidth,
    required this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: strokeWidth,
      child: Container(
        color: color ?? ColorUtils.smokeGrey
      )
    );
  }
}

class AEVerticalDivider extends StatelessWidget {
  final double strokeWidth;
  final double strokeHeight;
  final Color? color;

  const AEVerticalDivider({super.key, required this.strokeWidth,
    required this.strokeHeight, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: strokeWidth,
        height: strokeHeight,
        child: Container(
            color: color ?? ColorUtils.smokeGrey
        )
    );
  }
}