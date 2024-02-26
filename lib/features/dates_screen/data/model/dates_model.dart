class DatesModel {
  int? status;
  List<Data>? data;
  String? message;

  DatesModel({this.status, this.data, this.message});

  DatesModel.fromJson(Map<String, dynamic> json) {
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
  int? rESOURCESSCHEDULEID;
  String? rESOURCEID;
  String? dOCTORID;
  String? cLIINICID;
  String? dATESCHADUALE;
  String? dETAILS;

  Data(
      {this.rESOURCESSCHEDULEID,
        this.rESOURCEID,
        this.dOCTORID,
        this.cLIINICID,
        this.dATESCHADUALE,
        this.dETAILS});

  Data.fromJson(Map<String, dynamic> json) {
    rESOURCESSCHEDULEID = json['RESOURCES_SCHEDULE_ID'];
    rESOURCEID = json['RESOURCE_ID'];
    dOCTORID = json['DOCTOR_ID'];
    cLIINICID = json['CLIINIC_ID'];
    dATESCHADUALE = json['DATE_SCHADUALE'];
    dETAILS = json['DETAILS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RESOURCES_SCHEDULE_ID'] = rESOURCESSCHEDULEID;
    data['RESOURCE_ID'] = rESOURCEID;
    data['DOCTOR_ID'] = dOCTORID;
    data['CLIINIC_ID'] = cLIINICID;
    data['DATE_SCHADUALE'] = dATESCHADUALE;
    data['DETAILS'] = dETAILS;
    return data;
  }
}
