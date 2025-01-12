import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/bloc/home_bloc/home_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_event.dart';
import 'package:send_money/bloc/home_bloc/home_state.dart';
import 'package:send_money/bloc/home_bloc/home_toggle_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_toggle_event.dart';
import 'package:send_money/bloc/home_bloc/home_toggle_state.dart';
import 'package:send_money/data/network/local/secure_storage_service.dart';
import 'package:send_money/presentation/widgets/custom_elevated_button.dart';
import 'package:send_money/routes/RoutesPath.dart';
import 'package:send_money/utils/AppUtils.dart';
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

  //Instance bloc here...
  late HomeBloc homeBloc;
  late HomeToggleBloc homeToggleBloc;

  @override
  void initState() {
    super.initState();
    if(!mounted) return;

    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeToggleBloc = BlocProvider.of<HomeToggleBloc>(context);
    homeBloc.add(HomeUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

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
                onTap: () {
                  homeBloc.add(HomeUserProfileEvent());
                },
                  child: Image.asset(ImageUtils.refreshImg, width: 44.w, height: 44.h))),
          Padding(padding: const EdgeInsets.only(right: DimensionUtils.padding12),
              child: InkWell(
                onTap: (){
                  showDialog(context: context,
                      barrierDismissible: false,
                      builder: (context){
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
                                onUserLogout();
                              },
                              child: Text(StringUtils.confirmText,
                                  style: StyleUtils.fieldErrorStyle14))
                        ]);
                  });
                },
                  child: Image.asset(ImageUtils.userLogoutImg, width: 44.w, height: 44.h)))
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state){
          if(state is HomeUserLogoutState){
            final SecureStorageService storageService = SecureStorageService();
            storageService.deleteAccessToken();
            navigateToLogin();
          }
        },
        builder: (context, homeState) {
          if(homeState is HomeLoadingState){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(homeState is HomeSuccessState) {
            return Column(
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
                            child: BlocBuilder<HomeToggleBloc, HomeToggleState>(
                              bloc: homeToggleBloc,
                                builder: (context, state) {
                                if(state is ToggleChangeState){
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
                                                homeToggleBloc.add(ToggleONEvent());
                                              }else{
                                                homeToggleBloc.add(ToggleOFFEvent());
                                              }
                                            })
                                          ],
                                        ),
                                        VerticalGap(gap: 2.h),
                                        Text(
                                            state.isSwitchChanged ? "${homeState.userData.amount.toStringAsFixed(2)}php" : "******",
                                            textAlign:
                                            TextAlign.start,
                                            style: StyleUtils.tsRegularTitleStyle28
                                                .copyWith(color: ColorUtils.buttonGradientColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 28.sp)
                                        )
                                      ]);
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }
                            )
                        )
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
            );
          } else if(homeState is HomeErrorState){
            return AppUtils.noInternetAvailableWidget(onRefreshTap: (){
              homeBloc.add(HomeUserProfileEvent());
            });
          } else{
            return AppUtils.noInternetAvailableWidget(onRefreshTap: (){
              homeBloc.add(HomeUserProfileEvent());
            });
          }
        }
      ),
    );
  }

  //Navigate to transaction history route....
  navigateToTransactionScreen() => Navigator.pushNamed(context, RoutesPath.TRANSACTION_HISTORY);

  //Navigate to send money route....
  navigateToSendMoneyScreen() => Navigator.pushNamed(context, RoutesPath.SEND_MONEY).then((value){
    homeBloc.add(HomeUserProfileEvent());
  }).catchError((err){});

  //Navigate to login route....
  navigateToLogin() => Navigator.pushNamedAndRemoveUntil(context,
      RoutesPath.AUTH_LOGIN, (Route route) => false);

  //User Logout....
  onUserLogout(){
     homeBloc.add(HomeUserLogoutEvent());
  }
}