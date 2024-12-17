import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/bloc/home_bloc/home_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_event.dart';
import 'package:send_money/bloc/home_bloc/home_state.dart';
import 'package:send_money/presentation/widgets/custom_elevated_button.dart';
import 'package:send_money/routes/RoutesPath.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/DimensionUtils.dart';
import 'package:send_money/utils/GapUtils.dart';
import 'package:send_money/utils/ImageUtils.dart';
import 'package:send_money/utils/StringUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: AppBar(
        toolbarHeight: 84.h,
        backgroundColor: ColorUtils.whiteColor,
        surfaceTintColor: ColorUtils.whiteColor,
        centerTitle: false,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  StringUtils.hiThereText,
                  textAlign:
                  TextAlign.start,
                  style: StyleUtils.tsRegularTitleStyle28
                      .copyWith(color: ColorUtils.buttonGradientColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.sp)
              ),
              VerticalGap(gap: 4.h),
              Text(
                  StringUtils
                      .welcomeBackText,
                  textAlign:
                  TextAlign.start,
                  style: StyleUtils
                      .tsRegularTitleStyle28
                      .copyWith(
                      color: ColorUtils.lightGrey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500)
              )
            ]),
        actions: [
         Padding(padding: const EdgeInsets.only(right: DimensionUtils.padding12),
         child: Image.asset(ImageUtils.userProfileImg, width: 44.w, height: 44.h)),
          Padding(padding: const EdgeInsets.only(right: DimensionUtils.padding12),
              child: InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                        surfaceTintColor: ColorUtils.whiteColor,
                        backgroundColor: ColorUtils.whiteColor,
                        title: const Text(StringUtils.logOutText),
                        content: Text(StringUtils.logoutDescText),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(StringUtils.cancelText)),
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                // onDeleteAccount();
                              },
                              child: Text(StringUtils.confirmText,
                                  style: StyleUtils.fieldErrorStyle14))
                        ]);
                  });
                },
                  child: Image.asset(ImageUtils.userLogoutImg, width: 44.w, height: 44.h)))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(DimensionUtils.padding8,
                DimensionUtils.padding12, DimensionUtils.padding8,
                DimensionUtils.padding12),
            margin: const EdgeInsets.fromLTRB(DimensionUtils.margin12,
                DimensionUtils.margin40, DimensionUtils.margin12,
                DimensionUtils.margin16),
            decoration: BoxDecoration(
              color: ColorUtils.cardBGLightColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(DimensionUtils.radius8)
            ),
            width: screenSize.width,
            height: screenSize.height * 0.2,
            child: Row(
              children: [
                Expanded(child: Padding(padding: const EdgeInsets.only(right: DimensionUtils.padding12),
                    child: Image.asset(ImageUtils.coinImg, height: 100))),
                Expanded(
                  flex: 1,
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state){
                      debugPrint("StateValue => ${state.isSwitchChanged}");
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    StringUtils.balanceText,
                                    textAlign:
                                    TextAlign.start,
                                    style: StyleUtils.tsRegularTitleStyle28
                                        .copyWith(
                                        color: ColorUtils.darkGrey,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w400)
                                ),
                                HorizontalGap(gap: DimensionUtils.gap5.w),
                                Switch(value: state.isSwitchChanged, onChanged: (isChanged){
                                  if(isChanged){
                                    homeBloc.add(ToggleONEvent());
                                  }else{
                                    homeBloc.add(ToggleOFFEvent());
                                  }
                                })
                              ],
                            ),
                            VerticalGap(gap: 2.h),
                            Text(
                                state.isSwitchChanged ? "500.00php" : "******",
                                textAlign:
                                TextAlign.start,
                                style: StyleUtils.tsRegularTitleStyle28
                                    .copyWith(color: ColorUtils.buttonGradientColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28.sp)
                            )
                          ]);
                    },
                  ),
                ),
              ],
            )
          ),
          VerticalGap(gap: DimensionUtils.margin62.h),
          CustomElevatedButton(
            darkTitle: true,
            color: ColorUtils.greenColor,
            onTap: () => navigateToSendMoneyScreen(),
            textSize: 16.0,
            label: StringUtils.sendMoneyText,
            innerPadding: const EdgeInsets.all(14),
          ),
          VerticalGap(gap: DimensionUtils.margin12.h),
          CustomElevatedButton(
            darkTitle: true,
            color: ColorUtils.orangeColor,
            onTap: () => navigateToTransactionScreen(),
            textSize: 16.0,
            label: StringUtils.viewTransactionText,
            innerPadding: const EdgeInsets.all(14),
          )
        ],
      ),
    );
  }

  navigateToTransactionScreen() => Navigator.pushNamed(context, RoutesPath.TRANSACTION_HISTORY);

  navigateToSendMoneyScreen() => Navigator.pushNamed(context, RoutesPath.SEND_MONEY);
}
