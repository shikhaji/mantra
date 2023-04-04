class CheckCourseModel {
  int? status;
  String? message;
  List<CheckCourse>? course;

  CheckCourseModel({this.status, this.message, this.course});

  CheckCourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['course'] != null) {
      course = <CheckCourse>[];
      json['course'].forEach((v) {
        course!.add(new CheckCourse.fromJson(v));
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

class CheckCourse {
  String? cOUNT;

  CheckCourse({this.cOUNT});

  CheckCourse.fromJson(Map<String, dynamic> json) {
    cOUNT = json['COUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COUNT'] = this.cOUNT;
    return data;
  }
}
