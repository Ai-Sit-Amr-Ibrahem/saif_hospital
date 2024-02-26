class LabModel {
  int? status;
  List<Data>? data;
  String? message;

  LabModel({this.status, this.data, this.message});

  LabModel.fromJson(Map<String, dynamic> json) {
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
  int? rECEIPTHEADERID;
  int? iTEMID;
  String? iTEMCODE;
  String? iTEMNAME;
  String? pARENTITEM;
  String? linkPreview;

  Data(
      {this.rECEIPTHEADERID,
        this.iTEMID,
        this.iTEMCODE,
        this.iTEMNAME,
        this.pARENTITEM,
        this.linkPreview});

  Data.fromJson(Map<String, dynamic> json) {
    rECEIPTHEADERID = json['RECEIPT_HEADER_ID'];
    iTEMID = json['ITEM_ID'];
    iTEMCODE = json['ITEM_CODE'];
    iTEMNAME = json['ITEM_NAME'];
    pARENTITEM = json['PARENT_ITEM'];
    linkPreview = json['link_preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RECEIPT_HEADER_ID'] = rECEIPTHEADERID;
    data['ITEM_ID'] = iTEMID;
    data['ITEM_CODE'] = iTEMCODE;
    data['ITEM_NAME'] = iTEMNAME;
    data['PARENT_ITEM'] = pARENTITEM;
    data['link_preview'] = linkPreview;
    return data;
  }
}
