import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teachmantra/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/get_logo_model.dart';
import '../model/my_profile_model.dart';
import '../services/api_services.dart';
import '../services/shared_preferences.dart';
import '../utils/app_assets.dart';
import '../utils/app_color.dart';
import '../utils/app_sizes.dart';
import '../utils/app_text_style.dart';
import '../utils/screen_utils.dart';
import '../views/Auth/login_screen.dart';
class DrawerWidget extends StatefulWidget {

  const DrawerWidget({Key? key}) : super(key: key);
  @override
  State<DrawerWidget> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> {
  ProfileModel? myProfileData;
  LOGO? getLogo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getLogo(context).then((value) =>
        setState(() { getLogo = value.lOGO;})
    );
    callApi();
  }

  Future<void> callApi() async {
    String? id = await Preferances.getString("userId");

    FormData data() {
      return FormData.fromMap({
        "loginid":id?.replaceAll('"', '').replaceAll('"'  , '').toString(),
      });
    }
    print("login id $id");
    ApiService().myProfile(context,data: data()).then((value){
      setState(() {
        myProfileData=value.course!;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ScreenUtil().setVerticalSpacing(20),
                    _DrawerMenuListTile.asset(
                      title: 'Terms & Conditions',
                      onTap: () async {
                        var url = Uri.parse(
                            "https://app.teachmantra.com/terms-conditions.html");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Icon(Icons.local_police_outlined),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Privacy Policy',
                      onTap: () async {
                        var url = Uri.parse(
                            "https://teachmantra.com/privacy-policy.html");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Icon(Icons.policy),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'About Us',
                      onTap: () async {
                        var url = Uri.parse(
                            "https://app.teachmantra.com/about-us.html");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Icon(Icons.account_box),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Payment Refund',
                      onTap: () async {
                        var url = Uri.parse(
                            "https://app.teachmantra.com/payment-refund.html");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Icon(Icons.payment),
                    ),
                    ScreenUtil().setVerticalSpacing(30),
                    SizedBox(
                      height: Sizes.s40.h,
                      width: ScreenUtil().screenWidth - 200,
                      child: PrimaryButton(
                        lable: 'Logout',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text(
                                "Logout",
                                style: AppTextStyle.alertSubtitle,
                              ),
                              content: const Text(
                                "Are You Sure ?",
                                style: AppTextStyle.subTitle,
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("Cancel"),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        SharedPreferences sharedPreferences =
                                        await SharedPreferences
                                            .getInstance();
                                        sharedPreferences.clear();
                                        Navigator.of(
                                            context)
                                            .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginScreen()),
                                                (Route<dynamic> route) =>
                                            false);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return SizedBox(
      height: Sizes.s240.h,
      child: Container(

        decoration: BoxDecoration(
          color: AppColor.drawerBackground,
          borderRadius: BorderRadius.only(topLeft:Radius.zero,topRight: Radius.circular(18),bottomLeft: Radius.circular(25),bottomRight:  Radius.circular(25),),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: Sizes.s80.h,
                    width: Sizes.s80.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("https://app.teachmantra.com/uploads/${getLogo?.sSFAVICON}"),
                          //image: AssetImage(AppAsset.mainLogoImage),
                          fit: BoxFit.cover,
                        ))),
                ScreenUtil().setVerticalSpacing(10),
                Text(
                  "${myProfileData?.branchName ?? ""}",
                  style: AppTextStyle.appBarTextTitle
                      .copyWith(color: AppColor.white),
                ),
                Text(
                  "${myProfileData?.branchEmail ?? ""}",
                  style: AppTextStyle.lable.copyWith(color: AppColor.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class _DrawerMenuListTile extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback onTap;

  _DrawerMenuListTile.asset({
    required this.onTap,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: child,
      title: Text(
        title,
        style: AppTextStyle.lable,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.black,
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

