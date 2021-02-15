class Get_all_visitor_json {
  String message;
  int messageid;
  bool status;
  int total;
  Result result;

  Get_all_visitor_json(
      {this.message, this.messageid, this.status, this.total, this.result});

  Get_all_visitor_json.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    messageid = json['Messageid'];
    status = json['status'];
    total = json['total'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Messageid'] = this.messageid;
    data['status'] = this.status;
    data['total'] = this.total;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<AllVisitoe> allVisitoe;

  Result({this.allVisitoe});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_visitoe'] != null) {
      allVisitoe = new List<AllVisitoe>();
      json['all_visitoe'].forEach((v) {
        allVisitoe.add(new AllVisitoe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allVisitoe != null) {
      data['all_visitoe'] = this.allVisitoe.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllVisitoe {
  String userName;
  String totalCountVisit;
  String userPhone;
  String visitorId;

  AllVisitoe(
      {this.userName, this.totalCountVisit, this.userPhone, this.visitorId});

  AllVisitoe.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    totalCountVisit = json['total_count_visit'];
    userPhone = json['user_phone'];
    visitorId = json['visitor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['total_count_visit'] = this.totalCountVisit;
    data['user_phone'] = this.userPhone;
    data['visitor_id'] = this.visitorId;
    return data;
  }
}
