class Preparation_edit_product_JSON {
  String message;
  int messageid;
  bool status;
  Result result;

  Preparation_edit_product_JSON(
      {this.message, this.messageid, this.status, this.result});

  Preparation_edit_product_JSON.fromJson(Map<String, dynamic> json) {
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
  List<AllProducts> allProducts;

  Result({this.allProducts});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_products'] != null) {
      allProducts = new List<AllProducts>();
      json['all_products'].forEach((v) {
        allProducts.add(new AllProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allProducts != null) {
      data['all_products'] = this.allProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllProducts {
  String productImage;
  String productName;
  String productNameEn;
  String productDescription;
  String productDescriptionEn;
  String productId;
  String newPrice;
  String oldPrice;

  String stock;
  String serial_number;



  AllProducts(
      {this.productImage,
        this.productName,    this.stock,

        this.serial_number,


        this.productNameEn,
        this.productDescription,
        this.productDescriptionEn,
        this.productId,
        this.newPrice,
        this.oldPrice});

  AllProducts.fromJson(Map<String, dynamic> json) {
    stock = json['stock'];
    serial_number = json['serial_number'];




    productImage = json['product_image'];
    productName = json['product_name'];
    productNameEn = json['product_name_en'];
    productDescription = json['product_description'];
    productDescriptionEn = json['product_description_en'];
    productId = json['product_id'];
    newPrice = json['new_price'];
    oldPrice = json['old_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['serial_number'] = this.serial_number;
    data['stock'] = this.stock;



    data['product_image'] = this.productImage;
    data['product_name'] = this.productName;
    data['product_name_en'] = this.productNameEn;
    data['product_description'] = this.productDescription;
    data['product_description_en'] = this.productDescriptionEn;
    data['product_id'] = this.productId;
    data['new_price'] = this.newPrice;
    data['old_price'] = this.oldPrice;
    return data;
  }
}
