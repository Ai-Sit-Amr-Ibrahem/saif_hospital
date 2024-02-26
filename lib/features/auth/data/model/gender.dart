class LookUps {
  int? lineId;
  String? lineEnName;
  String? lineArName;

  LookUps({this.lineId, this.lineEnName, this.lineArName});

  LookUps.fromJson(Map<String, dynamic> json) {
    lineId = json['line_id'];
    lineEnName = json['line_en_name'];
    lineArName = json['line_ar_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line_id'] = this.lineId;
    data['line_en_name'] = this.lineEnName;
    data['line_ar_name'] = this.lineArName;
    return data;
  }
}