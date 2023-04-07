
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teachmantra/model/get_payment_model.dart';
import 'package:teachmantra/services/shared_preferences.dart';
import '../API/dio_client.dart';
import '../API/url.dart';
import '../model/all_main_course_model.dart';
import '../model/all_main_purchased_course.dart';
import '../model/course_category_model.dart';
import '../model/course_categoryid_model.dart';
import '../model/course_purchased_model.dart';
import '../model/fquestion_model.dart';
import '../model/get_logo_model.dart';
import '../model/login_model.dart';
import '../model/mobile_verify_model.dart';
import '../model/my_order_list_model.dart';
import '../model/my_profile_model.dart';
import '../model/quiz_detail_model.dart';
import '../model/quiz_question_model.dart';
import '../model/slider_model.dart';
import '../model/verify_center_code_model.dart';
import '../routes/app_routes.dart';
import '../routes/arguments.dart';
import '../utils/function.dart';
import '../utils/loader.dart';
import '../views/Auth/login_screen.dart';

class ApiService {
  ApiClient apiClient = ApiClient();
  Dio dio = Dio();

  //----------------------------MOBILE VERIFY API-----------------------//
  Future<MobileVerifyModel?> mobileVerifyApi(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.mobileVerify,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        MobileVerifyModel responseData =
        MobileVerifyModel.fromJson(response.data);
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }
  //----------------------------SIGNUP API-----------------------//
  Future signUp(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.signUp,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: 'Sign Up Successfully...',
          backgroundColor: Colors.grey,
        );
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
        Navigator.pushNamedAndRemoveUntil(
            context, Routs.login, (route) => false);

        debugPrint('responseData ----- > ${response.data}');
        return response.data;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //----------------------------LOGIN API-----------------------//

  Future<LoginModel?> login(
      BuildContext context, {
        FormData? data,
        String? phoneNumber,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.login,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      LoginModel responseData = LoginModel.fromJson(response.data);
      if (responseData.message == "ok" ) {
        Preferances.setString("userId", responseData.id);
        Preferances.setString("Token", responseData.token);
        Loader.hideLoader();
        CommonFunctions.toast("Login Success");

        Navigator.pushNamedAndRemoveUntil(
            context, Routs.mainHome,arguments: OtpArguments(bottomIndex: 0), (route) => false);

        return responseData;
      } else {
        Loader.hideLoader();
        CommonFunctions.toast("Invalid Login Credential");
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
    } finally {
      Loader.hideLoader();
    }
    return null;
  }

//----------------------------RESET PASSWORD API-----------------------//
  Future UpdatePassword(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.updatePassword,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Loader.hideLoader();
        Fluttertoast.showToast(
          msg: 'Password Updated Successfully...',
          backgroundColor: Colors.grey,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

        debugPrint('responseData ----- > ${response.data}');
        return response.data;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //-----------------------SLIDER API-----------------------//

  Future<SliderModel> slider(BuildContext context,) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.slider);

      if (response.statusCode == 200) {
        SliderModel responseData = SliderModel.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //-----------------------FAQ API-----------------------//

  Future<FquestionModel> fquestion(BuildContext context,) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.fquestion);

      if (response.statusCode == 200) {
        FquestionModel responseData = FquestionModel.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //-----------------------COURSE CATEGORY API-----------------------//

  Future<GetAllCourseCategory> getAllCourses(BuildContext context,{
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.getAllCourseCategory,data: data);

      if (response.statusCode == 200) {
        GetAllCourseCategory responseData = GetAllCourseCategory.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('GetAllCourse responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }
  //-----------------------GET ALL MAIN COURSE CATEGORY API-----------------------//

  Future<GetAllMainCourse> getAllMainCourses(BuildContext context,{
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.allMainCourse,data: data);

      if (response.statusCode == 200) {
        GetAllMainCourse responseData = GetAllMainCourse.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('GetAllCourse responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //-----------------------GET ALL MAIN PURCHASED COURSE CATEGORY API-----------------------//

  Future<GetAllMainPurchasedCourse> getAllMainPurchasedCourses(BuildContext context,{
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.allMainCourse,data: data);

      if (response.statusCode == 200) {
        GetAllMainPurchasedCourse responseData = GetAllMainPurchasedCourse.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('GetAllCourse responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }
  //-----------------------COURSE PURCHASED CATEGORY API-----------------------//

  Future<GetAllCourseCategory> getPurchasedCourses(BuildContext context,{
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.getAllCourseCategory,data: data);

      if (response.statusCode == 200) {
        GetAllCourseCategory responseData = GetAllCourseCategory.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('GetAllCourse responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

  //----------------------------COURSE CATEGORY BY ID API-----------------------//
  Future<GetAllCourseCategoryId> categoryById(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.getAllCourseCategoryId,data: data);

      if (response.statusCode == 200) {
        GetAllCourseCategoryId responseData = GetAllCourseCategoryId.fromJson(response.data);

        Loader.hideLoader();
        debugPrint('responseData ----- > $responseData');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

//------------------ GET MY ORDER LIST API--------------------------------/////////
  Future getOrderListAPi(BuildContext context, {
    Map? data,
  }) async {
    try {
      Loader.showLoader();
   var url = "https://app.teachmantra.com/get_ajax/get_my_order_list";
      var response = await http.post(
        Uri.parse(url),

        body: data,);


      if (response.statusCode == 200) {


        debugPrint('payment history  ----- > ${response.body}');

        Loader.hideLoader();

        return response.body;

      } else {
        Loader.hideLoader();
        throw Exception(response.body);

      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
    }
  }

  //----------------------------MY PROFILE BY ID API-----------------------//
  Future<MyProfileModel> myProfile(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.myProfile,
          data: data);

      if (response.statusCode == 200) {
        MyProfileModel responseData = MyProfileModel.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }


  //----------------------------EDIT PROFILE BY ID API-----------------------//

  Future editProfile(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();


      Response response;
      response = await dio.post(EndPoints.editProfile,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusCode == 200) {
        debugPrint('Update profile data  ----- > ${response.data}');
        Loader.hideLoader();
        Navigator.pushNamedAndRemoveUntil(
            context, Routs.mainHome,arguments: OtpArguments(bottomIndex: 3), (route) => false);
       //Navigator.pushNamed(context, Routs.mainHome,arguments: OtpArguments(bottomIndex: 3));
        Fluttertoast.showToast(
          msg: 'Updated Sucessfully...',
          backgroundColor: Colors.grey,
        );
      } else {
        Fluttertoast.showToast(
          msg: "invalid",
          backgroundColor: Colors.grey,
        );
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      print("dio");
      debugPrint('Dio E  $e');
      Loader.hideLoader();
    }
  }


//----------------------------ADD PURCHASE API-----------------------//

  Future addPurchase(
      BuildContext context, {
        FormData? data,
      }) async {
    try {
      Loader.showLoader();

      String? id = await Preferances.getString("userId");
      String? token = await Preferances.getString("Token");
      Response response;
      response = await dio.post(EndPoints.addPurchase,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);
      if (response.statusCode == 200) {
        debugPrint('Update profile data  ----- > ${response.data}');
        Loader.hideLoader();
        Navigator.pushNamed(context, Routs.mainHome,arguments: OtpArguments(bottomIndex: 2));
        Fluttertoast.showToast(
          msg: 'Your course purchased Successfully...',
          backgroundColor: Colors.grey,
        );
      } else {
        Fluttertoast.showToast(
          msg: "invalid",
          backgroundColor: Colors.grey,
        );
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      print("dio");
      debugPrint('Dio E  $e');
      Loader.hideLoader();
    }
  }



  //----------------------------Center Code API-----------------------//

  Future<CenterCodeModel> verifyCenterCode(BuildContext context,{
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      print("data:=${data}");
      response = await dio.post(EndPoints.verifyCenterCode,
          data: data
      );
      print("12345:=${data}");

      print("respose Data here:=${response}");
      CenterCodeModel responseData = CenterCodeModel.fromJson(response.data);
      if (responseData.status == 200) {

        Loader.hideLoader();
        debugPrint('responseData ----- > ${responseData.center}');
        return responseData;
      } else {
        Loader.hideLoader();
        CommonFunctions.toast("Invalid Center Code");
        debugPrint('responseData invaild data ----- > ${responseData.center}');
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

//-----------------------GET QUIZ DETAILS API-----------------------//

  Future<QuizDetails> getQuizDetails(BuildContext context,{
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.getQuizDetails,data: data);

      if (response.statusCode == 200) {
        QuizDetails responseData = QuizDetails.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('GetQuizDetails responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }


  //-----------------------GET QUIZ QUESTION DETAILS API-----------------------//

  Future<quizQuestionModel> getQuizQuestion(BuildContext context,{
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.getQuizQuestion,data: data);

      if (response.statusCode == 200) {
        quizQuestionModel responseData = quizQuestionModel.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('GetQuizQuestion responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }
//-----------------------LOGO API-----------------------//

  Future<GetLogoModel> getLogo(BuildContext context,) async {
    try {
      Loader.hideLoader();
      Response response;
      response = await dio.post(EndPoints.getLogo);

      if (response.statusCode == 200) {
        GetLogoModel responseData = GetLogoModel.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }
//-----------------------Dynamic Payment API-----------------------//

  Future<GetPaymentModel> getPayment(BuildContext context,) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.getPayment);

      if (response.statusCode == 200) {
        GetPaymentModel responseData = GetPaymentModel.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
    }
  }

}

