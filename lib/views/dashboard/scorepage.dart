import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';

class ScorePage extends StatefulWidget {
  final List useranswerlist;
  final List correctanswerlist;
  const ScorePage(
      {Key? key, required this.useranswerlist, required this.correctanswerlist})
      : super(key: key);

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int count = 0;
  int total = 0;

  @override
  void initState() {
    for (int i = 0; i < widget.correctanswerlist.length; i++) {
      if (widget.correctanswerlist.elementAt(i) ==
          widget.useranswerlist.elementAt(i)) {
        count++;
      }
    }
    count *= 1;
    total = widget.correctanswerlist.length * 1;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Your Result",
        isLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/quizBackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:  SizedBox(
          height: double.maxFinite,
          width: double.infinity,
          child: Column(
            children: [
              SizedBoxH120(),
              SizedBoxH34(),
              Container(
                height: Sizes.s2,
                width: Sizes.s380,
                color: AppColor.red,
              ),
              Container(
                width: Sizes.s380,
                color: AppColor.sand,
                child: Center(
                  child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Text("Your Score is",style: AppTextStyle.title,),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              padding: EdgeInsets.all(48),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.green,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withAlpha(60),
                                      blurRadius: 6.0,
                                      spreadRadius: 4.0,
                                    ),
                                  ]),
                              child: Text(
                                '${count} / ${total}',style: AppTextStyle.title,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),


                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context, Routs.mainHome,arguments: OtpArguments(bottomIndex: 2), (route) => false);

                              },
                              child: const Text("Submit",style: AppTextStyle.buttonTextStyle2,),
                            ),
                            SizedBoxH8(),
                          ],
                        )
                      ]),
                ),
              ),
              Container(
                height: Sizes.s2,
                width: Sizes.s380,
                color: AppColor.red,
              ),

            ],
          ),
        ),
      ),
    );
  }
}