class Get_offers_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Get_offers_json({this.message, this.codenum, this.status, this.result});

  Get_offers_json.fromJson(Map<String, dynamic> json) {
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
  List<AllOffers> allOffers;

  Result({this.allOffers});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_offers'] != null) {
      allOffers = new List<AllOffers>();
      json['all_offers'].forEach((v) {
        allOffers.add(new AllOffers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allOffers != null) {
      data['all_offers'] = this.allOffers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllOffers {
  String offersImage;
  String offersName;
  String offerNameEn;
  String expireDate;
  String startDate;
  String endDate;
  String description;
  String descriptionEn;
  String oldPrice;
  String newPrice;
  int offersId;

  AllOffers(
      {this.offersImage,
        this.offersName,
        this.offerNameEn,
        this.expireDate,
        this.startDate,
        this.endDate,
        this.description,
        this.descriptionEn,
        this.oldPrice,
        this.newPrice,
        this.offersId});

  AllOffers.fromJson(Map<String, dynamic> json) {
    offersImage = json['offers_image'];
    offersName = json['offers_name'];
    offerNameEn = json['offer_name_en'];
    expireDate = json['expire_date'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    descriptionEn = json['description_en'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    offersId = json['offers_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offers_image'] = this.offersImage;
    data['offers_name'] = this.offersName;
    data['offer_name_en'] = this.offerNameEn;
    data['expire_date'] = this.expireDate;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['description_en'] = this.descriptionEn;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['offers_id'] = this.offersId;
    return data;
  }
}
