class Preparation_edit_branch_JSON {
  String message;
  int messageid;
  bool status;
  Result result;

  Preparation_edit_branch_JSON(
      {this.message, this.messageid, this.status, this.result});

  Preparation_edit_branch_JSON.fromJson(Map<String, dynamic> json) {
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
  AllProducts allProducts;

  Result({this.allProducts});

  Result.fromJson(Map<String, dynamic> json) {
    allProducts = json['all_products'] != null
        ? new AllProducts.fromJson(json['all_products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allProducts != null) {
      data['all_products'] = this.allProducts.toJson();
    }
    return data;
  }
}

class AllProducts {
  String productImage;
  String brancheName;
  String brancheNameEn;
  String phone;
  String phoneSecond;
  String views;
  String view;
  String phoneThird;
  int prodId;
  String lat;
  String lag;
  String descriptionEn;
  String description;
  String whatsapp;
  String address;
  String addressEn;
  String location;

  AllProducts(
      {this.productImage,
        this.brancheName,
        this.brancheNameEn,
        this.phone,
        this.phoneSecond,
        this.views,
        this.view,
        this.phoneThird,
        this.prodId,
        this.lat,
        this.lag,
        this.descriptionEn,
        this.description,
        this.whatsapp,
        this.address,
        this.addressEn,
        this.location});

  AllProducts.fromJson(Map<String, dynamic> json) {
    productImage = json['product_image'];
    brancheName = json['branche_name'];
    brancheNameEn = json['branche_name_en'];
    phone = json['phone'];
    phoneSecond = json['phone_second'];
    views = json['views'];
    view = json['view'];
    phoneThird = json['phone_third'];
    prodId = json['prod_id'];
    lat = json['lat'];
    lag = json['lag'];
    descriptionEn = json['description_en'];
    description = json['description'];
    whatsapp = json['whatsapp'];
    address = json['address'];
    addressEn = json['address_en'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image'] = this.productImage;
    data['branche_name'] = this.brancheName;
    data['branche_name_en'] = this.brancheNameEn;
    data['phone'] = this.phone;
    data['phone_second'] = this.phoneSecond;
    data['views'] = this.views;
    data['view'] = this.view;
    data['phone_third'] = this.phoneThird;
    data['prod_id'] = this.prodId;
    data['lat'] = this.lat;
    data['lag'] = this.lag;
    data['description_en'] = this.descriptionEn;
    data['description'] = this.description;
    data['whatsapp'] = this.whatsapp;
    data['address'] = this.address;
    data['address_en'] = this.addressEn;
    data['location'] = this.location;
    return data;
  }
}
