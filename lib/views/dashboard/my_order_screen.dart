import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../model/course_category_model.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/constant.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_padding.dart';

class MyOrderScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const MyOrderScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {

  //VIDEO PLAYER
  late var videoURL = "${widget.arguments?.ccUrl.toString()}";
  late var pdfURL = "https://app.teachmantra.com/uploads/${widget.arguments
      ?.ccChapterPdf}";
  late YoutubePlayerController _controller;
  double? _progress;

  List<Course> myOrderList=[];
  List<Course> getAllCourses=[];
  List<Course> allCourseListRes = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    callApi();
    print("ccid: ${widget.arguments?.ccId}");
  }

  Future<void> callApi()async {
    String? id = await Preferances.getString("userId");
    FormData data() {
      return FormData.fromMap({
        "loginid":id?.replaceAll('"', '').replaceAll('"', '').toString(),
        "cc_id" :'${widget.arguments?.ccId}',
        "status":1
      });
    }
   ApiService().getPurchasedCourses(context,data: data()).then((value){

     setState(() {
       getAllCourses = value.course!;
     });
   });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: PrimaryPadding(
            child: Column(
              children: [
                SizedBoxH10(),
                SizedBoxH10(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text("${getAllCourses.length.toString()} Category",style: AppTextStyle.alertSubtitle2),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor
                      ),
                      child: TextButton(onPressed: (){

                        Navigator.pushNamed(context, Routs.paymentDes,arguments: OtpArguments(ccId:"${widget.arguments!.ccId}"));

                      }, child: appText("Purchased Receipt",style: AppTextStyle.alertSubtitle1.copyWith(color: AppColor.white))),
                    )
                  ],
                ),

                SizedBoxH20(),
                Expanded(
                  child: SizedBox(
                    height: Sizes.s320,
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: getAllCourses.length,
                        itemBuilder: (context, inx) {
                          return CoursesListContainer(
                            image: getAllCourses[inx].cCFVCOURSEIMAGE ?? "",
                            ccid: getAllCourses[inx].cCFVID ?? "",
                            name:getAllCourses[inx].cCFVNAME ?? "",
                            lessons: "${getAllCourses[inx].cCFVTOTALLESSONS ?? ""} Lessons",


                          );


                        },

                      ),
                    ),
                  ),
                ),
                //Container

              ],
            ),
          ),

        ),
        appBar: SecondaryAppBar(
          title: "${widget.arguments?.ccCourseName}",
          isLeading: true,
          leadingIcon: Icons.arrow_back_ios,

        ));
  }
  Widget CoursesListContainer({
    required String image,
    required String name,
    required String lessons,
    required String ccid,
  }){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Routs.courseDetail,
                arguments: OtpArguments(
                  ccId:ccid,
                  ccCourseName:name,
                  ccImg:image,
                ));
          },
          child:  Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.grey,width: Sizes.s1.w),
              color: AppColor.white,
              borderRadius: BorderRadius.circular(textFieldBorderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.grey.withOpacity(0.5), //color of shadow
                                    spreadRadius: 3, //spread radius
                                    blurRadius: 5, // blur radius
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network("https://app.teachmantra.com/uploads/${image}",fit: BoxFit.contain,height: Sizes.s100.h,width: Sizes.s100.h,),
                              ),
                            ),

                            SizedBox(
                              width: Sizes.s18,
                            ),
                            Flexible(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 6,
                                    style: AppTextStyle.alertSubtitle1
                                        .copyWith(fontSize: Sizes.s18.h,color: AppColor.black),
                                  ),
                                  SizedBoxH8(),
                                  Text("${lessons}",
                                      style: AppTextStyle.alertSubtitle1.copyWith(fontSize: Sizes.s14.h)),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                      CircleAvatar(
                        child: IconButton(

                          onPressed: (){
                            Navigator.pushNamed(context, Routs.courseDetail,
                                arguments: OtpArguments(
                                  ccImg: image,
                                  ccId: ccid,
                                  ccCourseName: name,
                                  ccLessons: lessons,
                                )

                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios),
                          color: AppColor.white,
                        ),
                        backgroundColor: AppColor.primaryColor,

                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBoxH14(),
      ],
    );


  }
}
