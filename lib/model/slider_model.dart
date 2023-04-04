// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    required this.status,
    required this.message,
    required this.detail,
  });

  int status;
  String message;
  List<Detail> detail;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    status: json["status"],
    message: json["message"],
    detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    required this.bannerId,
    required this.bannerTt,
    required this.bannerImage,
  });

  String bannerId;
  DateTime bannerTt;
  String bannerImage;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    bannerId: json["BANNER_ID"],
    bannerTt: DateTime.parse(json["BANNER_TT"]),
    bannerImage: json["BANNER_IMAGE"],
  );

  Map<String, dynamic> toJson() => {
    "BANNER_ID": bannerId,
    "BANNER_TT": bannerTt.toIso8601String(),
    "BANNER_IMAGE": bannerImage,
  };
}
