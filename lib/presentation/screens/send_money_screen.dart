import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:send_money/bloc/create_transaction_bloc/transaction_bloc.dart';
import 'package:send_money/bloc/create_transaction_bloc/transaction_event.dart';
import 'package:send_money/bloc/create_transaction_bloc/transaction_state.dart';
import 'package:send_money/bloc/home_bloc/home_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_event.dart';
import 'package:send_money/data/models/request/create_transaction_request_data.dart';
import 'package:send_money/presentation/bottom_sheet/transaction_status_bottom_sheet.dart';
import 'package:send_money/presentation/widgets/custom_elevated_button.dart';
import 'package:send_money/presentation/widgets/custom_error_dialog.dart';
import 'package:send_money/presentation/widgets/custom_loader.dart';
import 'package:send_money/presentation/widgets/custom_text_field.dart';
import 'package:send_money/utils/AppUtils.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/DimensionUtils.dart';
import 'package:send_money/utils/GapUtils.dart';
import 'package:send_money/utils/ImageUtils.dart';
import 'package:send_money/utils/NetworkUtils.dart';
import 'package:send_money/utils/StringUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {

  //Declare instance of form validation key here.....
  final GlobalKey<FormState> formKey = GlobalKey();

  //Instance of Text Editing controller for sending money to user.....
  final transactionController = TextEditingController();

  //Home bloc instance...
  late HomeBloc homeBloc;

  //Transaction bloc instance here...
  late TransactionBloc transactionBloc;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;

    homeBloc = BlocProvider.of<HomeBloc>(context);
    transactionBloc = BlocProvider.of<TransactionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text(StringUtils.sendMoneyText,
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
            bloc: transactionBloc,
            listener: (context, state) {
              if(state is TransactionLoadingState){
                LoadingDialog.show(context);
              }

              if(state is TransactionSuccessState){
                LoadingDialog.hide(context);
                transactionController.clear();
                AppUtils.hideKeyboardWithoutContext();
                _successTransactionBottomSheet(context);
              }

              if(state is TransactionErrorState){
                LoadingDialog.hide(context);
                Fluttertoast.showToast(msg: state.errMessage);
              }
            },
            child: Form(
              key: formKey,
              child: Container(
                  width: size.width,
                  height: size.height,
                  color: ColorUtils.whiteColor,
                  padding: EdgeInsets.fromLTRB(DimensionUtils.padding10.h, DimensionUtils.zero.h,
                      DimensionUtils.padding10.h, DimensionUtils.zero.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        controller: transactionController,
                        autoValidateMode: AutovalidateMode.disabled,
                        type: FieldType.numeric,
                        hintText: "Amount (in php)",
                      ),
                      VerticalGap(gap: DimensionUtils.margin40.h),
                      CustomElevatedButton(
                        darkTitle: true,
                        color: ColorUtils.primaryColor,
                        onTap: () => onValidateFormField(context),
                        textSize: 16.0,
                        label: StringUtils.submitText,
                        innerPadding: const EdgeInsets.all(12),
                      )
                    ],
                  )),
            )));
  }

  onValidateFormField(context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (transactionController.value.text.isEmpty) {
      await showError(
          context: context,
          error: "Please enter amount");
      return;
    }
    if (formKey.currentState!.validate() &&
        transactionController.value.text.isNotEmpty) {
        if(await NetworkUtils.checkNetwork()) {
          transactionBloc.add(CreateTransactionEvent(
              requestData: CreateTransactionRequestData(
                  amount:
                  transactionController.text.toString())));
        } else {
          await showError(
              context: context,
              error: "No Internet Connection");
          return;
        }
    }
  }

  onUserLogout() {
    homeBloc.add(HomeUserLogoutEvent());
  }

  void _successTransactionBottomSheet(BuildContext context) async{
    /*bool? isSheetClosed = await*/ showModalBottomSheet<bool?>(
        context: context,
        isDismissible: true,
        builder: (builder) {
          return const TransactionStatusBottomSheet();
        })/*.whenComplete((){
      Future.delayed(const Duration(seconds: 2), (){
        LoadingDialog.hide(context);
      });
    })*/;

    // debugPrint("isSheetClosed => $isSheetClosed");
    // if(isSheetClosed != null && isSheetClosed == true){
    //   Future.delayed(const Duration(seconds: 5), (){
    //     LoadingDialog.pop(context);
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();

    // homeBloc.close();
    // transactionBloc.close();
  }
}
