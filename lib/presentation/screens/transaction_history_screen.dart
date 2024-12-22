import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:send_money/bloc/home_bloc/home_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_event.dart';
import 'package:send_money/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:send_money/bloc/transaction_bloc/transaction_event.dart';
import 'package:send_money/bloc/transaction_bloc/transaction_state.dart';
import 'package:send_money/data/models/response/transaction_history_data.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/DimensionUtils.dart';
import 'package:send_money/utils/GapUtils.dart';
import 'package:send_money/utils/ImageUtils.dart';
import 'package:send_money/utils/StringUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {

  //Home bloc instance...
  late HomeBloc homeBloc;

  //Transaction bloc instance here...
  late TransactionBloc transactionBloc;

  @override
  void initState() {
    super.initState();
    if(!mounted) return;

    homeBloc = BlocProvider.of<HomeBloc>(context);
    transactionBloc = BlocProvider.of<TransactionBloc>(context);
    transactionBloc.add(FetchAllTransactionEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.transactionHistoryText,
        style: StyleUtils.appBarTextStyle),
          actions: [
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
          ]
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        bloc: transactionBloc,
          builder: (context, state) {

            if(state is TransactionLoadingState){
             return const Center(
               child: CircularProgressIndicator()
             );
            } else if(state is TransactionSuccessState) {
              return Container(
                width: size.width,
                height: size.height,
                color: ColorUtils.whiteColor,
                margin: EdgeInsets.fromLTRB(DimensionUtils.padding20.w,
                    DimensionUtils.padding4.h, DimensionUtils.padding20.w,
                    DimensionUtils.padding4.h),
                child: ListView.builder(
                    itemCount: state.historyData.data.length,
                    itemBuilder: (_, index) {
                      TransactionData transactionData = state.historyData.data[index];
                      return Card(
                        color: ColorUtils.whiteColor,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.logout_rounded),
                          visualDensity: const VisualDensity(horizontal: 0, vertical: 4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Amount Sent",
                                        style: StyleUtils.tsRegularTitleStyle28
                                            .copyWith(
                                            color: ColorUtils.darkGrey,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500)),
                                    VerticalGap(gap: 4.h),
                                    Text(DateFormat("dd MMM yyyy").format(transactionData.createdAt),
                                        style: StyleUtils.tsRegularTitleStyle28
                                            .copyWith(
                                            color: ColorUtils.darkGrey,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                Text("${transactionData.amount}php",
                                style: StyleUtils.tsRegularTitleStyle28
                                    .copyWith(color: ColorUtils.buttonGradientColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp))
                              ],
                            ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 12.0
                        ),),
                      );
                    }),
              );
            } else if(state is TransactionErrorState){
              return Center(
                child: Text(
                  state.errMessage,
                  maxLines: 2,
                  style: StyleUtils.tsRegularTitleStyle28.copyWith(
                    color: ColorUtils.redAccent,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis
                  ),
                )
              );
            } else {
              return const SizedBox.shrink();
            }
      })
    );
  }

  onUserLogout(){
    homeBloc.add(HomeUserLogoutEvent());
  }

  @override
  void dispose() {
    super.dispose();

    // homeBloc.close();
    // transactionBloc.close();
  }
}
