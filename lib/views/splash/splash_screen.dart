import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:teachmantra/model/get_logo_model.dart';
import 'package:teachmantra/views/splash/welcome_screen.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_assets.dart';
import '../dashboard/main_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LOGO? getLogo;
  @override
  initState() {
    super.initState();
    ApiService().getLogo(context).then((value) =>
        setState(() { getLogo = value.lOGO;})
    );
    getData();
  }

  Future getData() async {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      String? id = await Preferances.getString("userId");
      String? token = await Preferances.getString("Token");
      print("userId:=${id}");
      print("token:=${token}");
      if (id != null ) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>  MainHomeScreen(arguments: OtpArguments(bottomIndex: 0),)),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Center(
        child:Image.network("https://app.teachmantra.com/uploads/${getLogo?.sSFAVICON}",height: 20.h,),
        // child: Image.asset(
        //   AppAsset.mainLogoImage,
        //   height: 25.h,
        // ),
      )
    ));
  }
}
