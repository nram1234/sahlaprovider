class Preparation_wedding_service_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Preparation_wedding_service_json(
      {this.message, this.errNum, this.status, this.result});

  Preparation_wedding_service_json.fromJson(Map<String, dynamic> json) {
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
  List<AllCurrency> allCurrency;

  Result({this.allCurrency});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_currency'] != null) {
      allCurrency = new List<AllCurrency>();
      json['all_currency'].forEach((v) {
        allCurrency.add(new AllCurrency.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allCurrency != null) {
      data['all_currency'] = this.allCurrency.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCurrency {
  String currencyName;
  int currencyId;

  AllCurrency({this.currencyName, this.currencyId});

  AllCurrency.fromJson(Map<String, dynamic> json) {
    currencyName = json['currency_name'];
    currencyId = json['currency_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_name'] = this.currencyName;
    data['currency_id'] = this.currencyId;
    return data;
  }
}
