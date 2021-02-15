class Create_coupon_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Create_coupon_json({this.message, this.codenum, this.status, this.result});

  Create_coupon_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    codenum = json['codenum'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['codenum'] = this.codenum;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String usedCoupon;

  Result({this.usedCoupon});

  Result.fromJson(Map<String, dynamic> json) {
    usedCoupon = json['used_coupon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['used_coupon'] = this.usedCoupon;
    return data;
  }
}
