class Tickets_types_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Tickets_types_json({this.message, this.codenum, this.status, this.result});

  Tickets_types_json.fromJson(Map<String, dynamic> json) {
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
  List<TicketsTypes> ticketsTypes;

  Result({this.ticketsTypes});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['tickets_types'] != null) {
      ticketsTypes = new List<TicketsTypes>();
      json['tickets_types'].forEach((v) {
        ticketsTypes.add(new TicketsTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ticketsTypes != null) {
      data['tickets_types'] = this.ticketsTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketsTypes {
  int id;
  String name;
  String color;

  TicketsTypes({this.id, this.name, this.color});

  TicketsTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}
