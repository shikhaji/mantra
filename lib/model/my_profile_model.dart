// To parse this JSON data, do
//
//     final myProfileModel = myProfileModelFromJson(jsonString);

import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) => MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
  MyProfileModel({
    required this.status,
    required this.message,
    required this.course,
  });

  int status;
  String message;
  ProfileModel course;

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
    status: json["status"],
    message: json["message"],
    course: ProfileModel.fromJson(json["course"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "course": course.toJson(),
  };
}

class ProfileModel {
  ProfileModel({
    required this.branchId,
    this.firmId,
    required this.branchName,
    this.branchCode,
    this.branchAddress,
    this.branchState,
    this.branchCity,
    required this.branchContact,
    this.branchAltContact,
    required this.branchPhone,
    this.branchEmail,
    required this.branchTt,
    required this.branchUsername,
    required this.branchPassword,
    required this.branchStatus,
    required this.companyHrmType,
    this.parentId,
    this.branchPanNo,
    this.branchBankName,
    required this.branchHolderName,
    this.bankAccNo,
    this.ifscCode,
    required this.branchUpiNo,
    this.adharNo,
    this.sponserName,
    required this.startDate,
    required this.branchViewPassword,
    required this.notificationBefore,
    required this.panPhoto,
    required this.aadharPhoto,
    required this.studentId,
    required this.aadharBack,
    required this.branchCourseCategory,
    required this.branchStudentPhoto,
    required this.branchReferBy,
  });

  String branchId;
  dynamic firmId;
  String branchName;
  dynamic branchCode;
  dynamic branchAddress;
  dynamic branchState;
  dynamic branchCity;
  String branchContact;
  dynamic branchAltContact;
  String branchPhone;
  dynamic branchEmail;
  DateTime branchTt;
  String branchUsername;
  String branchPassword;
  String branchStatus;
  String companyHrmType;
  dynamic parentId;
  dynamic branchPanNo;
  dynamic branchBankName;
  String branchHolderName;
  dynamic bankAccNo;
  dynamic ifscCode;
  String branchUpiNo;
  dynamic adharNo;
  dynamic sponserName;
  DateTime startDate;
  String branchViewPassword;
  String notificationBefore;
  String panPhoto;
  String aadharPhoto;
  String studentId;
  String aadharBack;
  String branchCourseCategory;
  String branchStudentPhoto;
  String branchReferBy;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    branchId: json["BRANCH_ID"],
    firmId: json["FIRM_ID"],
    branchName: json["BRANCH_NAME"],
    branchCode: json["BRANCH_CODE"],
    branchAddress: json["BRANCH_ADDRESS"],
    branchState: json["BRANCH_STATE"],
    branchCity: json["BRANCH_CITY"],
    branchContact: json["BRANCH_CONTACT"],
    branchAltContact: json["BRANCH_ALT_CONTACT"],
    branchPhone: json["BRANCH_PHONE"],
    branchEmail: json["BRANCH_EMAIL"],
    branchTt: DateTime.parse(json["BRANCH_TT"]),
    branchUsername: json["BRANCH_USERNAME"],
    branchPassword: json["BRANCH_PASSWORD"],
    branchStatus: json["BRANCH_STATUS"],
    companyHrmType: json["COMPANY_HRM_TYPE"],
    parentId: json["PARENT_ID"],
    branchPanNo: json["BRANCH_PAN_NO"],
    branchBankName: json["BRANCH_BANK_NAME"],
    branchHolderName: json["BRANCH_HOLDER_NAME"],
    bankAccNo: json["BANK_ACC_NO"],
    ifscCode: json["IFSC_CODE"],
    branchUpiNo: json["BRANCH_UPI_NO"],
    adharNo: json["ADHAR_NO"],
    sponserName: json["SPONSER_NAME"],
    startDate: DateTime.parse(json["START_DATE"]),
    branchViewPassword: json["BRANCH_VIEW_PASSWORD"],
    notificationBefore: json["NOTIFICATION_BEFORE"],
    panPhoto: json["PAN_PHOTO"],
    aadharPhoto: json["AADHAR_PHOTO"],
    studentId: json["STUDENT_ID"],
    aadharBack: json["AADHAR_BACK"],
    branchCourseCategory: json["BRANCH_COURSE_CATEGORY"],
    branchStudentPhoto: json["BRANCH_STUDENT_PHOTO"],
    branchReferBy: json["BRANCH_REFER_BY"],
  );

  Map<String, dynamic> toJson() => {
    "BRANCH_ID": branchId,
    "FIRM_ID": firmId,
    "BRANCH_NAME": branchName,
    "BRANCH_CODE": branchCode,
    "BRANCH_ADDRESS": branchAddress,
    "BRANCH_STATE": branchState,
    "BRANCH_CITY": branchCity,
    "BRANCH_CONTACT": branchContact,
    "BRANCH_ALT_CONTACT": branchAltContact,
    "BRANCH_PHONE": branchPhone,
    "BRANCH_EMAIL": branchEmail,
    "BRANCH_TT": branchTt.toIso8601String(),
    "BRANCH_USERNAME": branchUsername,
    "BRANCH_PASSWORD": branchPassword,
    "BRANCH_STATUS": branchStatus,
    "COMPANY_HRM_TYPE": companyHrmType,
    "PARENT_ID": parentId,
    "BRANCH_PAN_NO": branchPanNo,
    "BRANCH_BANK_NAME": branchBankName,
    "BRANCH_HOLDER_NAME": branchHolderName,
    "BANK_ACC_NO": bankAccNo,
    "IFSC_CODE": ifscCode,
    "BRANCH_UPI_NO": branchUpiNo,
    "ADHAR_NO": adharNo,
    "SPONSER_NAME": sponserName,
    "START_DATE": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "BRANCH_VIEW_PASSWORD": branchViewPassword,
    "NOTIFICATION_BEFORE": notificationBefore,
    "PAN_PHOTO": panPhoto,
    "AADHAR_PHOTO": aadharPhoto,
    "STUDENT_ID": studentId,
    "AADHAR_BACK": aadharBack,
    "BRANCH_COURSE_CATEGORY": branchCourseCategory,
    "BRANCH_STUDENT_PHOTO": branchStudentPhoto,
    "BRANCH_REFER_BY": branchReferBy,
  };
}