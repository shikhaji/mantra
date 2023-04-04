import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../model/all_main_course_model.dart';
import '../../model/my_profile_model.dart';
import '../../routes/app_routes.dart';
import '../../routes/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/constant.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_padding.dart';
import '../../widgets/scrollview.dart';
import 'main_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();
  int _selectedSliderIndex = 0;
  List sliderImageList = [];
  List latestNewsList = [];
  List<MainCourse> getAllCourses=[];
  List<MainCourse> allCourseListRes = [];
  ProfileModel? myProfileData;
  bool _isSearching = false;
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  void initState() {
    super.initState();

    callApi();
    callCourseApi();
    getProfileApi();
  }

  Future<void> callApi() async {

    ApiService().slider(context).then((value) {
      setState(() {
        sliderImageList = value.detail! ;
      });
      print("slider images ;=${sliderImageList[0].bannerImage}");
    });

  }
  Future<void> callCourseApi()async {
    String? id = await Preferances.getString("userId");
    FormData data() {
      return FormData.fromMap({
        "loginid":id?.replaceAll('"', '').replaceAll('"', '').toString(),
        "status" :"0",
      });
    }
    GetAllMainCourse? _getAllCourseCategory= await ApiService().getAllMainCourses(context,data: data());

    if(_getAllCourseCategory != null){

      getAllCourses = _getAllCourseCategory.course!
          .map((e) => MainCourse.fromJson(e.toJson()))
          .toList();
      allCourseListRes = _getAllCourseCategory.course!
          .map((e) => MainCourse.fromJson(e.toJson()))
          .toList();

    }
  }
  Future<void> getProfileApi() async {
    String? id = await Preferances.getString("userId");

    FormData data() {
      return FormData.fromMap({
        "loginid":id?.replaceAll('"', '').replaceAll('"', '').toString(),
      });
    }
    print("login id $id");
    ApiService().myProfile(context,data: data()).then((value){
      setState(() {
        myProfileData=value.course;
        Preferances.setString("phone", value.course.branchPhone);
      });
    });

  }




  String? paymentId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    //Paymnet sucess api call;
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
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
        body: SafeArea(
          child: PrimaryPadding(
              child:Column(
                children: [
                  SizedBoxH18(),
                  SizedBox(
                    width: double.infinity,
                    child: CarouselSlider.builder(
                        carouselController: buttonCarouselController,
                        itemCount: sliderImageList.length ?? 0,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                            Padding(
                                padding: const EdgeInsets.only(right: 3, left: 3),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            'https://app.teachmantra.com/uploads/${sliderImageList[itemIndex].bannerImage}',
                                          ),
                                          fit: BoxFit.cover)),
                                )),
                        options: CarouselOptions(
                          onPageChanged: (index, _) {
                            setState(() {
                              _selectedSliderIndex = index;
                            });
                          },
                          aspectRatio: 15 / 8,
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                  SizedBoxH18(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        sliderImageList.length,
                            (index) => Indicator(
                            isActive: _selectedSliderIndex == index ? true : false),
                      )
                    ],
                  ),
                  SizedBoxH10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recommended Courses ",style: AppTextStyle.alertSubtitle),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, Routs.mainHome,arguments: OtpArguments(bottomIndex: 1));
                      }, child: Text("See All",style: AppTextStyle.subTitle.copyWith(color: AppColor.drawerBackground),))
                    ],
                  ),
                  SizedBoxH10(),
                  Expanded(
                    child: SizedBox(
                      height: Sizes.s350,
                      child:SingleChildScrollView(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getAllCourses.length,
                          itemBuilder: (context, inx) {
                            return CoursesListContainer(
                              image:getAllCourses[inx].cMCIMAGE ?? "",
                              name:getAllCourses[inx].cMCNAME ?? "",
                              lessons: "${getAllCourses[inx].cMCCHAPTERS ?? ""} ",
                              displayAmount: "₹${getAllCourses[inx].cMCCOMMISION ?? ""}",
                              ccid: getAllCourses[inx].cMCID ?? "",
                              ccstatus: getAllCourses[inx].cMCSTATUS ?? "",
                              ccIntroVideo: getAllCourses[inx].cMCINTROURL ?? "",
                              ccDescription: getAllCourses[inx].cMCDESC ?? "",
                              amount: "${getAllCourses[inx].cMCCOMMISION ?? ""}",
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  //Container
                ],
              )
          ),
        ),
        appBar: SecondaryAppBar(
          title: "Home",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            openDrawer();
          },
        )
    );

  }


  Widget CoursesListContainer(
      {required String image,
        required String name,
        required String lessons,
        required String amount,
        required String ccid,
        required String ccstatus,
        required String displayAmount,
        required String ccIntroVideo,
        required String ccDescription,
      }
      ){
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
                                Text("${lessons}Lessons",
                                    style: AppTextStyle.alertSubtitle1.copyWith(fontSize: Sizes.s14.h)),
                                SizedBoxH8(),
                                appText(displayAmount,
                                    style: AppTextStyle.title
                                        .copyWith(fontSize: Sizes.s14.h,color: AppColor.primaryColor)),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                    CircleAvatar(
                      child: IconButton(

                        onPressed: (){
                          Navigator.pushNamed(context, Routs.courseBuy,
                              arguments: OtpArguments(
                                ccId: ccid,
                                ccUrl: ccIntroVideo,
                                ccCourseName: name,
                                ccDesc: ccDescription,
                                ccAmount: amount,
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
        SizedBoxH10(),
      ],
    );


  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      width: isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 2.0)),
    );
  }
}