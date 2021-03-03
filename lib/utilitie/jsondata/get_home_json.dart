class Get_home_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Get_home_json({this.message, this.codenum, this.status, this.result});

  Get_home_json.fromJson(Map<String, dynamic> json) {
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
  int totalProduct;
  String totalViews;
  String datePackege;
  String totalPoints;
  String totalSelling;
  String totalOrders;
  String serviceCoupon;
  int type;

  Result(
      {this.totalProduct,
        this.totalViews,
        this.datePackege,
        this.totalPoints,
        this.totalSelling,
        this.totalOrders,
        this.serviceCoupon,
        this.type});

  Result.fromJson(Map<String, dynamic> json) {
    totalProduct = json['total_product'];
    totalViews = json['total_views'];
    datePackege = json['date_packege'];
    totalPoints = json['total_points'];
    totalSelling = json['total_selling'];
    totalOrders = json['total_orders'];
    serviceCoupon = json['service_coupon'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_product'] = this.totalProduct;
    data['total_views'] = this.totalViews;
    data['date_packege'] = this.datePackege;
    data['total_points'] = this.totalPoints;
    data['total_selling'] = this.totalSelling;
    data['total_orders'] = this.totalOrders;
    data['service_coupon'] = this.serviceCoupon;
    data['type'] = this.type;
    return data;
  }
}
