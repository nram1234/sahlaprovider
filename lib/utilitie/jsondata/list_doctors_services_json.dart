class List_doctors_services_json {
  String message;
  int errNum;
  bool status;
  Result result;

  List_doctors_services_json(
      {this.message, this.errNum, this.status, this.result});

  List_doctors_services_json.fromJson(Map<String, dynamic> json) {
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
  List<ListDoctorsServices> listDoctorsServices;

  Result({this.listDoctorsServices});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['list_doctors_services'] != null) {
      listDoctorsServices = new List<ListDoctorsServices>();
      json['list_doctors_services'].forEach((v) {
        listDoctorsServices.add(new ListDoctorsServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listDoctorsServices != null) {
      data['list_doctors_services'] =
          this.listDoctorsServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListDoctorsServices {
  String servicesName;
  String servicesNameEn;
  String price;
  String currencyName;
  String idWeddingService;

  ListDoctorsServices(
      {this.servicesName,
        this.servicesNameEn,
        this.price,
        this.currencyName,
        this.idWeddingService});

  ListDoctorsServices.fromJson(Map<String, dynamic> json) {
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
