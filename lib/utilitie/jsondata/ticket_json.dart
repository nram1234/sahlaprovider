class Ticket_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Ticket_json({this.message, this.codenum, this.status, this.result});

  Ticket_json.fromJson(Map<String, dynamic> json) {
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
  TicketInfo ticketInfo;

  Result({this.ticketInfo});

  Result.fromJson(Map<String, dynamic> json) {
    ticketInfo = json['ticket_info'] != null
        ? new TicketInfo.fromJson(json['ticket_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ticketInfo != null) {
      data['ticket_info'] = this.ticketInfo.toJson();
    }
    return data;
  }
}

class TicketInfo {
  Ticket ticket;
  int repliesNumber;
  List<TicketReplies> ticketReplies;

  TicketInfo({this.ticket, this.repliesNumber, this.ticketReplies});

  TicketInfo.fromJson(Map<String, dynamic> json) {
    ticket =
    json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
    repliesNumber = json['replies_number'];
    if (json['ticket_replies'] != null) {
      ticketReplies = new List<TicketReplies>();
      json['ticket_replies'].forEach((v) {
        ticketReplies.add(new TicketReplies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ticket != null) {
      data['ticket'] = this.ticket.toJson();
    }
    data['replies_number'] = this.repliesNumber;
    if (this.ticketReplies != null) {
      data['ticket_replies'] =
          this.ticketReplies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ticket {
  int ticketId;
  String title;
  String type;
  String color;
  String content;
  String createdAt;

  Ticket(
      {this.ticketId,
        this.title,
        this.type,
        this.color,
        this.content,
        this.createdAt});

  Ticket.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    title = json['title'];
    type = json['type'];
    color = json['color'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['color'] = this.color;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class TicketReplies {
  int id;
  String createdAt;
  String time;
  String content;
  String sender;
  int senderType;

  TicketReplies(
      {this.id,
        this.createdAt,
        this.time,
        this.content,
        this.sender,
        this.senderType});

  TicketReplies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    time = json['time'];
    content = json['content'];
    sender = json['sender'];
    senderType = json['sender_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['time'] = this.time;
    data['content'] = this.content;
    data['sender'] = this.sender;
    data['sender_type'] = this.senderType;
    return data;
  }
}
