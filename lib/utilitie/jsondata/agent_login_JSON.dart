class Agent_login_JSON {
  String message;
  int codenum;
  bool status;
  Result result;

  Agent_login_JSON({this.message, this.codenum, this.status, this.result});

  Agent_login_JSON.fromJson(Map<String, dynamic> json) {
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
  AgentData agentData;

  Result({this.agentData});

  Result.fromJson(Map<String, dynamic> json) {
    agentData = json['agent_data'] != null
        ? new AgentData.fromJson(json['agent_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agentData != null) {
      data['agent_data'] = this.agentData.toJson();
    }
    return data;
  }
}

class AgentData {
  String name;
  String phone;
  int id;
  String email;
  String token;

  AgentData({this.name, this.phone, this.id, this.email, this.token});

  AgentData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
