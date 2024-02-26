class TimeModel {
  int? status;
  List<TimeData>? data;
  String? message;

  TimeModel({this.status, this.data, this.message});

  TimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TimeData>[];
      json['data'].forEach((v) {
        data!.add(TimeData.fromJson(v));
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

class TimeData {
  int? rESOURCESSCHEDULESLOTSID;
  String? tIMEAVILABLE;

  TimeData({this.rESOURCESSCHEDULESLOTSID, this.tIMEAVILABLE});

  TimeData.fromJson(Map<String, dynamic> json) {
    rESOURCESSCHEDULESLOTSID = json['RESOURCES_SCHEDULE_SLOTS_ID'];
    tIMEAVILABLE = json['TIME_AVILABLE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RESOURCES_SCHEDULE_SLOTS_ID'] = rESOURCESSCHEDULESLOTSID;
    data['TIME_AVILABLE'] = tIMEAVILABLE;
    return data;
  }
}
