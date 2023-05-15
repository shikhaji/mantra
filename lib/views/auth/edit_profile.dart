

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/get_logo_model.dart';
import '../../model/my_profile_model.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';

class EditProfile extends StatefulWidget {
  final OtpArguments? arguments;
  const EditProfile({Key? key, this.arguments}) : super(key: key);


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with ValidationMixin {
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _referCode = TextEditingController();
  final TextEditingController _categories = TextEditingController();
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  ProfileModel? myProfileData;
  LOGO? getLogo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("${widget.arguments?.phoneNumber}");
    ApiService().getLogo(context).then((value) =>
        setState(() { getLogo = value.lOGO;})
    );
    callApi();
  }
 Future<void> callApi() async {
   String? id = await Preferances.getString("userId");

   FormData data() {
     return FormData.fromMap({
       "loginid":id?.replaceAll('"', '').replaceAll('"', '').toString(),
     });
   }
   print("login id $id");
   ApiService().myProfile(context,data: data()).then((value){
     setState(() {
       myProfileData=value.course!;
       _name.text=value.course.branchName;
       _email.text=value.course.branchEmail;
       _phone.text=value.course.branchPhone;
     });
     print("name:${myProfileData?.branchName}");
     print("name:${myProfileData?.branchEmail}");
     print("name:${myProfileData?.branchPhone}");

   });

 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Edit Profile",
        isLeading: true,
        leadingIcon: Icons.arrow_back_sharp,
      ),
      backgroundColor: AppColor.white,
      body: SafeArea(
          child: Form(
            key: _formKey,
            child: CustomScroll(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxH34(),
                Center(
                  child: Image.network("https://app.teachmantra.com/uploads/${getLogo?.sSHEADERLOGO}",height: 20.h,),
                ),
                SizedBoxH28(),
                appText("Edit Profile", style: AppTextStyle.title),
                SizedBoxH28(),
                appText("Name", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _name,
                  validator: nameValidator,
                  prefix: const Icon(Icons.perm_identity),
                  hintText: "Enter your name",
                ),
                SizedBoxH10(),
                appText("Phone number", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _phone,
                  readOnly: true,
                  prefix: const Icon(Icons.phone),
                  hintText: widget.arguments?.phoneNumber,
                ),
                SizedBoxH10(),
                appText("Email id", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _email,
                  keyboardInputType: TextInputType.emailAddress,
                  validator: emailValidator,
                  prefix: const Icon(Icons.email),
                  hintText: "Enter your email",
                ),
                SizedBoxH10(),
                SizedBoxH14(),

                PrimaryButton(
                    lable: "Update",
                    onPressed: () async{

                      String? id = await Preferances.getString("userId");
                      print("Login Id here:${id?.replaceAll('"','').replaceAll('"', '').toString()}");
                      if (_formKey.currentState!.validate()) {
                        FormData data() {
                          return FormData.fromMap({
                            "login_id":id?.replaceAll('"','').replaceAll('"', '').toString(),
                            "name": _name.text.trim(),
                            "phone": _phone.text.trim(),
                            "email": _email.text.trim(),
                          });
                        }
                        ApiService().editProfile(context,data:data());
                      }
                    }),
              ],
            ),
          )),
    );
  }
}

