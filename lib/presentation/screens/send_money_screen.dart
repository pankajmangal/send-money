import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/bloc/home_bloc/home_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_event.dart';
import 'package:send_money/bloc/send_money_bloc/transaction_bloc.dart';
import 'package:send_money/bloc/send_money_bloc/transaction_event.dart';
import 'package:send_money/data/models/request/create_transaction_request_data.dart';
import 'package:send_money/presentation/widgets/custom_elevated_button.dart';
import 'package:send_money/presentation/widgets/custom_text_field.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/DimensionUtils.dart';
import 'package:send_money/utils/ImageUtils.dart';
import 'package:send_money/utils/StringUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {

  //Instance of Text Editing controller for sending money to user.....
  final transactionController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text(StringUtils.sendMoneyText,
                style: StyleUtils.appBarTextStyle),
          actions: [
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
        body: Container(
          width: size.width,
          height: size.height,
          color: ColorUtils.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 65.h,
                child: CustomTextField(
                  controller: transactionController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  type: FieldType.numeric,
                  hintText: "Amount (in php)",
                ),
              ),

              CustomElevatedButton(
                darkTitle: true,
                color: ColorUtils.hintColor,
                onTap: () {
                  transactionBloc.add(CreateTransactionEvent(requestData:
                  CreateTransactionRequestData(amount: transactionController.text.toString())));
                },
                textSize: 16.0,
                label: StringUtils.submitText,
                innerPadding: const EdgeInsets.all(14),
              )
            ],
          )
        )
    );
  }

  onUserLogout(){
    homeBloc.add(HomeUserLogoutEvent());
  }
}
