class Cancel_order_json {
  String message;
  int codenum;
  bool status;

  Cancel_order_json({this.message, this.codenum, this.status});

  Cancel_order_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    codenum = json['codenum'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['codenum'] = this.codenum;
    data['status'] = this.status;
    return data;
  }
}
