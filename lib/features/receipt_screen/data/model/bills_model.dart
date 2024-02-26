class BillsModel {
  int? status;
  List<Data>? data;
  String? message;

  BillsModel({this.status, this.data, this.message});

  BillsModel.fromJson(Map<String, dynamic> json) {
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
  String? fINANCIALCATEGORIES;
  String? doctor;
  String? specialist;
  String? rECEIPTDATE;
  double? dISCOUNTAMOUNT;
  double? fCTOTAL;
  double? pATIENTAMOUNT;
  double? pATIENTTAX;
  double? gROSSAMOUNT;
  String? inOut;
  String? lINKPREVIEW;

  Data(
      {this.rECEIPTHEADERID,
        this.fINANCIALCATEGORIES,
        this.doctor,
        this.specialist,
        this.rECEIPTDATE,
        this.dISCOUNTAMOUNT,
        this.fCTOTAL,
        this.pATIENTAMOUNT,
        this.pATIENTTAX,
        this.gROSSAMOUNT,
        this.inOut,
        this.lINKPREVIEW});

  Data.fromJson(Map<String, dynamic> json) {
    rECEIPTHEADERID = json['RECEIPT_HEADER_ID'];
    fINANCIALCATEGORIES = json['FINANCIAL_CATEGORIES'];
    doctor = json['doctor'];
    specialist = json['specialist'];
    rECEIPTDATE = json['RECEIPT_DATE'];
    dISCOUNTAMOUNT = double.parse(json['DISCOUNT_AMOUNT'].toString());
    fCTOTAL = double.parse(json['FC_TOTAL'].toString());
    pATIENTAMOUNT = double.parse(json['PATIENT_AMOUNT'].toString());
    pATIENTTAX = double.parse(json['PATIENT_TAX'].toString());
    gROSSAMOUNT = double.parse(json['GROSS_AMOUNT'].toString());
    inOut = json['in_out'];
    lINKPREVIEW = json['LINK_PREVIEW'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RECEIPT_HEADER_ID'] = rECEIPTHEADERID;
    data['FINANCIAL_CATEGORIES'] = fINANCIALCATEGORIES;
    data['doctor'] = doctor;
    data['specialist'] = specialist;
    data['RECEIPT_DATE'] = rECEIPTDATE;
    data['DISCOUNT_AMOUNT'] = dISCOUNTAMOUNT;
    data['FC_TOTAL'] = fCTOTAL;
    data['PATIENT_AMOUNT'] = pATIENTAMOUNT;
    data['PATIENT_TAX'] = pATIENTTAX;
    data['GROSS_AMOUNT'] = gROSSAMOUNT;
    data['in_out'] = inOut;
    data['LINK_PREVIEW'] = lINKPREVIEW;
    return data;
  }
}
