import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';

class ResultScreen extends StatelessWidget {
  final int userPercentage;
  final int totalRight;
  final int wrongQ;
  final int ommitedQuestion;

  const ResultScreen(
      {super.key,
        required this.userPercentage,
        required this.totalRight,
        required this.wrongQ,
        required this.ommitedQuestion});

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
                            Text(
                              userPercentage < 50
                                  ? "Work Hard"
                                  : userPercentage >= 50 && userPercentage <= 99
                                  ? "You have Passed"
                                  : "Perfect Score ",
                              style: TextStyle(
                                  fontFamily: 'TanseekModernProArabic',
                                  fontSize: 22,
                                  letterSpacing: 1,
                                  color: userPercentage < 50 ? Colors.red : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Your Final Result is $userPercentage%',
                              style: TextStyle(
                                fontFamily: 'TanseekModernProArabic',
                                fontSize: 22,
                                color: userPercentage < 50 ? Colors.red : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Total Right Answers : $totalRight",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Total Wrong Answers : $wrongQ",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Total Omitted Questions : $ommitedQuestion",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context, Routs.mainHome,arguments: OtpArguments(bottomIndex: 2), (route) => false);

                              },
                              child: const Text("Submit"),
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