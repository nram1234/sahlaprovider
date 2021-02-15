class Get_list_gallery_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Get_list_gallery_json({this.message, this.codenum, this.status, this.result});

  Get_list_gallery_json.fromJson(Map<String, dynamic> json) {
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
  int totalImg;
  List<AllImages> allImages;

  Result({this.totalImg, this.allImages});

  Result.fromJson(Map<String, dynamic> json) {
    totalImg = json['total_img'];
    if (json['all_images'] != null) {
      allImages = new List<AllImages>();
      json['all_images'].forEach((v) {
        allImages.add(new AllImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_img'] = this.totalImg;
    if (this.allImages != null) {
      data['all_images'] = this.allImages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllImages {
  String img;
  int id;

  AllImages({this.img, this.id});

  AllImages.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['id'] = this.id;
    return data;
  }
}
