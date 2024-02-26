class HistoryModel {
  int? status;
  List<Data>? data;
  String? message;

  HistoryModel({this.status, this.data, this.message});

  HistoryModel.fromJson(Map<String, dynamic> json) {
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
  String? rECEIPTHEADERID;
  String? dOCTORNAME;
  String? dateVisit;
  String? vISITTYPE;
  String? sPECIALIEST;

  Data(
      {this.rECEIPTHEADERID,
        this.dOCTORNAME,
        this.dateVisit,
        this.vISITTYPE,
        this.sPECIALIEST});

  Data.fromJson(Map<String, dynamic> json) {
    rECEIPTHEADERID = json['RECEIPT_HEADER_ID'];
    dOCTORNAME = json['DOCTOR_NAME'];
    dateVisit = json['date_visit'];
    vISITTYPE = json['VISIT_TYPE'];
    sPECIALIEST = json['SPECIALIEST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RECEIPT_HEADER_ID'] = rECEIPTHEADERID;
    data['DOCTOR_NAME'] = dOCTORNAME;
    data['date_visit'] = dateVisit;
    data['VISIT_TYPE'] = vISITTYPE;
    data['SPECIALIEST'] = sPECIALIEST;
    return data;
  }
}
