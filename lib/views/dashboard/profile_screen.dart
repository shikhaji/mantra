import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/get_logo_model.dart';
import '../../model/my_profile_model.dart';
import '../../routes/app_routes.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LOGO? getLogo;


  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  ProfileModel? myProfileData;

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
        "loginid":id?.replaceAll('"', '').replaceAll('"', '').toString(),
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
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.white,
          elevation: 0,
          width: ScreenUtil().screenWidth * 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Sizes.s20.r),
              bottomRight: Radius.circular(Sizes.s20.r),
            ),
          ),
          child: const DrawerWidget(),
        ),
        body: CustomScroll(
          children: [
            SizedBoxH34(),
            Center(
              child: Container(
                  height: Sizes.s100.h,
                  width: Sizes.s100.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("https://app.teachmantra.com/uploads/${getLogo?.sSFAVICON}"),
                        //image: AssetImage(AppAsset.mainLogoImage),
                        fit: BoxFit.cover,
                        ))),
            ),
             SizedBoxH10(),
             Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${myProfileData?.branchName ?? ""}",
                  style: AppTextStyle.headingTextTile2
                      .copyWith(fontSize: Sizes.s22),
                ),
                Text(
                  "${myProfileData?.branchEmail ?? ""}",
                  style: AppTextStyle.lable.copyWith(fontSize: Sizes.s16),
                )
              ],
            ),
            SizedBoxH20(),
            SizedBoxH20(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.textFieldColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
                title: 'Edit Profile',
                onTap: () {
                  Navigator.pushNamed(context, Routs.editProfile,);
                },
                child: Icon(Icons.perm_identity),
              ),
            ),
            SizedBoxH18(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
                title: 'FAQ',
                onTap: () {
                  Navigator.pushNamed(context, Routs.fquestion);
                },
                child: Icon(Icons.format_list_bulleted_sharp),
              ),
            ),
        SizedBoxH18(),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.textFieldColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: _ProfileListTile.asset(
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
        ),
            SizedBoxH18(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
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
            ),
            SizedBoxH18(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
                title: 'About Us',
                onTap: () async {
                  var url = Uri.parse(
                      "https://teachmantra.com/about-us.html");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Icon(Icons.account_box),
              ),
            ),
          ],
        ),
        appBar: SecondaryAppBar(
          title: "Profile",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            openDrawer();
          },
        ));
  }
}

class _ProfileListTile extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback onTap;

  _ProfileListTile.asset({
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
        onTap();
      },
    );
  }
}