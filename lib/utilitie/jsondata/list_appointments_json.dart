class List_appointments_json {
  String message;
  int errNum;
  bool status;
  Result result;

  List_appointments_json({this.message, this.errNum, this.status, this.result});

  List_appointments_json.fromJson(Map<String, dynamic> json) {
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
  List<ListAppointments> listAppointments;

  Result({this.listAppointments});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['list_appointments'] != null) {
      listAppointments = new List<ListAppointments>();
      json['list_appointments'].forEach((v) {
        listAppointments.add(new ListAppointments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listAppointments != null) {
      data['list_appointments'] =
          this.listAppointments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListAppointments {
  String dayName;
  String dayNameEn;
  String fromHrs;
  String fromHrsEn;
  String toHrs;
  String toHrsEn;
  String listId;

  ListAppointments(
      {this.dayName,
        this.dayNameEn,
        this.fromHrs,
        this.fromHrsEn,
        this.toHrs,
        this.toHrsEn,
        this.listId});

  ListAppointments.fromJson(Map<String, dynamic> json) {
    dayName = json['day_name'];
    dayNameEn = json['day_name_en'];
    fromHrs = json['from_hrs'];
    fromHrsEn = json['from_hrs_en'];
    toHrs = json['to_hrs'];
    toHrsEn = json['to_hrs_en'];
    listId = json['list_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_name'] = this.dayName;
    data['day_name_en'] = this.dayNameEn;
    data['from_hrs'] = this.fromHrs;
    data['from_hrs_en'] = this.fromHrsEn;
    data['to_hrs'] = this.toHrs;
    data['to_hrs_en'] = this.toHrsEn;
    data['list_id'] = this.listId;
    return data;
  }
}
