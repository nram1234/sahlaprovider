class Preparation_doc_profile_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Preparation_doc_profile_json(
      {this.message, this.codenum, this.status, this.result});

  Preparation_doc_profile_json.fromJson(Map<String, dynamic> json) {
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
  List<ServiceDetails> serviceDetails;

  Result({this.serviceDetails});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['service_details'] != null) {
      serviceDetails = new List<ServiceDetails>();
      json['service_details'].forEach((v) {
        serviceDetails.add(new ServiceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceDetails != null) {
      data['service_details'] =
          this.serviceDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceDetails {
  String detectionPrice;
  String detectionPriceEn;
  String waitingTime;
  String waitingTimeEn;
  String specializationEn;
  String specialization;
  String nameAr;
  String nameEn;
  String whatsapp;
  String facebook;
  String email;
  String website;
  String instagram;
  String twitter;
  String lat;
  String lag;
  String address;
  String addressEn;
  String description;
  String descriptionEn;
  String deliveryOn;
  String password;
  String phone;
  String phoneSecond;
  String phoneThird;
  String location;
  String mainImg;
  int id;

  ServiceDetails(
      {this.detectionPrice,
        this.detectionPriceEn,
        this.waitingTime,
        this.waitingTimeEn,
        this.specializationEn,
        this.specialization,
        this.nameAr,
        this.nameEn,
        this.whatsapp,
        this.facebook,
        this.email,
        this.website,
        this.instagram,
        this.twitter,
        this.lat,
        this.lag,
        this.address,
        this.addressEn,
        this.description,
        this.descriptionEn,
        this.deliveryOn,
        this.password,
        this.phone,
        this.phoneSecond,
        this.phoneThird,
        this.location,
        this.mainImg,
        this.id});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    detectionPrice = json['detection_price'];
    detectionPriceEn = json['detection_price_en'];
    waitingTime = json['waiting_time'];
    waitingTimeEn = json['waiting_time_en'];
    specializationEn = json['specialization_en'];
    specialization = json['specialization'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    whatsapp = json['whatsapp'];
    facebook = json['facebook'];
    email = json['email'];
    website = json['website'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    lat = json['lat'];
    lag = json['lag'];
    address = json['address'];
    addressEn = json['address_en'];
    description = json['description'];
    descriptionEn = json['description_en'];
    deliveryOn = json['delivery_on'];
    password = json['password'];
    phone = json['phone'];
    phoneSecond = json['phone_second'];
    phoneThird = json['phone_third'];
    location = json['location'];
    mainImg = json['main_img'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detection_price'] = this.detectionPrice;
    data['detection_price_en'] = this.detectionPriceEn;
    data['waiting_time'] = this.waitingTime;
    data['waiting_time_en'] = this.waitingTimeEn;
    data['specialization_en'] = this.specializationEn;
    data['specialization'] = this.specialization;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['whatsapp'] = this.whatsapp;
    data['facebook'] = this.facebook;
    data['email'] = this.email;
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['lat'] = this.lat;
    data['lag'] = this.lag;
    data['address'] = this.address;
    data['address_en'] = this.addressEn;
    data['description'] = this.description;
    data['description_en'] = this.descriptionEn;
    data['delivery_on'] = this.deliveryOn;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['phone_second'] = this.phoneSecond;
    data['phone_third'] = this.phoneThird;
    data['location'] = this.location;
    data['main_img'] = this.mainImg;
    data['id'] = this.id;
    return data;
  }
}
