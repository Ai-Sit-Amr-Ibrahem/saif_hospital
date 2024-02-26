import 'dart:convert';

LoginModel userModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String userModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? status;
  Data? data;
  String? message;

  LoginModel({this.status, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? token;
  Userdata? userdata;

  Data({this.token, this.userdata});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    userdata =
        json['userdata'] != null ? Userdata.fromJson(json['userdata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    if (userdata != null) {
      data['userdata'] = userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? uSERNAME;
  String? fILENUM;
  String? tELEPHONE;
  int? aGE;

  Userdata({
    this.uSERNAME,
    this.fILENUM,
    this.tELEPHONE,
    this.aGE,
  });

  Userdata.fromJson(Map<String, dynamic> json) {
    uSERNAME = json['USERNAME'];
    fILENUM = json['FILENUM'];
    tELEPHONE = json['TELEPHONE'];
    aGE = json['AGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['USERNAME'] = uSERNAME;
    data['FILENUM'] = fILENUM;
    data['TELEPHONE'] = tELEPHONE;
    data['AGE'] = aGE;
    return data;
  }
}
