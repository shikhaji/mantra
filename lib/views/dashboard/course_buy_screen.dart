import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/course_category_model.dart';
import '../../model/get_payment_model.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_padding.dart';
import '../../widgets/scrollview.dart';

class CourseBuyScreen extends StatefulWidget {
  final OtpArguments arguments;

  const CourseBuyScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<CourseBuyScreen> createState() => _CourseBuyScreenState();
}



class _CourseBuyScreenState extends State<CourseBuyScreen> {
  List<Course> getAllCourseDetails = [];
  late var _razorpay;
  String loginId ="";
  String courseId ="";
  String phone ="";
  PaymentDetails? getPaymentDetails;
  CarouselController buttonCarouselController = CarouselController();

  //VIDEO PLAYER
  late var videoURL = "${widget.arguments.ccUrl.toString()}";

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
        hideThumbnail: true,
      ),
    );
    super.initState();
    getLoginId();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ApiService().getPayment(context).then((value) =>
        setState(() { getPaymentDetails = value.lOGO;})
    );
    print(getPaymentDetails);

  }
  Future<void>getLoginId()async{
    String? id = await Preferances.getString("userId");
    String? phoneNo = await Preferances.getString("phone");
    setState(() {
      loginId="$id";
      phone="$phoneNo";
      print("LoginId:$loginId");
    });
  }

  String? paymentId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    print("paymentStatus");
    print(paymentId);
    print("LoginId:${loginId.replaceAll('"','').replaceAll('"', '').toString()}");
    print("CourseId:$courseId");
    try{
      FormData data(){
        return FormData.fromMap({"course_id":widget.arguments.ccId,"transaction_id":paymentId,"payment_status":1,"loginid":loginId.replaceAll('"','').replaceAll('"', '').toString()});
      }
      ApiService().addPurchase(context,data: data());
    }catch(e){
      print(e.toString());
    }
    //Paymnet sucess api call;
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
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
        child: Column(
          children: [
            SizedBoxH28(),

            PrimaryPadding(
              child: Column(
                children: [
                 YoutubePlayer(
                   controller: _controller,
                   showVideoProgressIndicator: true,
                   onReady: () => debugPrint("Ready"),
                   bottomActions: [
                     CurrentPosition(),
                     ProgressBar(
                       isExpanded: true,

                       colors: const ProgressBarColors(
                         playedColor: Color(0xffa8172c),
                         handleColor: AppColor.primaryLightColor,
                       ),
                     ),
                     RemainingDuration(),
                     PlaybackSpeedButton(),
                   ],
                 ),
                  SizedBoxH20(),
                  PrimaryButton(lable: "Enroll for ₹${widget.arguments.ccAmount}",
                  onPressed: () async {
                      courseId ="${widget.arguments.ccId}";


                      var options = {
                        'key': '${getPaymentDetails?.kEYID}',
                        'amount': int.parse("${widget.arguments.ccAmount}") * 100,
                        'name': '${getPaymentDetails?.oRGNAME}',
                        'description': 'Course Purchased',
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': '${phone}',
                          'email': '',
                          'phone': '',
                        },
                      };
                      _razorpay.open(options);

                    },),
                ],
              ),
            ),
            SizedBoxH10(),

            SizedBoxH10(),
            Expanded(
              child: PrimaryPadding(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.textFieldColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBoxH14(),
                      PrimaryPadding(
                        child: Text("${widget.arguments.ccCourseName}",
                            style: AppTextStyle.appBarTextTitle,overflow: TextOverflow.ellipsis,maxLines: 10,),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBoxH14(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: PrimaryPadding(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child:  Text(
                                  "Course Description : ${widget.arguments?.ccDesc} ",
                                  style: AppTextStyle.alertSubtitle1,overflow: TextOverflow.ellipsis,maxLines: 50,),

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),



          ],
        ),



      ),

      appBar: SecondaryAppBar(
        title: "${widget.arguments?.ccCourseName} Details",
        isLeading: true,
        leadingIcon: Icons.arrow_back,
      ),
    );
  }


}


