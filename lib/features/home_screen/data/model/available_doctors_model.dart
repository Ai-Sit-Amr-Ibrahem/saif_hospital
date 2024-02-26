class AvailableDoctorsModel {
  int? status;
  List<Data>? data;
  String? message;

  AvailableDoctorsModel({this.status, this.data, this.message});

  AvailableDoctorsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? dOCTORNAME;
  String? dOCTORID;
  String? dOCTORIMAGE;
  int? cLIINICID;
  String? dOCTORDEGRE;
  String? price;
  String? resources;

  Data(
      {this.dOCTORNAME,
        this.dOCTORID,
        this.dOCTORIMAGE,
        this.cLIINICID,
        this.dOCTORDEGRE,
        this.price,
        this.resources});

  Data.fromJson(Map<String, dynamic> json) {
    dOCTORNAME = json['DOCTOR_NAME'];
    dOCTORID = json['DOCTOR_ID'];
    dOCTORIMAGE = json['DOCTOR_IMAGE'];
    cLIINICID = json['CLIINIC_ID'];
    dOCTORDEGRE = json['DOCTOR_DEGRE'];
    price = json['price'];
    resources = json['resources'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DOCTOR_NAME'] = dOCTORNAME;
    data['DOCTOR_ID'] = dOCTORID;
    data['DOCTOR_IMAGE'] = dOCTORIMAGE;
    data['CLIINIC_ID'] = cLIINICID;
    data['DOCTOR_DEGRE'] = dOCTORDEGRE;
    data['price'] = price;
    data['resources'] = resources;
    return data;
  }
}
