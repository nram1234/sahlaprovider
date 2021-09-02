class Get_List_wedding_reservation_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Get_List_wedding_reservation_json(
      {this.message, this.errNum, this.status, this.result});

  Get_List_wedding_reservation_json.fromJson(Map<String, dynamic> json) {
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
  List<AllReservation> allReservation;

  Result({this.allReservation});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_reservation'] != null) {
      allReservation = new List<AllReservation>();
      json['all_reservation'].forEach((v) {
        allReservation.add(new AllReservation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allReservation != null) {
      data['all_reservation'] =
          this.allReservation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllReservation {
  int codeName;
  int idOrder;
  String fromHrs;
  String toHrs;
  String view;
  String address;
  String userMakeReservationName;
  String weddingSericesValue;
  String weddingSericesPrice;
  String userMakeReservationPhone;
  String reservationDay;
  String fullname;
  String phone;
  String creationDate;
  String reservationDate;
  String reservationType;

  AllReservation(
      {this.codeName,
        this.idOrder,
        this.fromHrs,
        this.toHrs,
        this.view,
        this.address,
        this.userMakeReservationName,
        this.weddingSericesValue,
        this.weddingSericesPrice,
        this.userMakeReservationPhone,
        this.reservationDay,
        this.fullname,
        this.phone,
        this.creationDate,
        this.reservationDate,
        this.reservationType});

  AllReservation.fromJson(Map<String, dynamic> json) {
    codeName = json['code_name'];
    idOrder = json['id_order'];
    fromHrs = json['from_hrs'];
    toHrs = json['to_hrs'];
    view = json['view'];
    address = json['address'];
    userMakeReservationName = json['user_make_reservation_name'];
    weddingSericesValue = json['wedding_serices_value'];
    weddingSericesPrice = json['wedding_serices_price'];
    userMakeReservationPhone = json['user_make_reservation_phone'];
    reservationDay = json['reservation_day'];
    fullname = json['fullname'];
    phone = json['phone'];
    creationDate = json['creation_date'];
    reservationDate = json['reservation_date'];
    reservationType = json['reservation_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_name'] = this.codeName;
    data['id_order'] = this.idOrder;
    data['from_hrs'] = this.fromHrs;
    data['to_hrs'] = this.toHrs;
    data['view'] = this.view;
    data['address'] = this.address;
    data['user_make_reservation_name'] = this.userMakeReservationName;
    data['wedding_serices_value'] = this.weddingSericesValue;
    data['wedding_serices_price'] = this.weddingSericesPrice;
    data['user_make_reservation_phone'] = this.userMakeReservationPhone;
    data['reservation_day'] = this.reservationDay;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['creation_date'] = this.creationDate;
    data['reservation_date'] = this.reservationDate;
    data['reservation_type'] = this.reservationType;
    return data;
  }
}
