import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/quiz_detail_model.dart';
import '../../model/quiz_question_model.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_padding.dart';
import '../../widgets/scrollview.dart';

class QuizDetailsScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const QuizDetailsScreen({Key? key, this.arguments}) : super(key: key);


  @override
  State<QuizDetailsScreen> createState() => _QuizDetailsScreenState();


}


class _QuizDetailsScreenState extends State<QuizDetailsScreen> {
  List<CONTEST> getAllQuizDetails = [];
  @override
  void initState() {

    super.initState();

    QuizDetail();
    print("ccid : ${widget.arguments?.ccId}");
  }
  Future<void> QuizDetail() async {

    FormData data() {
      return FormData.fromMap({
        "courseid":"1",
      });
    }
    ApiService().getQuizDetails(context,data: data()).then((value){

      setState(() {
        getAllQuizDetails = value.cONTEST!;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: getAllQuizDetails.length,
          itemBuilder: (context, inx) {
            return ContestListContainer(
              contestId : getAllQuizDetails[inx].cONTESTTEMPID ?? "",
              contestDate : getAllQuizDetails[inx].cONTESTSTARTDATE ?? "",
              contestTime : getAllQuizDetails[inx].cONTESTTIME ?? "",
              contestTotalParticipants : getAllQuizDetails[inx].tOTALPARTICIPANTS ?? "",
              contestFirstPrice : getAllQuizDetails[inx].cONTESTFIRSTPRICE ?? "",
              contestPassingMarks : getAllQuizDetails[inx].cONTESTPASSINGMARKS ?? "",
              contestSubjectName : getAllQuizDetails[inx].cVLNAME ?? "",
              contestPerQuestionTiming : getAllQuizDetails[inx].cONTESTPERQUESTIONTIMING?? "",
              contestTotalQuestions : getAllQuizDetails[inx].tOTALQUESTIONS?? "",
              contestTotalTime : getAllQuizDetails[inx].cONTESTTOTALTIME?? "",
            );
          },
        ),

      ),
      appBar: SecondaryAppBar(
        title: "Quiz Details",
        isLeading: true,
        leadingIcon: Icons.arrow_back,
      ),
      bottomNavigationBar:
      Material(
        color: AppColor.primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routs.questionScreen,arguments: OtpArguments(
                ccId: "${widget.arguments?.ccId}"
            ));
            //Navigator.push(context, MaterialPageRoute(builder: (context) => ScWebreen()));
          },

          child: const SizedBox(
            height: Sizes.s50,
            width: double.infinity,
            child: Center(
              child: Text(
                'Start Quiz',
                style: AppTextStyle.buttonTextStyle2,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget ContestListContainer({
    required String contestId,
    required String contestDate,
    required String contestTime,
    required String contestTotalParticipants,
    required String contestFirstPrice,
    required String contestPassingMarks,
    required String contestSubjectName,
    required String contestPerQuestionTiming,
    required String contestTotalQuestions,
    required String contestTotalTime,
  }){
    return  Column(
      children: [
        Container(
          height: Sizes.s210,
          color: AppColor.primaryLightColor,
          child: Column(
            children: [
              SizedBoxH10(),
              Container(
                alignment: Alignment.center,
                color: AppColor.primaryColor,
                height: Sizes.s30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    appText("Contest ID $contestId",style: AppTextStyle.buttonTextStyle1,),
                    // Row(
                    //   children: [
                    //     appText("Winning Pool",style: AppTextStyle.buttonTextStyle1,),
                    //     Image.asset(AppAsset.winner,scale:25),
                    //     SizedBoxW6(),
                    //     Icon(Icons.currency_rupee,size: 12,color: Colors.white,),
                    //     appText(contestFirstPrice,style: AppTextStyle.buttonTextStyle1,),
                    //   ],
                    // ),
                    appText("Contest ID $contestId",style: AppTextStyle.buttonTextStyle1,),
                  ],
                ),
              ),
              Container(
                color: AppColor.sand,
                height: Sizes.s90,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    appText("Total Participants = $contestTotalParticipants",style: AppTextStyle.titleRed,),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: AppColor.primaryColor,
                height: Sizes.s30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    appText("Start Date : $contestDate ",style: AppTextStyle.buttonTextStyle1,),
                    appText("Start Time : $contestTime",style: AppTextStyle.buttonTextStyle1,),
                  ],
                ),
              ),
              SizedBoxH10(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appText("CONTEST RULES",style: AppTextStyle.titleRed),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: double.maxFinite,
          width: double.infinity,
          child: Column(
            children: [
              SizedBoxH34(),
              Container(
                height: Sizes.s2,
                width: Sizes.s380,
                color: AppColor.red,
              ),
              Container(

                width: Sizes.s380,
                color: AppColor.sand,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: AppColor.sand,
                            child: Row(
                              children: [
                                SizedBoxW8(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    appText("Subject Name : $contestSubjectName",
                                        style: AppTextStyle.body1
                                            .copyWith(fontSize: Sizes.s16.h)),
                                    SizedBoxH8(),
                                    appText("Total Question : $contestTotalQuestions",
                                        style: AppTextStyle.body1
                                            .copyWith(fontSize: Sizes.s16.h)),
                                    SizedBoxH8(),
                                    appText("Passing Marks : $contestPassingMarks",
                                        style: AppTextStyle.body1
                                            .copyWith(fontSize: Sizes.s16.h)),
                                    SizedBoxH8(),
                                    appText("Total Quiz Time : $contestTotalTime minutes",
                                        style: AppTextStyle.body1
                                            .copyWith(fontSize: Sizes.s16.h)),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
      ],

    );


  }
}