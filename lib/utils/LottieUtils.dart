import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieUtils {

  static LottieBuilder successLottie =
      Lottie.asset("assets/lottie/success-lottie.json", fit: BoxFit.fill);

  static LottieBuilder failureLottie =
  Lottie.asset("assets/lottie/failure-lottie.json", fit: BoxFit.fill);
}
