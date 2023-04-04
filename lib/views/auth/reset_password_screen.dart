import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/get_logo_model.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';

class ResetPasswordScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const ResetPasswordScreen({Key? key, this.arguments}) : super(key: key);


  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with ValidationMixin {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool obscurePassword = true;
  bool obscurePassword1 = true;
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
                  child:Image.network("https://app.teachmantra.com/uploads/${getLogo?.sSFAVICON}",height: 20.h,),
                ),
                SizedBoxH28(),
                SizedBoxH28(),
                appText("Reset Password", style: AppTextStyle.title),
                SizedBoxH6(),
                appText("Enter new password here",
                    style: AppTextStyle.subTitle),
                SizedBoxH28(),
                appText("Password", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _password,
                  hintText: "Enter password",
                  validator: passwordValidator,
                  prefix: const Icon(Icons.password),
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      child: obscurePassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  obscureText: obscurePassword,
                ),
                SizedBoxH8(),
                appText("Confirm Password", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _confirmPassword,
                  hintText: "Enter confirm password",
                  validator: (value) {
                    return confirmPasswordValidator(value!, _password.text.trim());
                  },
                  prefix: const Icon(Icons.password),
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscurePassword1 = !obscurePassword1;
                        });
                      },
                      child: obscurePassword1
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  obscureText: obscurePassword1,
                ),
                SizedBoxH8(),
                PrimaryButton(
                    lable: "Reset",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint("password ${_password.text.trim()}");
                        FormData data() {
                          return FormData.fromMap({
                            "phone": widget.arguments?.phoneNumber,
                            "password": _password.text.trim(),
                          });
                        }


                        ApiService().UpdatePassword(context, data: data());
                      }
                    }),
              ],
            ),
          )),
    );
  }
}
