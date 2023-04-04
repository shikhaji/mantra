class GetPurchasedCourseCategory {
  int? status;
  String? message;
  List<Course>? course;

  GetPurchasedCourseCategory({this.status, this.message, this.course});

  GetPurchasedCourseCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['course'] != null) {
      course = <Course>[];
      json['course'].forEach((v) {
        course!.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.course != null) {
      data['course'] = this.course!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  String? pCLID;
  String? pCLTT;
  String? pCLCLID;
  String? pLCTRANSACTIONID;
  String? pLCPAYMENTDATE;
  String? pLCPAYMENTSTATUS;
  String? pLCLOGINID;
  String? cCFVID;
  String? cCFVTT;
  String? cCFVNAME;
  String? cCFVSTATUS;
  String? cCFVCOMMISION;
  String? cCFVCOURSEIMAGE;
  String? cCFVTOTALLESSONS;
  String? cCFVURL;

  Course(
      {this.pCLID,
        this.pCLTT,
        this.pCLCLID,
        this.pLCTRANSACTIONID,
        this.pLCPAYMENTDATE,
        this.pLCPAYMENTSTATUS,
        this.pLCLOGINID,
        this.cCFVID,
        this.cCFVTT,
        this.cCFVNAME,
        this.cCFVSTATUS,
        this.cCFVCOMMISION,
        this.cCFVCOURSEIMAGE,
        this.cCFVTOTALLESSONS,
        this.cCFVURL});

  Course.fromJson(Map<String, dynamic> json) {
    pCLID = json['PCL_ID'];
    pCLTT = json['PCL_TT'];
    pCLCLID = json['PCL_CL_ID'];
    pLCTRANSACTIONID = json['PLC_TRANSACTION_ID'];
    pLCPAYMENTDATE = json['PLC_PAYMENT_DATE'];
    pLCPAYMENTSTATUS = json['PLC_PAYMENT_STATUS'];
    pLCLOGINID = json['PLC_LOGIN_ID'];
    cCFVID = json['CCFV_ID'];
    cCFVTT = json['CCFV_TT'];
    cCFVNAME = json['CCFV_NAME'];
    cCFVSTATUS = json['CCFV_STATUS'];
    cCFVCOMMISION = json['CCFV_COMMISION'];
    cCFVCOURSEIMAGE = json['CCFV_COURSE_IMAGE'];
    cCFVTOTALLESSONS = json['CCFV_TOTAL_LESSONS'];
    cCFVURL = json['CCFV_URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PCL_ID'] = this.pCLID;
    data['PCL_TT'] = this.pCLTT;
    data['PCL_CL_ID'] = this.pCLCLID;
    data['PLC_TRANSACTION_ID'] = this.pLCTRANSACTIONID;
    data['PLC_PAYMENT_DATE'] = this.pLCPAYMENTDATE;
    data['PLC_PAYMENT_STATUS'] = this.pLCPAYMENTSTATUS;
    data['PLC_LOGIN_ID'] = this.pLCLOGINID;
    data['CCFV_ID'] = this.cCFVID;
    data['CCFV_TT'] = this.cCFVTT;
    data['CCFV_NAME'] = this.cCFVNAME;
    data['CCFV_STATUS'] = this.cCFVSTATUS;
    data['CCFV_COMMISION'] = this.cCFVCOMMISION;
    data['CCFV_COURSE_IMAGE'] = this.cCFVCOURSEIMAGE;
    data['CCFV_TOTAL_LESSONS'] = this.cCFVTOTALLESSONS;
    data['CCFV_URL'] = this.cCFVURL;
    return data;
  }
}