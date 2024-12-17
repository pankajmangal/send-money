import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/presentation/widgets/custom_elevated_button.dart';
import 'package:send_money/presentation/widgets/custom_text_field.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/StringUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {

  final sendMoneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text(StringUtils.sendMoneyText,
                style: StyleUtils.appBarTextStyle)
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
                  controller: sendMoneyController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  type: FieldType.numeric,
                  hintText: "Send Money",
                ),
              ),

              CustomElevatedButton(
                darkTitle: true,
                color: ColorUtils.hintColor,
                onTap: () {
                  // controller.onSubmitEmailButtonTap(
                  //     context);
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
}
