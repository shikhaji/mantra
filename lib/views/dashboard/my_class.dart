
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/all_main_purchased_course.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/constant.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';

class MyClassScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const MyClassScreen({Key? key, this.arguments,}) : super(key: key);

  @override
  State<MyClassScreen> createState() => _MyClassScreenState();
}

class _MyClassScreenState extends State<MyClassScreen> {
  List<PurchasedCourse> myOrderList=[];
  List<PurchasedCourse> getAllCourses=[];
  List<PurchasedCourse> allCourseListRes = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }

  Future<void> callApi()async {
    String? id = await Preferances.getString("userId");
    FormData data() {
      return FormData.fromMap({
        "loginid":id?.replaceAll('"', '').replaceAll('"', '').toString(),
        "status" :"1",
      });
    }
    GetAllMainPurchasedCourse? _getPurchaseCourseCategory= await ApiService().getAllMainPurchasedCourses(context,data: data());

    if(_getPurchaseCourseCategory != null){

      getAllCourses = _getPurchaseCourseCategory.course
      !.map((e) => PurchasedCourse.fromJson(e.toJson()))
          .toList();
      allCourseListRes = _getPurchaseCourseCategory.course
      !.map((e) => PurchasedCourse.fromJson(e.toJson()))
          .toList();
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.white,
          elevation: 0,
          width: ScreenUtil().screenWidth * 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Sizes.s20.r),
              bottomRight: Radius.circular(Sizes.s20.r),
            ),
          ),
          child: const DrawerWidget(),
        ),
        body: CustomScroll(
          children: [
            SizedBoxH10(),

            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getAllCourses.length,
              itemBuilder: (context, inx) {
                return CoursesListContainer(
                  image: getAllCourses[inx].cMCIMAGE ?? "",
                  ccid: getAllCourses[inx].cMCID ?? "",
                  name:getAllCourses[inx].cMCNAME ?? "",
                  url:getAllCourses[inx].cMCINTROURL ?? "",
                  lessons: "${getAllCourses[inx].cMCCHAPTERS ?? ""} Categories",
                );


              },

            ),



          ],
        ),
        appBar: SecondaryAppBar(
          title: "My Class",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            openDrawer();
          },
        ));
  }
  Widget CoursesListContainer({
    required String image,
    required String name,
    required String lessons,
    required String ccid,
    required String url,
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
                          Navigator.pushNamed(context, Routs.myOrder,
                              arguments: OtpArguments(
                                ccImg: image,
                                ccId: ccid,
                                ccCourseName: name,
                                ccLessons: lessons,
                                ccUrl: url,
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
        SizedBoxH14(),
      ],
    );


  }
}
