import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/get_logo_model.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../utils/function.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';
import 'login_screen.dart';

class MobileVerificationScreen extends StatefulWidget {
  const MobileVerificationScreen({Key? key}) : super(key: key);

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen>
    with ValidationMixin {
  final TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LOGO? getLogo;
  @override
  void initState() {
    super.initState();

    ApiService().getLogo(context).then((value) =>
        setState(() { getLogo = value.lOGO;})
    );
    print(getLogo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: Form(
              key: _formKey,
              child: CustomScroll(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxH34(),
                  SizedBoxH34(),
                  SizedBoxH34(),
                  Center(
                    child: Image.network("https://app.teachmantra.com/uploads/${getLogo?.sSFAVICON}",height: 20.h,),
                  ),
                  SizedBoxH28(),
                  SizedBoxH28(),
                  appText("Mobile Verification", style: AppTextStyle.title),
                  SizedBoxH6(),
                  appText("Please verify your mobile number first",
                      style: AppTextStyle.subTitle),
                  SizedBoxH28(),
                  appText("Phone number", style: AppTextStyle.lable),
                  SizedBoxH8(),
                  PrimaryTextField(
                    controller: _phone,
                    validator: mobileNumberValidator,
                    keyboardInputType: TextInputType.phone,
                    prefix: const Icon(Icons.phone),
                    hintText: "Enter phone number",
                  ),
                  SizedBoxH8(),
                  PrimaryButton(
                      lable: "Send OTP",
                      onPressed: () {
                          if (_formKey.currentState!.validate()) {
                          FormData data() {
                          return FormData.fromMap({
                          "mobile": _phone.text.trim(),
                          });
                          }
                          ApiService().mobileVerifyApi(context, data: data())
                              .then((value) {
                            if (value!.status == 200) {
                              if (value.count == 0) {
                                Navigator.pushNamed(context, Routs.otp,
                                    arguments: OtpArguments(
                                        phoneNumber: _phone.text.trim(),otpStatus: 0));
                              } else if (value.count == 1) {
                               CommonFunctions.toast("Your number is already registered Please login");

                              }
                            }
                          });
                       }
                      }),
                  SizedBoxH18(),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        appText(
                          "Already have an account? ",
                          style: AppTextStyle.subTitle,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>LoginScreen()));
                            //  clearField();
                          },
                          child: appText(
                            "Login",
                            style: AppTextStyle.redTextStyle
                                .copyWith(color: AppColor.primaryLightColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        );
    }
}








