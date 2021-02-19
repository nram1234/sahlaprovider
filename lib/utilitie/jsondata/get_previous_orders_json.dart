class Get_previous_orders_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Get_previous_orders_json(
      {this.message, this.errNum, this.status, this.result});

  Get_previous_orders_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errNum = json['errNum'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['errNum'] = this.errNum;
    data['status'] = this.status;
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
  int codeName;
  int idOrder;
  String totalPrice;
  String totalProduct;
  String shippingCharges;
  String fullname;
  String address;
  String antherAddress;
  String cityName;
  String phone;
  String currencyName;
  String date;
  String viewStore;
  int viewId;

  AllOrders(
      {this.codeName,
        this.idOrder,
        this.totalPrice,
        this.totalProduct,
        this.shippingCharges,
        this.fullname,
        this.address,
        this.antherAddress,
        this.cityName,
        this.phone,
        this.currencyName,
        this.date,
        this.viewStore,
        this.viewId});

  AllOrders.fromJson(Map<String, dynamic> json) {
    codeName = json['code_name'];
    idOrder = json['id_order'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
    shippingCharges = json['shipping_charges'];
    fullname = json['fullname'];
    address = json['address'];
    antherAddress = json['anther_address'];
    cityName = json['city_name'];
    phone = json['phone'];
    currencyName = json['currency_name'];
    date = json['date'];
    viewStore = json['view_store'];
    viewId = json['view_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_name'] = this.codeName;
    data['id_order'] = this.idOrder;
    data['total_price'] = this.totalPrice;
    data['total_product'] = this.totalProduct;
    data['shipping_charges'] = this.shippingCharges;
    data['fullname'] = this.fullname;
    data['address'] = this.address;
    data['anther_address'] = this.antherAddress;
    data['city_name'] = this.cityName;
    data['phone'] = this.phone;
    data['currency_name'] = this.currencyName;
    data['date'] = this.date;
    data['view_store'] = this.viewStore;
    data['view_id'] = this.viewId;
    return data;
  }
}
