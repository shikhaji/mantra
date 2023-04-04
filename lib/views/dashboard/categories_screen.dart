import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../model/all_main_course_model.dart';
import '../../model/check_course_model.dart';
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
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<MainCourse> getAllCourses=[];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  late var _razorpay;
  String courseId ="";
  String loginId ="";

  List<MainCourse> allCourseListRes = [];
  List<CheckCourse> checkCourseList = [];
  bool _isSearching = false;



  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginId();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    callApi();


  }

  Future<void> callApi()async {
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
      setState(() {});
    }
  }



  Future<void>getLoginId()async{
    String? id = await Preferances.getString("userId");
    setState(() {
      loginId="$id";
      print("LoginId:$loginId");
    });
  }

  Future<void> _onSearchHandler(String qurey) async {
    if (qurey.isNotEmpty) {
      _isSearching = true;
      getAllCourses = _isSearching ? searchCourse(qurey) : getAllCourses;
    } else {
      getAllCourses.clear();
      getAllCourses = allCourseListRes;
      _isSearching = false;
    }
    setState(() {});
  }

  List<MainCourse> searchCourse(String qurey) {
    return allCourseListRes
        .where((e) => e.cMCNAME!.toLowerCase().contains(qurey.toLowerCase()))
        .toList();
  }

  String? paymentId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    print("paymentStatus");
    print(paymentId);
    print("LoginId:${loginId?.replaceAll('"','').replaceAll('"', '').toString()}");
    print("CourseId:$courseId");
    try{
      FormData data(){
        return FormData.fromMap({"course_id":courseId,"transaction_id":paymentId,"payment_status":1,"loginid":loginId?.replaceAll('"','').replaceAll('"', '').toString()});
      }
      ApiService().addPurchase(context,data: data()).then((value) {
        callApi();
      });
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
            child: Column(
              children: [
                SizedBoxH18(),
                PrimaryTextField(
                  controller: _searchController,
                  onChanged: _onSearchHandler,
                  hintText: 'Search Course',
                  color: AppColor.textFieldColor,
                  suffix: _isSearching
                      ? InkWell(
                    onTap: () {
                      _searchController.clear();
                      _isSearching = false;
                      getAllCourses.clear();
                      getAllCourses = allCourseListRes;
                      setState(() {});
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                  )
                      : null,
                ),
                SizedBoxH8(),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("All Courses ",style: AppTextStyle.alertSubtitle.copyWith(color: AppColor.drawerBackground))),
                SizedBoxH8(),

                Expanded(
                  child: SizedBox(
                    height: Sizes.s600,
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
                              amount: "${getAllCourses[inx].cMCCOMMISION ?? ""
                              }"
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
          title: "All Courses",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            openDrawer();
          },
        ));
  }
  Widget CoursesListContainer(
  {required String image,
  required String name,
  required String lessons,
  required String amount,
  required String displayAmount,
  required String ccid,
  required String ccstatus,
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
        SizedBoxH14(),
      ],
    );


  }
}
