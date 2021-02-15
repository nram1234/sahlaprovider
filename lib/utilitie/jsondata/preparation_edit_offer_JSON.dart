class Preparation_edit_offer_JSON {
  String message;
  int codenum;
  bool status;
  Result result;

  Preparation_edit_offer_JSON(
      {this.message, this.codenum, this.status, this.result});

  Preparation_edit_offer_JSON.fromJson(Map<String, dynamic> json) {
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
  List<OfferDetails> offerDetails;

  Result({this.offerDetails});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['offer_details'] != null) {
      offerDetails = new List<OfferDetails>();
      json['offer_details'].forEach((v) {
        offerDetails.add(new OfferDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offerDetails != null) {
      data['offer_details'] = this.offerDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferDetails {
  String offersImage;
  String oldPrice;
  String newPrice;
  String offersName;
  String offerNameEn;
  String endDate;
  String startDate;
  String offersDescription;
  String descriptionEn;
  int offersId;

  OfferDetails(
      {this.offersImage,
        this.oldPrice,
        this.newPrice,
        this.offersName,
        this.offerNameEn,
        this.endDate,
        this.startDate,
        this.offersDescription,
        this.descriptionEn,
        this.offersId});

  OfferDetails.fromJson(Map<String, dynamic> json) {
    offersImage = json['offers_image'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    offersName = json['offers_name'];
    offerNameEn = json['offer_name_en'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    offersDescription = json['offers_description'];
    descriptionEn = json['description_en'];
    offersId = json['offers_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offers_image'] = this.offersImage;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['offers_name'] = this.offersName;
    data['offer_name_en'] = this.offerNameEn;
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    data['offers_description'] = this.offersDescription;
    data['description_en'] = this.descriptionEn;
    data['offers_id'] = this.offersId;
    return data;
  }
}
