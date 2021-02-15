class Tickets_json {
  String message;
  int codenum;
  bool status;
  int total;
  Result result;

  Tickets_json(
      {this.message, this.codenum, this.status, this.total, this.result});

  Tickets_json.fromJson(Map<String, dynamic> json) {
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
  List<MyTickets> myTickets;

  Result({this.myTickets});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['my_tickets'] != null) {
      myTickets = new List<MyTickets>();
      json['my_tickets'].forEach((v) {
        myTickets.add(new MyTickets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myTickets != null) {
      data['my_tickets'] = this.myTickets.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyTickets {
  int id;
  String title;
  String type;
  String senderType;
  String color;
  String content;
  String createdAt;

  MyTickets(
      {this.id,
        this.title,
        this.type,
        this.senderType,
        this.color,
        this.content,
        this.createdAt});

  MyTickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    senderType = json['sender_type'];
    color = json['color'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['sender_type'] = this.senderType;
    data['color'] = this.color;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    return data;
  }
}
