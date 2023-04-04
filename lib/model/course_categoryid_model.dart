class GetAllCourseCategoryId {
  int? status;
  String? message;
  List<Course>? course;

  GetAllCourseCategoryId({this.status, this.message, this.course});

  GetAllCourseCategoryId.fromJson(Map<String, dynamic> json) {
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
  String? cVLTT;
  String? cVLCCFVID;
  String? cVLNAME;
  String? cVLSTATUS;
  String? cVLID;
  String? cVLCOURSEPDF;
  String? cVLVIDEOURL;
  String? cVLDESC;
  String? cCFVID;
  String? cCFVTT;
  String? cCFVNAME;
  String? cCFVSTATUS;
  String? cCFVCOMMISION;
  String? cCFVCOURSEIMAGE;
  String? cCFVTOTALLESSONS;
  String? cCFVURL;
  String? cCFVDESC;
  String? cCFVCMCID;

  Course(
      {this.cVLTT,
        this.cVLCCFVID,
        this.cVLNAME,
        this.cVLSTATUS,
        this.cVLID,
        this.cVLCOURSEPDF,
        this.cVLVIDEOURL,
        this.cVLDESC,
        this.cCFVID,
        this.cCFVTT,
        this.cCFVNAME,
        this.cCFVSTATUS,
        this.cCFVCOMMISION,
        this.cCFVCOURSEIMAGE,
        this.cCFVTOTALLESSONS,
        this.cCFVURL,
        this.cCFVDESC,
        this.cCFVCMCID});

  Course.fromJson(Map<String, dynamic> json) {
    cVLTT = json['CVL_TT'];
    cVLCCFVID = json['CVL_CCFV_ID'];
    cVLNAME = json['CVL_NAME'];
    cVLSTATUS = json['CVL_STATUS'];
    cVLID = json['CVL_ID'];
    cVLCOURSEPDF = json['CVL_COURSE_PDF'];
    cVLVIDEOURL = json['CVL_VIDEO_URL'];
    cVLDESC = json['CVL_DESC'];
    cCFVID = json['CCFV_ID'];
    cCFVTT = json['CCFV_TT'];
    cCFVNAME = json['CCFV_NAME'];
    cCFVSTATUS = json['CCFV_STATUS'];
    cCFVCOMMISION = json['CCFV_COMMISION'];
    cCFVCOURSEIMAGE = json['CCFV_COURSE_IMAGE'];
    cCFVTOTALLESSONS = json['CCFV_TOTAL_LESSONS'];
    cCFVURL = json['CCFV_URL'];
    cCFVDESC = json['CCFV_DESC'];
    cCFVCMCID = json['CCFV_CMC_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CVL_TT'] = this.cVLTT;
    data['CVL_CCFV_ID'] = this.cVLCCFVID;
    data['CVL_NAME'] = this.cVLNAME;
    data['CVL_STATUS'] = this.cVLSTATUS;
    data['CVL_ID'] = this.cVLID;
    data['CVL_COURSE_PDF'] = this.cVLCOURSEPDF;
    data['CVL_VIDEO_URL'] = this.cVLVIDEOURL;
    data['CVL_DESC'] = this.cVLDESC;
    data['CCFV_ID'] = this.cCFVID;
    data['CCFV_TT'] = this.cCFVTT;
    data['CCFV_NAME'] = this.cCFVNAME;
    data['CCFV_STATUS'] = this.cCFVSTATUS;
    data['CCFV_COMMISION'] = this.cCFVCOMMISION;
    data['CCFV_COURSE_IMAGE'] = this.cCFVCOURSEIMAGE;
    data['CCFV_TOTAL_LESSONS'] = this.cCFVTOTALLESSONS;
    data['CCFV_URL'] = this.cCFVURL;
    data['CCFV_DESC'] = this.cCFVDESC;
    data['CCFV_CMC_ID'] = this.cCFVCMCID;
    return data;
  }
}
