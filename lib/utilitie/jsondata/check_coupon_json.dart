class Check_coupon_json {
  String message;
  int codenum;
  bool status;
  Data data;

  Check_coupon_json({this.message, this.codenum, this.status, this.data});

  Check_coupon_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    codenum = json['codenum'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['codenum'] = this.codenum;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String userName;
  String userPhone;

  Data({this.userName, this.userPhone});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userPhone = json['user_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    return data;
  }
}
