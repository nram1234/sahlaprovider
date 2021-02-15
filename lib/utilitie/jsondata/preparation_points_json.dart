class Preparation_points_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Preparation_points_json(
      {this.message, this.codenum, this.status, this.result});

  Preparation_points_json.fromJson(Map<String, dynamic> json) {
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
  String totalPoints;

  Result({this.totalPoints});

  Result.fromJson(Map<String, dynamic> json) {
    totalPoints = json['total_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_points'] = this.totalPoints;
    return data;
  }
}
