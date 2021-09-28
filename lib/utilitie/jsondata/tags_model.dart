class TagsModel {
  String message;
  int codenum;
  bool status;
  Result result;

  TagsModel({this.message, this.codenum, this.status, this.result});

  TagsModel.fromJson(Map<String, dynamic> json) {
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
  List<AllListLocation> allListLocation;

  Result({this.allListLocation});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_list_location'] != null) {
      allListLocation = new List<AllListLocation>();
      json['all_list_location'].forEach((v) {
        allListLocation.add(new AllListLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allListLocation != null) {
      data['all_list_location'] =
          this.allListLocation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllListLocation {
  String tagName;
  int tagId;

  AllListLocation({this.tagName, this.tagId});

  AllListLocation.fromJson(Map<String, dynamic> json) {
    tagName = json['tag_name'];
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_name'] = this.tagName;
    data['tag_id'] = this.tagId;
    return data;
  }
}
