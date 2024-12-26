import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:send_money/bloc/home_bloc/home_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_event.dart';
import 'package:send_money/bloc/network_block/network_bloc.dart';
import 'package:send_money/bloc/network_block/network_state.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_bloc.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_event.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_state.dart';
import 'package:send_money/data/models/response/transaction_history_data.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/DimensionUtils.dart';
import 'package:send_money/utils/GapUtils.dart';
import 'package:send_money/utils/ImageUtils.dart';
import 'package:send_money/utils/NetworkUtils.dart';
import 'package:send_money/utils/StringUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  //Home bloc instance...
  late HomeBloc homeBloc;
  late NetworkBloc networkBloc;

  //Transaction bloc instance here...
  late TransactionHistoryBloc transactionBloc;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;

    networkBloc = BlocProvider.of<NetworkBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    transactionBloc = BlocProvider.of<TransactionHistoryBloc>(context);
    fetchTransactions();
  }

  fetchTransactions() async {
    if(await NetworkUtils.checkNetwork()){
      transactionBloc.add(FetchAllTransactionFromServerEvent());
    } else {
      // await showError(
      //     context: context,
      //     error: "No Internet Connection");
      // return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
        appBar: AppBar(
            title: Text(StringUtils.transactionHistoryText,
                style: StyleUtils.appBarTextStyle),
            actions: [
              Padding(
                  padding:
                      const EdgeInsets.only(right: DimensionUtils.padding12),
                  child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
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
                                            style:
                                                StyleUtils.fieldErrorStyle14))
                                  ]);
                            });
                      },
                      child: Image.asset(ImageUtils.userLogoutImg,
                          width: 44.w, height: 44.h)))
            ]),
        body: BlocListener(
          bloc: networkBloc,
          listener: (ctx, networkState) {
            if (networkState is NetworkFailure) {
              transactionBloc.add(FetchAllTransactionFromLocalEvent());
              Fluttertoast.showToast(msg: "No Internet Connection");
            } else if (networkState is NetworkSuccess) {
              fetchTransactions();
              Fluttertoast.showToast(msg: "You're Connected to Internet");
            } else {
              Fluttertoast.showToast(msg: "Something went wrong!");
            }
          },
          child: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
              bloc: transactionBloc,
              builder: (context, state) {
                debugPrint("TransactionStateType => ${state.runtimeType}");
                if (state is TransactionHistoryLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TransactionHistorySuccessState) {
                  return Container(
                    width: size.width,
                    height: size.height,
                    color: ColorUtils.whiteColor,
                    margin: EdgeInsets.fromLTRB(
                        DimensionUtils.padding20.w,
                        DimensionUtils.padding4.h,
                        DimensionUtils.padding20.w,
                        DimensionUtils.padding4.h),
                    child: ListView.builder(
                        itemCount: state.historyData.length,
                        itemBuilder: (_, index) {
                          TransactionData transactionData =
                              state.historyData[index];
                          return Card(
                            color: ColorUtils.whiteColor,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: ListTile(
                              leading: const Icon(Icons.logout_rounded),
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: 4),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Amount Sent",
                                          style: StyleUtils
                                              .tsRegularTitleStyle28
                                              .copyWith(
                                                  color: ColorUtils.darkGrey,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500)),
                                      VerticalGap(gap: 4.h),
                                      Text(
                                          DateFormat("dd MMM yyyy").format(
                                              transactionData.createdAt),
                                          style: StyleUtils
                                              .tsRegularTitleStyle28
                                              .copyWith(
                                                  color: ColorUtils.darkGrey,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                  Text("${transactionData.amount}php",
                                      style: StyleUtils.tsRegularTitleStyle28
                                          .copyWith(
                                              color: ColorUtils
                                                  .buttonGradientColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.sp))
                                ],
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12.0),
                            ),
                          );
                        }),
                  );
                } else if (state is TransactionHistoryErrorState) {
                  return Center(
                      child: Text(
                    state.errMessage,
                    maxLines: 2,
                    style: StyleUtils.tsRegularTitleStyle28.copyWith(
                        color: ColorUtils.redAccent,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ));
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ));
  }

  onUserLogout() {
    homeBloc.add(HomeUserLogoutEvent());
  }

  @override
  void dispose() {
    super.dispose();

    // homeBloc.close();
    // networkBloc.close();
    // transactionBloc.close();
  }
}
