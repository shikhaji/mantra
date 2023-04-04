import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:sizer/sizer.dart';
import '../../model/auth_result.dart';
import '../../model/get_logo_model.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/function.dart';
import '../../utils/loader.dart';
import '../../utils/validation_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/scrollview.dart';

class OtpVerificationScreen extends StatefulWidget {
  final OtpArguments? arguments;

  const OtpVerificationScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with ValidationMixin {
  TextEditingController _controller = TextEditingController(text: "");
  LOGO? getLogo;

  int pinLength = 6;
  int _seconds = -1;
  Timer? _timer;
  String _verificationId = '';

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    ApiService().getLogo(context).then((value) =>
        setState(() { getLogo = value.lOGO;})
    );
    debugPrint("${widget.arguments?.phoneNumber}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await sendCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
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
            appText("OTP Verification", style: AppTextStyle.title),
            SizedBoxH6(),
            appText(
                "Enter 6 digit code sent to your phone number",
                style: AppTextStyle.subTitle),
            SizedBoxH28(),
            appText("Enter OTP", style: AppTextStyle.lable),
            SizedBoxH8(),
            PinCodeTextField(
              autofocus: false,
              controller: _controller,
              hideCharacter: false,
              highlight: false,
              highlightColor: Theme.of(context).cardColor,
              defaultBorderColor: Theme.of(context).cardColor,
              hasTextBorderColor: Theme.of(context).cardColor,
              highlightPinBoxColor: Theme.of(context).cardColor,
              pinBoxColor: AppColor.textFieldColor,
              maxLength: pinLength,
              onDone: (text) {
                _controller.text = text;
              },
              pinBoxWidth: 45,
              pinBoxHeight: 55,
              hasUnderline: false,
              pinBoxRadius: 10,
              wrapAlignment: WrapAlignment.spaceAround,
              pinBoxDecoration:
              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: const TextStyle(fontSize: 22.0),
              pinTextAnimatedSwitcherTransition:
              ProvidedPinBoxTextAnimation.scalingTransition,
              pinTextAnimatedSwitcherDuration:
              const Duration(milliseconds: 300),
              highlightAnimationBeginColor: Theme.of(context).cardColor,
              highlightAnimationEndColor: Theme.of(context).cardColor,
              keyboardType: TextInputType.number,
            ),
            SizedBoxH20(),
            PrimaryButton(
                lable: "Verify OTP",
                onPressed: () async {
                  if (_controller.text == "") {
                    CommonFunctions.toast("please enter otp code !!");
                  } else {
                    print("co_controller.text:=${_controller.text}");
                    AuthResult result = await _verify(_controller.text);
                    if (result.status) {}
                  }
                }
                ),
            SizedBox(height: Sizes.s30.h),
            if (_timer?.isActive ?? false)
              Center(
                child: Text(
                  _seconds.toString(),
                  style: TextStyle(
                    fontSize: Sizes.s18.sp,
                  ),
                ),
              )
            else if (_seconds != -1)
              GestureDetector(
                onTap: () async => sendCode(),
                child: Center(
                  child: appText(
                    'Resend Code',
                    style: AppTextStyle.redTextStyle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> sendCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${"+91"}${widget.arguments?.phoneNumber}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'web-context-cancelled') {
          throw e.message ?? 'Error';
        } else {
          throw e.message ?? 'Error';
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        setState(() {});
        _startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        print("verificationId:=$verificationId");
        print("_verificationId_verificationId:=$_verificationId");

        setState(() {});
      },
    );
  }

  Future _verify(String smsCode) async {
    Loader.showLoader();
    try {
      final PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      UserCredential credential =
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      if (widget.arguments?.otpStatus == 1) {
        CommonFunctions.toast("otp verify successfully !!");
        Navigator.pushNamed(context, Routs.resetPassword,arguments:
        OtpArguments(phoneNumber: widget.arguments?.phoneNumber));

      } else {
        CommonFunctions.toast("otp verify successfully !!");
        Navigator.pushNamed(context, Routs.signUp,
            arguments:
            OtpArguments(phoneNumber: widget.arguments?.phoneNumber));
      }

      Loader.hideLoader();
      return AuthResult(status: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      Loader.hideLoader();
      debugPrint('inside catch : ${e.message}');
      AuthResult result = AuthResult(status: false, message: e.message);

      switch (e.code) {
        case 'invalid-verification-code':
          result.message = 'Your SMS code is invalid.';
          break;
        case 'provider-already-linked':
          result.message = 'This phone number is already registered.';
          break;
        default:
      }
      if (result.message != null) {
        _controller.clear();
        CommonFunctions.toast(result.message!);
      }
      return AuthResult(status: false);
    }
    }
 }