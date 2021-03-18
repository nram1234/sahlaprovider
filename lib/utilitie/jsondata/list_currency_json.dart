class List_currency_json {
  String message;
  int errNum;
  bool status;
  Result result;

  List_currency_json({this.message, this.errNum, this.status, this.result});

  List_currency_json.fromJson(Map<String, dynamic> json) {
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
  List<ListCurrency> listCurrency;

  Result({this.listCurrency});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['list_currency'] != null) {
      listCurrency = new List<ListCurrency>();
      json['list_currency'].forEach((v) {
        listCurrency.add(new ListCurrency.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listCurrency != null) {
      data['list_currency'] = this.listCurrency.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListCurrency {
  String currencyName;
  String idWeddingService;

  ListCurrency({this.currencyName, this.idWeddingService});

  ListCurrency.fromJson(Map<String, dynamic> json) {
    currencyName = json['currency_name'];
    idWeddingService = json['id_wedding_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_name'] = this.currencyName;
    data['id_wedding_service'] = this.idWeddingService;
    return data;
  }
}
