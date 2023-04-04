import 'dart:core';

class EndPoints {
  static const String baseUrl = "https://app.teachmantra.com/";
  static const String get = "get_ajax";
  static const String post = "post_ajax";
  static const String mobileVerify = '$baseUrl/$get/mobile_verify';
  static const String signUp = '$baseUrl/$post/add_student_account';
  static const String updatePassword = '$baseUrl/$post/update_reset_pasword';
  static const String login = '$baseUrl/$get/login';
  static const String slider = '$baseUrl/$get/get_slidder';
  static const String fquestion = '$baseUrl/$get/get_all_fquestion';
  static const String getAllCourseCategory = '$baseUrl/$get/get_all_course_category';
  static const String getAllCourseCategoryId = '$baseUrl/$get/get_all_course_by_categoryid';
  static const String getMyOrderList = '$baseUrl/$get/get_my_order_list';
  static const String myProfile = '$baseUrl/$get/get_my_profile_by_id';
  static const String editProfile = '$baseUrl/$post/update_student_kyc';
  static const String addPurchase = '$baseUrl/$post/add_purchase_details';
  static const String verifyCenterCode = '$baseUrl/$get/verify_center_code';
  static const String allMainCourse = '$baseUrl/$get/get_all_main_course_category';
  static const String getQuizDetails = '$baseUrl/$get/get_contest_list';
  static const String getQuizQuestion = '$baseUrl/$get/get_question_list';
  static const String getLogo = '$baseUrl/$get/get_all_logo';
  static const String getPayment = '$baseUrl/$get/get_payment_details';

}
