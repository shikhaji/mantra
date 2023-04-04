class QuizDetails {
  int? status;
  String? message;
  List<CONTEST>? cONTEST;

  QuizDetails({this.status, this.message, this.cONTEST});

  QuizDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['CONTEST'] != null) {
      cONTEST = <CONTEST>[];
      json['CONTEST'].forEach((v) {
        cONTEST!.add(new CONTEST.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cONTEST != null) {
      data['CONTEST'] = this.cONTEST!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CONTEST {
  String? cONTESTID;
  String? cONTESTTT;
  String? cONTESTSTARTDATE;
  String? cONTESTTIME;
  String? cONTESTENTRYFEE;
  String? wINNINGPOOL;
  String? tOTALPARTICIPANTS;
  String? wIN;
  String? cONTESTSTATUS;
  String? cONTESTTEMPID;
  String? cONTESTSUBJECTID;
  String? cONTESTRULE;
  String? cONTESTRANKSTATUS;
  String? cONTESTSPOTSLEFT;
  String? cONTESTFIRSTPRICE;
  String? tOTALQUESTIONS;
  String? cLOSEBEFORE;
  String? cONTESTLASTRANK;
  String? cONTESTDATETIME;
  String? cONTESTPERQUESTIONTIMING;
  String? cLBUFFERTIME;
  String? cONTESTSHOWHIDE;
  String? cONTESTPUBLISHAFTER;
  String? cONTESTRESULTSTATUS;
  String? lOGINID;
  String? cONTESTTOTALTIME;
  String? cONTESTPASSINGMARKS;
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

  CONTEST(
      {this.cONTESTID,
        this.cONTESTTT,
        this.cONTESTSTARTDATE,
        this.cONTESTTIME,
        this.cONTESTENTRYFEE,
        this.wINNINGPOOL,
        this.tOTALPARTICIPANTS,
        this.wIN,
        this.cONTESTSTATUS,
        this.cONTESTTEMPID,
        this.cONTESTSUBJECTID,
        this.cONTESTRULE,
        this.cONTESTRANKSTATUS,
        this.cONTESTSPOTSLEFT,
        this.cONTESTFIRSTPRICE,
        this.tOTALQUESTIONS,
        this.cLOSEBEFORE,
        this.cONTESTLASTRANK,
        this.cONTESTDATETIME,
        this.cONTESTPERQUESTIONTIMING,
        this.cLBUFFERTIME,
        this.cONTESTSHOWHIDE,
        this.cONTESTPUBLISHAFTER,
        this.cONTESTRESULTSTATUS,
        this.lOGINID,
        this.cONTESTTOTALTIME,
        this.cONTESTPASSINGMARKS,
        this.cVLTT,
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

  CONTEST.fromJson(Map<String, dynamic> json) {
    cONTESTID = json['CONTEST_ID'];
    cONTESTTT = json['CONTEST_TT'];
    cONTESTSTARTDATE = json['CONTEST_START_DATE'];
    cONTESTTIME = json['CONTEST_TIME'];
    cONTESTENTRYFEE = json['CONTEST_ENTRY_FEE'];
    wINNINGPOOL = json['WINNING_POOL'];
    tOTALPARTICIPANTS = json['TOTAL_PARTICIPANTS'];
    wIN = json['WIN'];
    cONTESTSTATUS = json['CONTEST_STATUS'];
    cONTESTTEMPID = json['CONTEST_TEMP_ID'];
    cONTESTSUBJECTID = json['CONTEST_SUBJECT_ID'];
    cONTESTRULE = json['CONTEST_RULE'];
    cONTESTRANKSTATUS = json['CONTEST_RANK_STATUS'];
    cONTESTSPOTSLEFT = json['CONTEST_SPOTS_LEFT'];
    cONTESTFIRSTPRICE = json['CONTEST_FIRST_PRICE'];
    tOTALQUESTIONS = json['TOTAL_QUESTIONS'];
    cLOSEBEFORE = json['CLOSE_BEFORE'];
    cONTESTLASTRANK = json['CONTEST_LAST_RANK'];
    cONTESTDATETIME = json['CONTEST_DATE_TIME'];
    cONTESTPERQUESTIONTIMING = json['CONTEST_PER_QUESTION_TIMING'];
    cLBUFFERTIME = json['CL_BUFFER_TIME'];
    cONTESTSHOWHIDE = json['CONTEST_SHOW_HIDE'];
    cONTESTPUBLISHAFTER = json['CONTEST_PUBLISH_AFTER'];
    cONTESTRESULTSTATUS = json['CONTEST_RESULT_STATUS'];
    lOGINID = json['LOGIN_ID'];
    cONTESTTOTALTIME = json['CONTEST_TOTAL_TIME'];
    cONTESTPASSINGMARKS = json['CONTEST_PASSING_MARKS'];
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
    data['CONTEST_ID'] = this.cONTESTID;
    data['CONTEST_TT'] = this.cONTESTTT;
    data['CONTEST_START_DATE'] = this.cONTESTSTARTDATE;
    data['CONTEST_TIME'] = this.cONTESTTIME;
    data['CONTEST_ENTRY_FEE'] = this.cONTESTENTRYFEE;
    data['WINNING_POOL'] = this.wINNINGPOOL;
    data['TOTAL_PARTICIPANTS'] = this.tOTALPARTICIPANTS;
    data['WIN'] = this.wIN;
    data['CONTEST_STATUS'] = this.cONTESTSTATUS;
    data['CONTEST_TEMP_ID'] = this.cONTESTTEMPID;
    data['CONTEST_SUBJECT_ID'] = this.cONTESTSUBJECTID;
    data['CONTEST_RULE'] = this.cONTESTRULE;
    data['CONTEST_RANK_STATUS'] = this.cONTESTRANKSTATUS;
    data['CONTEST_SPOTS_LEFT'] = this.cONTESTSPOTSLEFT;
    data['CONTEST_FIRST_PRICE'] = this.cONTESTFIRSTPRICE;
    data['TOTAL_QUESTIONS'] = this.tOTALQUESTIONS;
    data['CLOSE_BEFORE'] = this.cLOSEBEFORE;
    data['CONTEST_LAST_RANK'] = this.cONTESTLASTRANK;
    data['CONTEST_DATE_TIME'] = this.cONTESTDATETIME;
    data['CONTEST_PER_QUESTION_TIMING'] = this.cONTESTPERQUESTIONTIMING;
    data['CL_BUFFER_TIME'] = this.cLBUFFERTIME;
    data['CONTEST_SHOW_HIDE'] = this.cONTESTSHOWHIDE;
    data['CONTEST_PUBLISH_AFTER'] = this.cONTESTPUBLISHAFTER;
    data['CONTEST_RESULT_STATUS'] = this.cONTESTRESULTSTATUS;
    data['LOGIN_ID'] = this.lOGINID;
    data['CONTEST_TOTAL_TIME'] = this.cONTESTTOTALTIME;
    data['CONTEST_PASSING_MARKS'] = this.cONTESTPASSINGMARKS;
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
