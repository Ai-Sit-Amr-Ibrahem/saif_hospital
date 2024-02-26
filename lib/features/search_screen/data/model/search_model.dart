import 'package:hisksa/features/doctors_screen/data/model/doctor_Model.dart';

import '../../../clinics_screen/data/model/clinics_model.dart';

class SearchModel {
  int? status;
  SearchData? data;
  String? message;

  SearchModel({this.status, this.data, this.message});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SearchData.fromJson(json['data']) : null;
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

class SearchData {
  List<ClinicData>? cLINIC;
  List<DoctorData>? dOCTOR;

  SearchData({this.cLINIC, this.dOCTOR});

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['CLINIC'] != null) {
      cLINIC = <ClinicData>[];
      json['CLINIC'].forEach((v) {
        cLINIC!.add(ClinicData.fromJson(v));
      });
    }
    if (json['DOCTOR'] != null) {
      dOCTOR = <DoctorData>[];
      json['DOCTOR'].forEach((v) {
        dOCTOR!.add(DoctorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cLINIC != null) {
      data['CLINIC'] = cLINIC!.map((v) => v.toJson()).toList();
    }
    if (dOCTOR != null) {
      data['DOCTOR'] = dOCTOR!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
