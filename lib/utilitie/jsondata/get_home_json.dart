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
  String servicesTypeName;
  int totalProduct;
  String totalViews;
  String fromHrs;
  String toHrs;
  String startDate;
  String endDate;
  int keyUpdate;
  String totalPoints;
  String totalSelling;
  String totalOrders;
  String serviceCoupon;
  int type;

  Result(
      {this.servicesTypeName,
        this.totalProduct,
        this.totalViews,
        this.fromHrs,
        this.toHrs,
        this.startDate,
        this.endDate,
        this.keyUpdate,
        this.totalPoints,
        this.totalSelling,
        this.totalOrders,
        this.serviceCoupon,
        this.type});

  Result.fromJson(Map<String, dynamic> json) {
    servicesTypeName = json['services_type_name'];
    totalProduct = json['total_product'];
    totalViews = json['total_views'];
    fromHrs = json['from_hrs'];
    toHrs = json['to_hrs'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    keyUpdate = json['key_update'];
    totalPoints = json['total_points'];
    totalSelling = json['total_selling'];
    totalOrders = json['total_orders'];
    serviceCoupon = json['service_coupon'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services_type_name'] = this.servicesTypeName;
    data['total_product'] = this.totalProduct;
    data['total_views'] = this.totalViews;
    data['from_hrs'] = this.fromHrs;
    data['to_hrs'] = this.toHrs;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['key_update'] = this.keyUpdate;
    data['total_points'] = this.totalPoints;
    data['total_selling'] = this.totalSelling;
    data['total_orders'] = this.totalOrders;
    data['service_coupon'] = this.serviceCoupon;
    data['type'] = this.type;
    return data;
  }
}
