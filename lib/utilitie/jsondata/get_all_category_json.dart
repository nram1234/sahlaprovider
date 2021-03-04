class Get_all_category_json {
  String message;
  int messageid;
  bool status;
  int total;
  Result result;

  Get_all_category_json(
      {this.message, this.messageid, this.status, this.total, this.result});

  Get_all_category_json.fromJson(Map<String, dynamic> json) {
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
  String serviceType;
  List<AllProducts> allProducts;

  Result({this.serviceType, this.allProducts});

  Result.fromJson(Map<String, dynamic> json) {
    serviceType = json['service_type'];
    if (json['all_products'] != null) {
      allProducts = new List<AllProducts>();
      json['all_products'].forEach((v) {
        allProducts.add(new AllProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_type'] = this.serviceType;
    if (this.allProducts != null) {
      data['all_products'] = this.allProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllProducts {
  String productImage;
  String productName;
  String view;
  String productNameEn;
  String productId;

  AllProducts(
      {this.productImage,
        this.productName,
        this.view,
        this.productNameEn,
        this.productId});

  AllProducts.fromJson(Map<String, dynamic> json) {
    productImage = json['product_image'];
    productName = json['product_name'];
    view = json['view'];
    productNameEn = json['product_name_en'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image'] = this.productImage;
    data['product_name'] = this.productName;
    data['view'] = this.view;
    data['product_name_en'] = this.productNameEn;
    data['product_id'] = this.productId;
    return data;
  }
}
