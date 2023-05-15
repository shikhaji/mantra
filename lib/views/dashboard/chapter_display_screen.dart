import 'dart:io';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:teachmantra/utils/function.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../model/course_categoryid_model.dart';
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
import '../../widgets/primary_button.dart';
import '../../widgets/scrollview.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';


class ChapterDisplayScreen extends StatefulWidget {
  final OtpArguments? arguments;

  const ChapterDisplayScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<ChapterDisplayScreen> createState() => _ChapterDisplayScreenState();
}



class _ChapterDisplayScreenState extends State<ChapterDisplayScreen> {
  List<Course> getAllCourseDetails = [];
  List<Record> getAllQuestionDetails = [];
  late  String ccid ="";
  final _formKey = GlobalKey<FormState>();



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();

  //VIDEO PLAYER
  late var videoURL = "${widget.arguments?.ccUrl.toString()}";
  late var pdfURL = "https://app.teachmantra.com/uploads/${widget.arguments
      ?.ccChapterPdf}";
  late YoutubePlayerController _controller;
  double? _progress;


  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,

      ),
    );
    super.initState();

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    callApi();
    callQuestionApi();
    print("ccid: ${widget.arguments?.ccId}");
    print("chapterID: ${widget.arguments?.chapterId}");
    print(getAllQuestionDetails);
    ccid = "${widget.arguments?.ccId}";
  }

  Future<void> callApi() async {

    FormData data() {
      return FormData.fromMap({
        "cc_id": widget.arguments?.ccId,
      });
    }
    ApiService().categoryById(context,data: data()).then((value){

      setState(() {
        getAllCourseDetails=value.course!;
        ccid = '${widget.arguments?.ccId}';
      });
    });

  }

  Future<void> callQuestionApi() async {

    FormData data() {
      return FormData.fromMap({
        "courseid": widget.arguments?.chapterId,
      });
    }
    ApiService().getQuizQuestion(context,data: data()).then((value){

      setState(() {
        getAllQuestionDetails=value.record!;
        ccid = '${widget.arguments?.ccId}';
      });
    });

  }
  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScroll(
            children: [
              SizedBoxH28(),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image:  NetworkImage("https://app.teachmantra.com/uploads/${widget.arguments?.ccImg}"),
                fit: BoxFit.cover,
              ),
            ),
            height: Sizes.s200.h,

            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(10),

                child:GestureDetector(

                    onTap: (){
                      Navigator.pushNamed(context, Routs.videoPlayer,arguments: OtpArguments(
                        ccUrl: videoURL,

                        // ccChapterName: name,
                        // ccCourseName: chapterName,
                        // ccChapterPdf: chapterPdf,
                        // ccDesc: desc,
                      ));
                    },

                    child: Image.asset(AppAsset.youtube1,scale: 15)),
              ),
            ),
          ),


              SizedBoxH20(),
              PrimaryButton(lable: 'Take Quiz', onPressed: ()
              {
                if (_formKey.currentState!.validate()) {

                  ApiService().getQuizQuestion(context,data: cid()).then((value) {
                    if(value.status ==200){

                      Navigator.pushNamed(context, Routs.questionScreen,arguments: OtpArguments(
                      ccId: ccid,
                      chapterId: "${widget.arguments?.chapterId}"));
                    }
                    else{
                      CommonFunctions.toast('No Quiz Available');
                    }
                  });
                }
              },
              //     {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => const MyCall()),
              //       );
              //     },
                  color: AppColor.primaryColor),
              SizedBoxH18(),
              Align(
                  alignment: Alignment.topLeft,
                  child: appText("${widget.arguments?.ccCourseName}",
                      style: AppTextStyle.title)
              ),
              SizedBoxH20(),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "${widget.arguments?.ccDesc}",
                    style: AppTextStyle.subTitle),
              ),


            ],

          ),
        ),
      ),

      appBar: SecondaryAppBar(
        title: "${widget.arguments?.ccCourseName}",
        isLeading: true,
        leadingIcon: Icons.arrow_back,
      ),
      bottomNavigationBar: _progress!=null?SizedBox(width: 5 , height: 5.h,child: Center(child: CircularProgressIndicator())):Material(
        color: AppColor.primaryColor,
        child: InkWell(
          onTap: () {
            FileDownloader.downloadFile(url: pdfURL.trim(),
                onProgress: (name, progress){
                  setState(() {
                    _progress = progress;
                  });
                },
                onDownloadCompleted: (value){
                  print('path $value');
                  setState(() {
                    _progress = null;
                  });
                  Fluttertoast.showToast(
                    msg: 'Download Successfully',
                    backgroundColor: Colors.grey,
                  );
                }
            );
          },
          child: const SizedBox(
            height: Sizes.s50,
            width: double.infinity,
            child: Center(
              child: Text(
                'Download Course Materials',
                style: AppTextStyle.buttonTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
  FormData cid() {
    return FormData.fromMap({
      "courseid": widget.arguments?.chapterId,
    });
  }
}


