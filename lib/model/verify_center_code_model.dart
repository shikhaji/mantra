class CenterCodeModel {
  int? status;
  String? message;
  Center? center;

  CenterCodeModel({this.status, this.message, this.center});

  CenterCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    center =
    json['center'] != null ? new Center.fromJson(json['center']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.center != null) {
      data['center'] = this.center!.toJson();
    }
    return data;
  }
}

class Center {
  String? scid;
  String? centerCode;
  String? branchName;
  String? directorName;
  String? address;
  String? pics;
  String? mobile;
  String? regisdate;
  String? districtName;
  String? stateName;
  String? sUBADMINLOGINID;

  Center(
      {this.scid,
        this.centerCode,
        this.branchName,
        this.directorName,
        this.address,
        this.pics,
        this.mobile,
        this.regisdate,
        this.districtName,
        this.stateName,
        this.sUBADMINLOGINID});

  Center.fromJson(Map<String, dynamic> json) {
    scid = json['scid'];
    centerCode = json['center_code'];
    branchName = json['branch_name'];
    directorName = json['director_name'];
    address = json['address'];
    pics = json['pics'];
    mobile = json['mobile'];
    regisdate = json['Regisdate'];
    districtName = json['district_name'];
    stateName = json['state_name'];
    sUBADMINLOGINID = json['SUB_ADMIN_LOGIN_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scid'] = this.scid;
    data['center_code'] = this.centerCode;
    data['branch_name'] = this.branchName;
    data['director_name'] = this.directorName;
    data['address'] = this.address;
    data['pics'] = this.pics;
    data['mobile'] = this.mobile;
    data['Regisdate'] = this.regisdate;
    data['district_name'] = this.districtName;
    data['state_name'] = this.stateName;
    data['SUB_ADMIN_LOGIN_ID'] = this.sUBADMINLOGINID;
    return data;
  }
}