class Get_all_order_json {
  String message;
  int messageid;
  bool status;
  int total;
  Result result;

  Get_all_order_json(
      {this.message, this.messageid, this.status, this.total, this.result});

  Get_all_order_json.fromJson(Map<String, dynamic> json) {
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
  List<AllOrders> allOrders;

  Result({this.allOrders});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_orders'] != null) {
      allOrders = new List<AllOrders>();
      json['all_orders'].forEach((v) {
        allOrders.add(new AllOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allOrders != null) {
      data['all_orders'] = this.allOrders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllOrders {
  String userName;
  String totalCountVisit;
  String userPhone;
  String orderId;

  AllOrders(
      {this.userName, this.totalCountVisit, this.userPhone, this.orderId});

  AllOrders.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    totalCountVisit = json['total_count_visit'];
    userPhone = json['user_phone'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['total_count_visit'] = this.totalCountVisit;
    data['user_phone'] = this.userPhone;
    data['order_id'] = this.orderId;
    return data;
  }
}
