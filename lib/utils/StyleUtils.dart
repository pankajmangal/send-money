import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/utils/ColorUtils.dart';

class StyleUtils {

  static TextStyle appBarTextStyle = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w500
  );

  static TextStyle customHintStyle = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.normal,
      color: ColorUtils.hintColor.withOpacity(0.5));

  static const elevatedButtonStyleDark = TextStyle(
      color: ColorUtils.darkGrey,
      fontWeight: FontWeight.w500);

  static const elevatedButtonStyleLight = TextStyle(
      color: ColorUtils.whiteColor,
      fontWeight: FontWeight.w500);

  static final tsRegularTitleStyle28 = TextStyle(
      color: ColorUtils.darkGrey,
      fontSize: 28.sp);

  static final fieldErrorStyle14 = TextStyle(
    fontSize: 14.sp,
    color: ColorUtils.redAccent,
    fontWeight: FontWeight.w500,
  );

  static TextStyle customTextStyle = TextStyle(
      color: ColorUtils.whiteColor,
      fontSize: 14.sp,
      overflow: TextOverflow.ellipsis);
}