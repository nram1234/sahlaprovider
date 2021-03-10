class Get_list_weddings_services_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Get_list_weddings_services_json(
      {this.message, this.errNum, this.status, this.result});

  Get_list_weddings_services_json.fromJson(Map<String, dynamic> json) {
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
  List<ListWeddingsServices> listWeddingsServices;

  Result({this.listWeddingsServices});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['list_weddings_services'] != null) {
      listWeddingsServices = new List<ListWeddingsServices>();
      json['list_weddings_services'].forEach((v) {
        listWeddingsServices.add(new ListWeddingsServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listWeddingsServices != null) {
      data['list_weddings_services'] =
          this.listWeddingsServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListWeddingsServices {
  String servicesName;
  String servicesNameEn;
  String price;
  String currencyName;
  String idWeddingService;

  ListWeddingsServices(
      {this.servicesName,
        this.servicesNameEn,
        this.price,
        this.currencyName,
        this.idWeddingService});

  ListWeddingsServices.fromJson(Map<String, dynamic> json) {
    servicesName = json['services_name'];
    servicesNameEn = json['services_name_en'];
    price = json['price'];
    currencyName = json['currency_name'];
    idWeddingService = json['id_wedding_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services_name'] = this.servicesName;
    data['services_name_en'] = this.servicesNameEn;
    data['price'] = this.price;
    data['currency_name'] = this.currencyName;
    data['id_wedding_service'] = this.idWeddingService;
    return data;
  }
}
