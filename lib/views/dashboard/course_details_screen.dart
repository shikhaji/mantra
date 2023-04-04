import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/course_categoryid_model.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/constant.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_padding.dart';
import '../../widgets/scrollview.dart';

class CourseDetailsScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const CourseDetailsScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  List<Course> getAllCourseDetails=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callApi();
    print("ccid: ${widget.arguments?.ccId}");
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
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: PrimaryPadding(
            child: Column(
              children: [
                SizedBoxH10(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image:  NetworkImage("https://app.teachmantra.com/uploads/${widget.arguments?.ccImg}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: Sizes.s200.h,
                ),
                SizedBoxH34(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text("${getAllCourseDetails.length.toString()} Lessons",style: AppTextStyle.alertSubtitle),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor
                      ),
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
                        itemCount: getAllCourseDetails.length,
                        itemBuilder: (context, inx) {
                          return CoursesListContainer(
                            name: getAllCourseDetails[inx].cCFVNAME ?? "",
                            url: getAllCourseDetails[inx].cCFVURL ?? "",
                            chapterName: getAllCourseDetails[inx].cVLNAME ?? "",
                            chapterPdf: getAllCourseDetails[inx].cVLCOURSEPDF  ?? "",
                            desc: getAllCourseDetails[inx].cVLDESC  ?? "",
                            img: getAllCourseDetails[inx].cCFVCOURSEIMAGE  ?? "",
                            ccid: getAllCourseDetails[inx].cCFVID  ?? "",
                            chapterID: getAllCourseDetails[inx].cVLID  ?? "",

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
          leadingIcon: Icons.arrow_back,
        )
    );

  }

  Widget CoursesListContainer({
    required String name,
    required String url,
    required String chapterName,
    required String chapterPdf,
    required String desc,
    required String img,
    required String ccid,
    required String chapterID,
  }){
    return Column(
      children: [
        Container(
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
                              child: Image.network("https://app.teachmantra.com/uploads/${widget.arguments?.ccImg}",fit: BoxFit.contain,height: Sizes.s100.h,width: Sizes.s100.h,),
                            ),
                          ),

                          SizedBox(
                            width: Sizes.s18,
                          ),
                          Flexible(
                            flex: 6,
                            child: Text(chapterName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                              style: AppTextStyle.alertSubtitle1
                                  .copyWith(fontSize: Sizes.s18.h,color: AppColor.black),
                            ),
                          ),
                        ],
                      ),

                    ),
                    CircleAvatar(
                      child: IconButton(

                        onPressed: (){
                          Navigator.pushNamed(context, Routs.chapterDisplay,
                              arguments: OtpArguments(
                                  ccUrl: url,
                                  ccChapterName: name,
                                  ccCourseName: chapterName,
                                  ccChapterPdf: chapterPdf,
                                  ccDesc: desc,
                                  ccImg: img,
                                ccId: ccid,
                                chapterId: chapterID,

                              ));
                          //  clearField();

                        },
                        icon: Icon(Icons.play_arrow),
                        color: AppColor.white,
                      ),
                      backgroundColor: AppColor.drawerBackground,

                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBoxH10(),
      ],
    );


  }
}

