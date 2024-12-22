import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/LottieUtils.dart';

class TransactionStatusBottomSheet extends StatelessWidget {
  const TransactionStatusBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: ScreenUtil().screenHeight * 0.5,
      decoration: const BoxDecoration(
        color: ColorUtils.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding:
      const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LottieUtils.successLottie
          ]),
    );
  }
}