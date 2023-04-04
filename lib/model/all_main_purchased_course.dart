class GetAllMainPurchasedCourse {
  int? status;
  String? message;
  List<PurchasedCourse>? course;

  GetAllMainPurchasedCourse({this.status, this.message, this.course});

  GetAllMainPurchasedCourse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['course'] != null) {
      course = <PurchasedCourse>[];
      json['course'].forEach((v) {
        course!.add(new PurchasedCourse.fromJson(v));
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

class PurchasedCourse {
  String? pCLID;
  String? pCLTT;
  String? pCLCLID;
  String? pLCTRANSACTIONID;
  String? pLCPAYMENTDATE;
  String? pLCPAYMENTSTATUS;
  String? pLCLOGINID;
  String? pCLCENTERCOMISSION;
  String? pCLADMINCOMMISION;
  String? cMCID;
  String? cMCTT;
  String? cMCNAME;
  String? cMCSTATUS;
  String? cMCCOMMISION;
  String? cMCIMAGE;
  String? cMCCHAPTERS;
  String? cMCINTROURL;
  String? cMCDESC;

  PurchasedCourse(
      {this.pCLID,
        this.pCLTT,
        this.pCLCLID,
        this.pLCTRANSACTIONID,
        this.pLCPAYMENTDATE,
        this.pLCPAYMENTSTATUS,
        this.pLCLOGINID,
        this.pCLCENTERCOMISSION,
        this.pCLADMINCOMMISION,
        this.cMCID,
        this.cMCTT,
        this.cMCNAME,
        this.cMCSTATUS,
        this.cMCCOMMISION,
        this.cMCIMAGE,
        this.cMCCHAPTERS,
        this.cMCINTROURL,
        this.cMCDESC});

  PurchasedCourse.fromJson(Map<String, dynamic> json) {
    pCLID = json['PCL_ID'];
    pCLTT = json['PCL_TT'];
    pCLCLID = json['PCL_CL_ID'];
    pLCTRANSACTIONID = json['PLC_TRANSACTION_ID'];
    pLCPAYMENTDATE = json['PLC_PAYMENT_DATE'];
    pLCPAYMENTSTATUS = json['PLC_PAYMENT_STATUS'];
    pLCLOGINID = json['PLC_LOGIN_ID'];
    pCLCENTERCOMISSION = json['PCL_CENTER_COMISSION'];
    pCLADMINCOMMISION = json['PCL_ADMIN_COMMISION'];
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
    data['PCL_ID'] = this.pCLID;
    data['PCL_TT'] = this.pCLTT;
    data['PCL_CL_ID'] = this.pCLCLID;
    data['PLC_TRANSACTION_ID'] = this.pLCTRANSACTIONID;
    data['PLC_PAYMENT_DATE'] = this.pLCPAYMENTDATE;
    data['PLC_PAYMENT_STATUS'] = this.pLCPAYMENTSTATUS;
    data['PLC_LOGIN_ID'] = this.pLCLOGINID;
    data['PCL_CENTER_COMISSION'] = this.pCLCENTERCOMISSION;
    data['PCL_ADMIN_COMMISION'] = this.pCLADMINCOMMISION;
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
