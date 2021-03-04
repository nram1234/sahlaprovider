class Get_notification_details_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Get_notification_details_json(
      {this.message, this.codenum, this.status, this.result});

  Get_notification_details_json.fromJson(Map<String, dynamic> json) {
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
  NotificationDetails notificationDetails;

  Result({this.notificationDetails});

  Result.fromJson(Map<String, dynamic> json) {
    notificationDetails = json['notification_details'] != null
        ? new NotificationDetails.fromJson(json['notification_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationDetails != null) {
      data['notification_details'] = this.notificationDetails.toJson();
    }
    return data;
  }
}

class NotificationDetails {
  String title;
  int id;
  String body;
  int isRead;
  String createdAt;

  NotificationDetails(
      {this.title, this.id, this.body, this.isRead, this.createdAt});

  NotificationDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    body = json['body'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['body'] = this.body;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    return data;
  }
}
