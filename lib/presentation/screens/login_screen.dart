import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/presentation/widgets/custom_error_dialog.dart';
import 'package:send_money/presentation/widgets/custom_loader.dart';
import 'package:send_money/presentation/widgets/custom_text_field.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/GapUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Declare instance of form validation key here.....
  final GlobalKey<FormState> formKey = GlobalKey();

  //Declare instance of Email & password TextFormField here...
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController pwdController = TextEditingController(text: "");

  //Declare instance of password visibility
  bool isObscure = true;

  //Declare instance of password visibility
  bool isPasswordRemember = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: ColorUtils.primaryColor,
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icon's color
        systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icon's color
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    VerticalGap(gap: 30.h),
                    Text(
                      "Sign In to your Account",
                      style:
                      StyleUtils.customTextStyle.copyWith(color: Colors.black,
                      fontSize: 24.sp),
                      textAlign: TextAlign.center,
                    ),
                    VerticalGap(gap: 80.h),
                    SizedBox(
                      height: 72.h,
                      child: CustomTextField(
                        autoValidateMode: AutovalidateMode.always,
                        controller: emailController,
                        type: FieldType.eMail,
                      ),
                    ),
                    SizedBox(
                      height: 72.h,
                      child: CustomTextField(
                          autoValidateMode: AutovalidateMode.always,
                          controller: pwdController,
                          type: FieldType.password,
                          hintText: "Password",
                          obscureText: isObscure,
                          toggleVisibility: toggleObscureText),
                    ),
                    VerticalGap(gap: 20.h),
                    Container(
                      padding: EdgeInsets.only(top: size.height * 0.01),
                      constraints: BoxConstraints(maxWidth: size.width * 0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: const BoxDecoration(
                                    border: Border(),
                                  ),
                                  child: Checkbox(
                                      activeColor: ColorUtils.rememberMeColor,
                                      shape: const CircleBorder(),
                                      value: isPasswordRemember,
                                      onChanged: (value) => toggleRememberMe())),
                              SizedBox(
                                width: 10.w,
                              ),
                              const SizedBox(
                                child: Text(
                                  "Remember me",
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: StyleUtils.customTextStyle.copyWith(
                                  color: Colors.black
                              )
                            )
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(onTap: () => onValidateFormField(context),
                      child: Container(
                        color: ColorUtils.primaryColor,
                        width: size.width * 0.9,
                        height: size.width * 0.12,
                        child: Center(
                          child: Text(
                            "Login",
                            style: StyleUtils.customTextStyle
                                .copyWith(color: ColorUtils.whiteColor,
                                fontSize: 16.sp),
                          )
                        )
                      )
                    )
                  ]
                ),
              )
            )
          ),
        )
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  toggleObscureText(){
    if(!mounted) return;
    isObscure = !isObscure;
    setState(() {});
  }

  toggleRememberMe(){
    if(!mounted) return;
    isPasswordRemember = !isPasswordRemember;
    setState(() {});
  }

  onValidateFormField(context) async {
    debugPrint("Enter your email address");
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (emailController.value.text.isEmpty) {
      await showError(
          context: context,
          error: "Enter your email address");
      return;
    }
    if (pwdController.value.text.isEmpty) {
      await showError(
          context: context,
          error: "Enter your password");
      return;
    }
    if (formKey.currentState!.validate() &&
        emailController.value.text.isNotEmpty &&
        pwdController.value.text.isNotEmpty) {

      LoadingDialog.show(context);
      Future.delayed(const Duration(seconds: 5), () {
        LoadingDialog.hide(context);
      });
      // emailController.value.clear();
      // passwordController.value.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}