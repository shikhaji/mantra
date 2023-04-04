class GetLogoModel {
  int? status;
  String? message;
  LOGO? lOGO;

  GetLogoModel({this.status, this.message, this.lOGO});

  GetLogoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    lOGO = json['LOGO'] != null ? new LOGO.fromJson(json['LOGO']) : null;
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

class LOGO {
  String? sSID;
  String? sSTT;
  String? sSFAVICON;
  String? sSHEADERLOGO;
  String? sSFOOTERLOGO;
  String? sSHOMEBANNER1;
  String? sSHOMEBANNER2;
  String? pROJECTNAME;
  String? vERSIONNAME;
  String? wHATSNEW;
  String? sSAUTHOR;
  String? sSTITLE;
  String? sSDESC;
  String? sSKEYWORD;
  String? sSCODE;
  String? tHEMECOLOR;

  LOGO(
      {this.sSID,
        this.sSTT,
        this.sSFAVICON,
        this.sSHEADERLOGO,
        this.sSFOOTERLOGO,
        this.sSHOMEBANNER1,
        this.sSHOMEBANNER2,
        this.pROJECTNAME,
        this.vERSIONNAME,
        this.wHATSNEW,
        this.sSAUTHOR,
        this.sSTITLE,
        this.sSDESC,
        this.sSKEYWORD,
        this.sSCODE,
        this.tHEMECOLOR});

  LOGO.fromJson(Map<String, dynamic> json) {
    sSID = json['SS_ID'];
    sSTT = json['SS_TT'];
    sSFAVICON = json['SS_FAVICON'];
    sSHEADERLOGO = json['SS_HEADER_LOGO'];
    sSFOOTERLOGO = json['SS_FOOTER_LOGO'];
    sSHOMEBANNER1 = json['SS_HOME_BANNER1'];
    sSHOMEBANNER2 = json['SS_HOME_BANNER2'];
    pROJECTNAME = json['PROJECT_NAME'];
    vERSIONNAME = json['VERSION_NAME'];
    wHATSNEW = json['WHATS_NEW'];
    sSAUTHOR = json['SS_AUTHOR'];
    sSTITLE = json['SS_TITLE'];
    sSDESC = json['SS_DESC'];
    sSKEYWORD = json['SS_KEYWORD'];
    sSCODE = json['SS_CODE'];
    tHEMECOLOR = json['THEME_COLOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SS_ID'] = this.sSID;
    data['SS_TT'] = this.sSTT;
    data['SS_FAVICON'] = this.sSFAVICON;
    data['SS_HEADER_LOGO'] = this.sSHEADERLOGO;
    data['SS_FOOTER_LOGO'] = this.sSFOOTERLOGO;
    data['SS_HOME_BANNER1'] = this.sSHOMEBANNER1;
    data['SS_HOME_BANNER2'] = this.sSHOMEBANNER2;
    data['PROJECT_NAME'] = this.pROJECTNAME;
    data['VERSION_NAME'] = this.vERSIONNAME;
    data['WHATS_NEW'] = this.wHATSNEW;
    data['SS_AUTHOR'] = this.sSAUTHOR;
    data['SS_TITLE'] = this.sSTITLE;
    data['SS_DESC'] = this.sSDESC;
    data['SS_KEYWORD'] = this.sSKEYWORD;
    data['SS_CODE'] = this.sSCODE;
    data['THEME_COLOR'] = this.tHEMECOLOR;
    return data;
  }
}
