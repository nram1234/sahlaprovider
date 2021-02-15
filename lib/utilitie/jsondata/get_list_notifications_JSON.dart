class Get_list_notifications_JSON {
  String message;
  int codenum;
  bool status;
  int total;
  Result result;

  Get_list_notifications_JSON(
      {this.message, this.codenum, this.status, this.total, this.result});

  Get_list_notifications_JSON.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    codenum = json['codenum'];
    status = json['status'];
    total = json['total'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['codenum'] = this.codenum;
    data['status'] = this.status;
    data['total'] = this.total;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<AllNotifications> allNotifications;

  Result({this.allNotifications});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_notifications'] != null) {
      allNotifications = new List<AllNotifications>();
      json['all_notifications'].forEach((v) {
        allNotifications.add(new AllNotifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allNotifications != null) {
      data['all_notifications'] =
          this.allNotifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllNotifications {
  String title;
  int id;
  String body;
  int isRead;
  String createdAt;

  AllNotifications(
      {this.title, this.id, this.body, this.isRead, this.createdAt});

  AllNotifications.fromJson(Map<String, dynamic> json) {
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
