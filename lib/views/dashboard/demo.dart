import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../model/course_categoryid_model.dart';
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
import '../../widgets/scrollview.dart';

class DemoScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const DemoScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}



class _DemoScreenState extends State<DemoScreen> {
  List<Course> getAllCourseDetails = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();

  //VIDEO PLAYER
  late var videoURL = "https://www.youtube.com/watch?v=DIqB8qEZW1U";
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
        loop: false,
      ),
    );
    super.initState();

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


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
      body: CustomScroll(
        children: [
          SizedBoxH28(),

          Container(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () => debugPrint("Ready"),
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,

                  colors: const ProgressBarColors(
                    playedColor: AppColor.primaryColor,
                    handleColor: AppColor.primaryLightColor,
                  ),
                ),
                RemainingDuration(),
                PlaybackSpeedButton(),
                FullScreenButton(),
              ],
            ),

          ),
          SizedBoxH10(),
          SizedBoxH34(),
          SizedBoxH34(),
          Align(
              alignment: Alignment.topLeft,
              child: appText("Demo Page",
                  style: AppTextStyle.title)
          ),
          SizedBoxH20(),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
                "This is Demo Page Description",
                style: AppTextStyle.subTitle),
          ),
          SizedBoxH34(),
          Align(
            alignment: Alignment.topLeft,
            child:
              _controller.value.isPlaying?
            appText("Total Video Watched : "+getVideoPosition(),style: AppTextStyle.title)
                  :appText("Total Video Watched : "+getVideoPosition(),style: AppTextStyle.title)
          ),


        ],

      ),

      appBar: SecondaryAppBar(
        title: "Demo Page",
        isLeading: true,
        leadingIcon: Icons.arrow_back,
      ),
    );
  }
  getVideoPosition() {

    var duration = Duration(milliseconds: _controller.value.position.inMilliseconds.round());
    return [duration.inMinutes, duration.inSeconds].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }


}


