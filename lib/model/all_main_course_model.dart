class GetAllMainCourse {
  int? status;
  String? message;
  List<MainCourse>? course;

  GetAllMainCourse({this.status, this.message, this.course});

  GetAllMainCourse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['course'] != null) {
      course = <MainCourse>[];
      json['course'].forEach((v) {
        course!.add(new MainCourse.fromJson(v));
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

class MainCourse {
  String? cMCID;
  String? cMCTT;
  String? cMCNAME;
  String? cMCSTATUS;
  String? cMCCOMMISION;
  String? cMCIMAGE;
  String? cMCCHAPTERS;
  String? cMCINTROURL;
  String? cMCDESC;

  MainCourse(
      {this.cMCID,
        this.cMCTT,
        this.cMCNAME,
        this.cMCSTATUS,
        this.cMCCOMMISION,
        this.cMCIMAGE,
        this.cMCCHAPTERS,
        this.cMCINTROURL,
        this.cMCDESC});

  MainCourse.fromJson(Map<String, dynamic> json) {
    cMCID = json['CMC_ID'];
    cMCTT = json['CMC_TT'];
    cMCNAME = json['CMC_NAME'];
    cMCSTATUS = json['CMC_STATUS'];
    cMCCOMMISION = json['CMC_COMMISION'];
    cMCIMAGE = json['CMC_IMAGE'];
    cMCCHAPTERS = json['CMC_CHAPTERS'];
    cMCINTROURL = json['CMC_INTRO_URL'];
    cMCDESC = json['CMC_DESC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CMC_ID'] = this.cMCID;
    data['CMC_TT'] = this.cMCTT;
    data['CMC_NAME'] = this.cMCNAME;
    data['CMC_STATUS'] = this.cMCSTATUS;
    data['CMC_COMMISION'] = this.cMCCOMMISION;
    data['CMC_IMAGE'] = this.cMCIMAGE;
    data['CMC_CHAPTERS'] = this.cMCCHAPTERS;
    data['CMC_INTRO_URL'] = this.cMCINTROURL;
    data['CMC_DESC'] = this.cMCDESC;
    return data;
  }
}
