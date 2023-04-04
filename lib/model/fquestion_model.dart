
import 'dart:convert';

FquestionModel fquestionModelFromJson(String str) => FquestionModel.fromJson(json.decode(str));

String fquestionModelToJson(FquestionModel data) => json.encode(data.toJson());

class FquestionModel {
  FquestionModel({
     this.status,
     this.message,
     this.fquestion,
  });

  int? status;
  String? message;
  List<Fquestion>? fquestion;

  factory FquestionModel.fromJson(Map<String, dynamic> json) => FquestionModel(
    status: json["status"],
    message: json["message"],
    fquestion: List<Fquestion>.from(json["fquestion"].map((x) => Fquestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "fquestion": fquestion != null ?  List<dynamic>.from(fquestion!.map((x) => x.toJson())) : [],
  };
}

class Fquestion {
  Fquestion({
     this.fquestionId,
     this.fquestion,
     this.fanswer,
     this.fstatus,
     this.fquestionType,
  });

  String? fquestionId;
  String? fquestion;
  String? fanswer;
  String? fstatus;
  String? fquestionType;

  factory Fquestion.fromJson(Map<String, dynamic> json) => Fquestion(
    fquestionId: json["FQUESTION_ID"],
    fquestion: json["FQUESTION"],
    fanswer: json["FANSWER"],
    fstatus: json["FSTATUS"],
    fquestionType: json["FQUESTION_TYPE"],
  );

  Map<String, dynamic> toJson() => {
    "FQUESTION_ID": fquestionId,

    "FQUESTION": fquestion,
    "FANSWER": fanswer,
    "FSTATUS": fstatus,
    "FQUESTION_TYPE": fquestionType,
  };
}
