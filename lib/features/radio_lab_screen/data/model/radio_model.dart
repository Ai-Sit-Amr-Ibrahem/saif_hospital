class RadioModel {
  int? status;
  List<Data>? data;
  String? message;

  RadioModel({this.status, this.data, this.message});

  RadioModel.fromJson(Map<String, dynamic> json) {
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
  String? parentItem;
  String? llinkPreview;

  Data(
      {this.rECEIPTHEADERID,
        this.iTEMID,
        this.iTEMCODE,
        this.iTEMNAME,
        this.parentItem,
        this.llinkPreview});

  Data.fromJson(Map<String, dynamic> json) {
    rECEIPTHEADERID = json['RECEIPT_HEADER_ID'];
    iTEMID = json['ITEM_ID'];
    iTEMCODE = json['ITEM_CODE'];
    iTEMNAME = json['ITEM_NAME'];
    parentItem = json['parent_item'];
    llinkPreview = json['llink_preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RECEIPT_HEADER_ID'] = rECEIPTHEADERID;
    data['ITEM_ID'] = iTEMID;
    data['ITEM_CODE'] = iTEMCODE;
    data['ITEM_NAME'] = iTEMNAME;
    data['parent_item'] = parentItem;
    data['llink_preview'] = llinkPreview;
    return data;
  }
}
