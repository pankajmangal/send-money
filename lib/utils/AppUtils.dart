import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/presentation/widgets/custom_outlined_button.dart';
import 'package:send_money/utils/LottieUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class AppUtils {

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static void hideKeyboardWithoutContext() {
    FocusManager focusManager = FocusManager.instance;
    focusManager.primaryFocus?.unfocus();
  }

  // Custom snack bar...
  static void customSnackBar(title, msg) {
    SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(msg)],
        ),
        backgroundColor: Colors.black87);
  }

  /*When we got no internet available found on any of the pages from
   API then we use this common widget for showing to refresh that page.... */
  static Widget noInternetAvailableWidget({required Function onRefreshTap}) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieUtils.noInternetLottie,
              Text(
                "No Internet Connection",
                style: StyleUtils.tsRegularTitleStyle28
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Check your connection, then refresh this page.",
                style: StyleUtils.tsRegularTitleStyle28
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 9),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomOutlinedButton(
                  onTap: () async {
                    onRefreshTap();
                  },
                  label: "Refresh")
            ]));
  }
}