class GetPaymentModel {
  int? status;
  String? message;
  PaymentDetails? lOGO;

  GetPaymentModel({this.status, this.message, this.lOGO});

  GetPaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    lOGO = json['LOGO'] != null ? new PaymentDetails.fromJson(json['LOGO']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.lOGO != null) {
      data['LOGO'] = this.lOGO!.toJson();
    }
    return data;
  }
}

class PaymentDetails {
  String? pROFILEID;
  String? pROFILETT;
  String? oRGNAME;
  String? oRGEMAIL;
  String? oRGALTEMAIL;
  String? oRGPHONE;
  String? oRGALTPHONE;
  String? oRGADDRESS;
  String? kEYID;
  String? kEYSECRET;
  String? aPPURL;
  String? sINGLENOTICE;
  String? oRGABOUT;
  String? oRGPRIVACYPOLICY;
  String? oRGTERMSCONDITIONSHORTDESC;
  String? oRGTERMSCONDITIONS2;
  String? rEFERALAMOUNT;
  String? pROFILEADMINCOMMISION;
  String? pROFILESUBADMINCOMMISION;
  String? pROFILECENTERCOMMISION;
  String? pROFILECENTERREGISTRATIONFEE;
  String? dASHBOARDNOTIFICATION;
  String? aPPTHEMECOLOR;

  PaymentDetails(
      {this.pROFILEID,
        this.pROFILETT,
        this.oRGNAME,
        this.oRGEMAIL,
        this.oRGALTEMAIL,
        this.oRGPHONE,
        this.oRGALTPHONE,
        this.oRGADDRESS,
        this.kEYID,
        this.kEYSECRET,
        this.aPPURL,
        this.sINGLENOTICE,
        this.oRGABOUT,
        this.oRGPRIVACYPOLICY,
        this.oRGTERMSCONDITIONSHORTDESC,
        this.oRGTERMSCONDITIONS2,
        this.rEFERALAMOUNT,
        this.pROFILEADMINCOMMISION,
        this.pROFILESUBADMINCOMMISION,
        this.pROFILECENTERCOMMISION,
        this.pROFILECENTERREGISTRATIONFEE,
        this.dASHBOARDNOTIFICATION,
        this.aPPTHEMECOLOR});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    pROFILEID = json['PROFILE_ID'];
    pROFILETT = json['PROFILE_TT'];
    oRGNAME = json['ORG_NAME'];
    oRGEMAIL = json['ORG_EMAIL'];
    oRGALTEMAIL = json['ORG_ALT_EMAIL'];
    oRGPHONE = json['ORG_PHONE'];
    oRGALTPHONE = json['ORG_ALT_PHONE'];
    oRGADDRESS = json['ORG_ADDRESS'];
    kEYID = json['KEY_ID'];
    kEYSECRET = json['KEY_SECRET'];
    aPPURL = json['APP_URL'];
    sINGLENOTICE = json['SINGLE_NOTICE'];
    oRGABOUT = json['ORG_ABOUT'];
    oRGPRIVACYPOLICY = json['ORG_PRIVACY_POLICY'];
    oRGTERMSCONDITIONSHORTDESC = json['ORG_TERMS_CONDITION_SHORT_DESC'];
    oRGTERMSCONDITIONS2 = json['ORG_TERMS_CONDITIONS_2'];
    rEFERALAMOUNT = json['REFERAL_AMOUNT'];
    pROFILEADMINCOMMISION = json['PROFILE_ADMIN_COMMISION'];
    pROFILESUBADMINCOMMISION = json['PROFILE_SUB_ADMIN_COMMISION'];
    pROFILECENTERCOMMISION = json['PROFILE_CENTER_COMMISION'];
    pROFILECENTERREGISTRATIONFEE = json['PROFILE_CENTER_REGISTRATION_FEE'];
    dASHBOARDNOTIFICATION = json['DASHBOARD_NOTIFICATION'];
    aPPTHEMECOLOR = json['APP_THEME_COLOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PROFILE_ID'] = this.pROFILEID;
    data['PROFILE_TT'] = this.pROFILETT;
    data['ORG_NAME'] = this.oRGNAME;
    data['ORG_EMAIL'] = this.oRGEMAIL;
    data['ORG_ALT_EMAIL'] = this.oRGALTEMAIL;
    data['ORG_PHONE'] = this.oRGPHONE;
    data['ORG_ALT_PHONE'] = this.oRGALTPHONE;
    data['ORG_ADDRESS'] = this.oRGADDRESS;
    data['KEY_ID'] = this.kEYID;
    data['KEY_SECRET'] = this.kEYSECRET;
    data['APP_URL'] = this.aPPURL;
    data['SINGLE_NOTICE'] = this.sINGLENOTICE;
    data['ORG_ABOUT'] = this.oRGABOUT;
    data['ORG_PRIVACY_POLICY'] = this.oRGPRIVACYPOLICY;
    data['ORG_TERMS_CONDITION_SHORT_DESC'] = this.oRGTERMSCONDITIONSHORTDESC;
    data['ORG_TERMS_CONDITIONS_2'] = this.oRGTERMSCONDITIONS2;
    data['REFERAL_AMOUNT'] = this.rEFERALAMOUNT;
    data['PROFILE_ADMIN_COMMISION'] = this.pROFILEADMINCOMMISION;
    data['PROFILE_SUB_ADMIN_COMMISION'] = this.pROFILESUBADMINCOMMISION;
    data['PROFILE_CENTER_COMMISION'] = this.pROFILECENTERCOMMISION;
    data['PROFILE_CENTER_REGISTRATION_FEE'] = this.pROFILECENTERREGISTRATIONFEE;
    data['DASHBOARD_NOTIFICATION'] = this.dASHBOARDNOTIFICATION;
    data['APP_THEME_COLOR'] = this.aPPTHEMECOLOR;
    return data;
  }
}
