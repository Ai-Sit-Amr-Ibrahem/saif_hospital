class DoctorModel {
  int? status;
  List<DoctorData>? data;
  String? message;

  DoctorModel({this.status, this.data, this.message});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DoctorData>[];
      json['data'].forEach((v) {
        data!.add(DoctorData.fromJson(v));
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

class DoctorData {
  String? dOCTORNAME;
  String? dOCTOR;

  String? dOCTORID;
  String? dOCTORIMAGE;
  String? cLIINICID;
  String? dOCTORDEGRE;
  double? price;
  String? resources;

  DoctorData(
      {this.dOCTORNAME,
        this.dOCTORID,
        this.dOCTORIMAGE,
        this.cLIINICID,
        this.dOCTOR,
        this.dOCTORDEGRE,
        this.price,
        this.resources});

  DoctorData.fromJson(Map<String, dynamic> json) {
    dOCTOR = json['DOCTOR'];

    dOCTORNAME = json['DOCTOR_NAME'];
    dOCTORID = json['DOCTOR_ID'].toString();
    dOCTORIMAGE = json['DOCTOR_IMAGE'];
    cLIINICID = json['CLIINIC_ID'].toString();
    dOCTORDEGRE = json['DOCTOR_DEGREE'];
    price = double.parse(json['price'].toString());
    resources = json['resources'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DOCTOR'] = dOCTOR;

    data['DOCTOR_NAME'] = dOCTORNAME;
    data['DOCTOR_ID'] = dOCTORID;
    data['DOCTOR_IMAGE'] = dOCTORIMAGE;
    data['CLIINIC_ID'] = cLIINICID;
    data['DOCTOR_DEGREE'] = dOCTORDEGRE;
    data['price'] = price;
    data['resources'] = resources;
    return data;
  }
}
