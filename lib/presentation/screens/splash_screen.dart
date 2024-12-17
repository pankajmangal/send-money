import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/routes/RoutesPath.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/DimensionUtils.dart';
import 'package:send_money/utils/GapUtils.dart';
import 'package:send_money/utils/ImageUtils.dart';
import 'package:send_money/utils/StringUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    if (!mounted) return;

    if(mounted){
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesPath.HOME, (Route route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: ColorUtils.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(ImageUtils.sendMoneyImg, width: screenSize.width * 0.4),
            VerticalGap(gap: DimensionUtils.gap8.h),
            Text(
                StringUtils.sendMoneyText,
                textAlign: TextAlign.start,
                style: StyleUtils.tsRegularTitleStyle28
                    .copyWith(color: ColorUtils.buttonGradientColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 28.sp)
            )
          ],
        ),
      ),
    );
  }
}