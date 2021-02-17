class Preparation_edit_category_json {
  String message;
  int messageid;
  bool status;
  Result result;

  Preparation_edit_category_json(
      {this.message, this.messageid, this.status, this.result});

  Preparation_edit_category_json.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    messageid = json['Messageid'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Messageid'] = this.messageid;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<CategoryDetails> categoryDetails;

  Result({this.categoryDetails});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['category_details'] != null) {
      categoryDetails = new List<CategoryDetails>();
      json['category_details'].forEach((v) {
        categoryDetails.add(new CategoryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryDetails != null) {
      data['category_details'] =
          this.categoryDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetails {
  String productImage;
  String productName;
  String productNameEn;
  String productId;

  CategoryDetails(
      {this.productImage,
        this.productName,
        this.productNameEn,
        this.productId});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    productImage = json['product_image'];
    productName = json['product_name'];
    productNameEn = json['product_name_en'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image'] = this.productImage;
    data['product_name'] = this.productName;
    data['product_name_en'] = this.productNameEn;
    data['product_id'] = this.productId;
    return data;
  }
}
