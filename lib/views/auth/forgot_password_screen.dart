import 'package:dio/dio.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
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
                appText("Forgot Password", style: AppTextStyle.title),
                SizedBoxH6(),
                Text("Enter registered phone number and we will send you an OTP",
                    style: AppTextStyle.subTitle),
                SizedBoxH18(),
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
                            if (value.count == 1) {
                              // Navigator.pushNamed(context, Routs.resetPassword,
                              //     arguments: OtpArguments(
                              //         phoneNumber: _phone.text.trim()));
                              Navigator.pushNamed(context, Routs.otp,
                                  arguments: OtpArguments(
                                      phoneNumber: _phone.text.trim(),otpStatus: 1));
                            } else if (value.count == 0) {
                              CommonFunctions.toast("Your number is not registered Please signUp");

                            }
                          }
                        });
                      }
                      }),
                SizedBoxH18(),

              ],
            ),
          )),
    );
  }
}
