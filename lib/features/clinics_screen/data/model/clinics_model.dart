class ClinicsModel {
  int? status;
  List<ClinicData>? data;
  String? message;

  ClinicsModel({this.status, this.data, this.message});

  ClinicsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ClinicData>[];
      json['data'].forEach((v) {
        data!.add(ClinicData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ClinicData {
  String? cLINIC;
  int? cLIINICID;
  String? iMAGE;

  ClinicData({this.cLINIC, this.cLIINICID, this.iMAGE});

  ClinicData.fromJson(Map<String, dynamic> json) {

    cLINIC = json['CLINIC'];
    cLIINICID = int.parse(json['CLIINIC_ID'].toString());
    iMAGE = json['IMAGE'];
    print('iMAGE'+iMAGE.toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CLINIC'] = cLINIC;
    data['CLIINIC_ID'] = cLIINICID;
    data['IMAGE'] = iMAGE;
    return data;
  }
}
