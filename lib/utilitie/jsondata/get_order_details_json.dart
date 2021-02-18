class Get_order_details_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Get_order_details_json({this.message, this.errNum, this.status, this.result});

  Get_order_details_json.fromJson(Map<String, dynamic> json) {
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
  List<OrderDetails> orderDetails;
  List<AllProducts> allProducts;

  Result({this.orderDetails, this.allProducts});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
    if (json['all_products'] != null) {
      allProducts = new List<AllProducts>();
      json['all_products'].forEach((v) {
        allProducts.add(new AllProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    if (this.allProducts != null) {
      data['all_products'] = this.allProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int codeName;
  int idOrder;
  String totalPrice;
  String totalProduct;
  String shippingCharges;
  int totalPriceShippingCharges;
  String currencyName;
  String date;
  String viewStore;

  OrderDetails(
      {this.codeName,
        this.idOrder,
        this.totalPrice,
        this.totalProduct,
        this.shippingCharges,
        this.totalPriceShippingCharges,
        this.currencyName,
        this.date,
        this.viewStore});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    codeName = json['code_name'];
    idOrder = json['id_order'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
    shippingCharges = json['shipping_charges'];
    totalPriceShippingCharges = json['total_price_shipping_charges'];
    currencyName = json['currency_name'];
    date = json['date'];
    viewStore = json['view_store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_name'] = this.codeName;
    data['id_order'] = this.idOrder;
    data['total_price'] = this.totalPrice;
    data['total_product'] = this.totalProduct;
    data['shipping_charges'] = this.shippingCharges;
    data['total_price_shipping_charges'] = this.totalPriceShippingCharges;
    data['currency_name'] = this.currencyName;
    data['date'] = this.date;
    data['view_store'] = this.viewStore;
    return data;
  }
}

class AllProducts {
  int id;
  int idProduct;
  String productName;
  String price;
  int quantity;
  String currencyName;
  String image;

  AllProducts(
      {this.id,
        this.idProduct,
        this.productName,
        this.price,
        this.quantity,
        this.currencyName,
        this.image});

  AllProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduct = json['id_product'];
    productName = json['product_name'];
    price = json['price'];
    quantity = json['quantity'];
    currencyName = json['currency_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_product'] = this.idProduct;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['currency_name'] = this.currencyName;
    data['image'] = this.image;
    return data;
  }
}
