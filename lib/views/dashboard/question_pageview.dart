import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachmantra/views/dashboard/scorepage.dart';

import '../../const/text_style.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import 'options.dart';

typedef void OptionSelectedCallback(String option);

class QuestionsPageView extends StatefulWidget {
  final List results;
  final List wrongRightList;

  QuestionsPageView({required this.results, required this.wrongRightList});

  @override
  _QuestionsPageViewState createState() => _QuestionsPageViewState();
}

class _QuestionsPageViewState extends State<QuestionsPageView> {
  List<String> _userAnswerList = [];
  List<String> correctanswerlist = [];
  int currentPagePosition = 0;
  PageController _controller = PageController();

  int seconds = 120;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _userAnswerList.addAll(widget.results.map((e) => ""));
    correctanswerlist = [];
    for (int i = 0; i < widget.results.length; i++) {
      correctanswerlist.add(widget.results.elementAt(i).correct_answer);
    }
    // for(int i =0; i < widget.results.length; i++) {
    //   _userAnswerList.add("");
    // }
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          if (seconds == 0) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Times Up !"),
                content: const Text("Thank you for giving quiz "),
                actions: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScorePage(
                              useranswerlist: _userAnswerList,
                              correctanswerlist: correctanswerlist,
                            ),
                          ),
                              (route) => false);
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: const Text("SUBMIT"),
                    ),
                  ),
                ],
              ),
            );
            //CommonFunctions.toast('Times Up');
            //quizResult(context);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle subtitle = Theme.of(context).textTheme.subtitle1!;
    final TextStyle body = Theme.of(context).textTheme.bodyText1!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.results.length,
                pageSnapping: true,
                onPageChanged: (position) {
                  currentPagePosition = position;
                },
                itemBuilder: (context, index) {
                  String userAnswer = _userAnswerList[index];
                  int checkedOptionPosition =
                  widget.wrongRightList[index].indexOf(userAnswer);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${index + 1}',
                              style:AppTextStyle.title.copyWith(color: Colors.yellow[800]),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                normalText(
                                    color: Colors.white,
                                    size: 24,
                                    text: "$seconds"),
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    value: seconds / 60,
                                    valueColor: const AlwaysStoppedAnimation(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${widget.results.elementAt(index).question}',
                          style: AppTextStyle.title1
                              .copyWith(color: AppColor.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Options(
                          index: index,
                          wrongRightList: widget.wrongRightList,
                          selectedPosition: checkedOptionPosition,
                          onOptionsSelected: (selectedOption) {
                            print("selected item is $selectedOption");
                            _userAnswerList[currentPagePosition] =
                                selectedOption;
                            print(_userAnswerList.toList().toString());
                          },
                        ),
                        SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                        ),
                        onPressed: () {
                          _controller.animateToPage(
                            currentPagePosition == 0
                                ? 0
                                : currentPagePosition - 1,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          'Previous',
                          style: GoogleFonts.lato(
                              textStyle: body,
                              fontSize: 15,
                              color: Colors.yellow[800]),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          primary: Colors.yellow[800],
                        ),
                        onPressed: () {
                          _controller.animateToPage(
                              currentPagePosition == widget.results.length - 1
                                  ? currentPagePosition
                                  : currentPagePosition + 1,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          'Next',
                          style: GoogleFonts.lato(
                              textStyle: body,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blueGrey[800]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Colors.blueGrey[800],
                        fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.7, 50)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScorePage(
                              useranswerlist: _userAnswerList,
                              correctanswerlist: correctanswerlist,
                            ),
                          ),
                              (route) => false);
                    },
                    child: Text('SUBMIT',
                        style: AppTextStyle.buttonTextStyle2.copyWith(
                          color: AppColor.white,
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}