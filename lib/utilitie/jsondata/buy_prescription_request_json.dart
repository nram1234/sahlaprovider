class Buy_prescription_request_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Buy_prescription_request_json(
      {this.message, this.codenum, this.status, this.result});

  Buy_prescription_request_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    codenum = json['codenum'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['codenum'] = this.codenum;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<AllRequested> allRequested;

  Result({this.allRequested});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_requested'] != null) {
      allRequested = new List<AllRequested>();
      json['all_requested'].forEach((v) {
        allRequested.add(new AllRequested.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allRequested != null) {
      data['all_requested'] = this.allRequested.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllRequested {
  String pharmacyImage;
  String creationDate;
  String id;
  String idUser;
  String userPhone;
  String userName;
  String description;
  String descriptionDec;
  String currentPrice;
  String view;

  AllRequested(
      {this.pharmacyImage,
        this.creationDate,
        this.id,
        this.idUser,
        this.userPhone,
        this.userName,
        this.description,
        this.descriptionDec,
        this.currentPrice,
        this.view});

  AllRequested.fromJson(Map<String, dynamic> json) {
    pharmacyImage = json['pharmacy_image'];
    creationDate = json['creation_date'];
    id = json['id'];
    idUser = json['id_user'];
    userPhone = json['user_phone'];
    userName = json['user_name'];
    description = json['description'];
    descriptionDec = json['description_dec'];
    currentPrice = json['current_price'];
    view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pharmacy_image'] = this.pharmacyImage;
    data['creation_date'] = this.creationDate;
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['user_phone'] = this.userPhone;
    data['user_name'] = this.userName;
    data['description'] = this.description;
    data['description_dec'] = this.descriptionDec;
    data['current_price'] = this.currentPrice;
    data['view'] = this.view;
    return data;
  }
}
