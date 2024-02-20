// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals, camel_case_types

class Authenticate {
  String? username;
  String? password;

  Authenticate({this.username, this.password});

  Authenticate.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

class auth {
  String? statuscode;
  respAuthenticate? res;

  auth({this.statuscode, this.res});

  auth.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    res =
        json['res'] != null ? new respAuthenticate.fromJson(json['res']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    if (this.res != null) {
      data['res'] = this.res!.toJson();
    }
    return data;
  }
}

class respAuthenticate {
  String? id;
  String? fullName;
  String? username;
  String? token;

  respAuthenticate({this.id, this.fullName, this.username, this.token});

  respAuthenticate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    data['token'] = this.token;
    return data;
  }
}
