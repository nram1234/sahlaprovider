class Preparation_addproduct_json {
  String message;
  int messageid;
  bool status;
  int total;
  Result result;

  Preparation_addproduct_json(
      {this.message, this.messageid, this.status, this.total, this.result});

  Preparation_addproduct_json.fromJson(Map<String, dynamic> json) {
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
  List<CategoryList> categoryList;

  Result({this.serviceType, this.categoryList});

  Result.fromJson(Map<String, dynamic> json) {
    serviceType = json['service_type'];
    if (json['category_list'] != null) {
      categoryList = new List<CategoryList>();
      json['category_list'].forEach((v) {
        categoryList.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_type'] = this.serviceType;
    if (this.categoryList != null) {
      data['category_list'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String categoryName;
  String categoryId;

  CategoryList({this.categoryName, this.categoryId});

  CategoryList.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    return data;
  }
}
