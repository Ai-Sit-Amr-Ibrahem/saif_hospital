class HistoryDetailsModel {
  int? status;
  Data? data;
  String? message;

  HistoryDetailsModel({this.status, this.data, this.message});

  HistoryDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  VITALSIGNS? vITALSIGNS;
  RISKFACTORS? rISKFACTORS;
  List<VisitData>? visitData;
  List<MEDICATION>? mEDICATION;
  List<LABAROTYR>? lABAROTYR;
  List<RADIOLGY>? rADIOLGY;
  List<MEDICATION>? otherServies;

  Data(
      {this.vITALSIGNS,
        this.rISKFACTORS,
        this.visitData,
        this.mEDICATION,
        this.lABAROTYR,
        this.rADIOLGY,
        this.otherServies});

  Data.fromJson(Map<String, dynamic> json) {
    vITALSIGNS = json['VITAL_SIGNS'] != null
        ? VITALSIGNS.fromJson(json['VITAL_SIGNS'])
        : null;
    rISKFACTORS = json['RISK_FACTORS'] != null
        ? RISKFACTORS.fromJson(json['RISK_FACTORS'])
        : null;
    if (json['visit data'] != null) {
      visitData = <VisitData>[];
      json['visit data'].forEach((v) {
        visitData!.add(VisitData.fromJson(v));
      });
    }
    if (json['MEDICATION'] != null) {
      mEDICATION = <MEDICATION>[];
      json['MEDICATION'].forEach((v) {
        mEDICATION!.add(MEDICATION.fromJson(v));
      });
    }
    if (json['LABAROTYR'] != null) {
      lABAROTYR = <LABAROTYR>[];
      json['LABAROTYR'].forEach((v) {
        lABAROTYR!.add(LABAROTYR.fromJson(v));
      });
    }
    if (json['RADIOLGY'] != null) {
      rADIOLGY = <RADIOLGY>[];
      json['RADIOLGY'].forEach((v) {
        rADIOLGY!.add(RADIOLGY.fromJson(v));
      });
    }
    if (json['other_servies'] != null) {
      otherServies = <MEDICATION>[];
      json['other_servies'].forEach((v) {
        otherServies!.add(MEDICATION.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (vITALSIGNS != null) {
      data['VITAL_SIGNS'] = vITALSIGNS!.toJson();
    }
    if (rISKFACTORS != null) {
      data['RISK_FACTORS'] = rISKFACTORS!.toJson();
    }
    if (visitData != null) {
      data['visit data'] = visitData!.map((v) => v.toJson()).toList();
    }
    if (mEDICATION != null) {
      data['MEDICATION'] = mEDICATION!.map((v) => v.toJson()).toList();
    }
    if (lABAROTYR != null) {
      data['LABAROTYR'] = lABAROTYR!.map((v) => v.toJson()).toList();
    }
    if (rADIOLGY != null) {
      data['RADIOLGY'] = rADIOLGY!.map((v) => v.toJson()).toList();
    }
    if (otherServies != null) {
      data['other_servies'] =
          otherServies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VITALSIGNS {
  String? tEMPERATURE;
  String? pULSE;
  String? bLOODPRESSUREHI;
  String? bLOODPRESSURELO;
  String? rESPIRATORYRATE;
  String? height;
  String? weight;
  String? bMI;
  String? wEIGHTPERCENT;
  String? hEADCIRCUM;
  String? hEIGHTPERCENT;
  String? hEADCIRCUMPERCENT;
  String? pAIN;
  String? fBS;
  String? rBS;
  String? wAIST;
  String? hIP;
  String? oXYGENSATURATION;

  VITALSIGNS(
      {this.tEMPERATURE,
        this.pULSE,
        this.bLOODPRESSUREHI,
        this.bLOODPRESSURELO,
        this.rESPIRATORYRATE,
        this.height,
        this.weight,
        this.bMI,
        this.wEIGHTPERCENT,
        this.hEADCIRCUM,
        this.hEIGHTPERCENT,
        this.hEADCIRCUMPERCENT,
        this.pAIN,
        this.fBS,
        this.rBS,
        this.wAIST,
        this.hIP,
        this.oXYGENSATURATION});

  VITALSIGNS.fromJson(Map<String, dynamic> json) {
    tEMPERATURE = json['TEMPERATURE'];
    pULSE = json['PULSE'];
    bLOODPRESSUREHI = json['BLOODPRESSUREHI'];
    bLOODPRESSURELO = json['BLOODPRESSURELO'];
    rESPIRATORYRATE = json['RESPIRATORYRATE'];
    height = json['height'];
    weight = json['weight'];
    bMI = json['BMI'];
    wEIGHTPERCENT = json['WEIGHTPERCENT'];
    hEADCIRCUM = json['HEADCIRCUM'];
    hEIGHTPERCENT = json['HEIGHTPERCENT'];
    hEADCIRCUMPERCENT = json['HEADCIRCUMPERCENT'];
    pAIN = json['PAIN'];
    fBS = json['FBS'];
    rBS = json['RBS'];
    wAIST = json['WAIST'];
    hIP = json['HIP'];
    oXYGENSATURATION = json['OXYGENSATURATION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TEMPERATURE'] = tEMPERATURE;
    data['PULSE'] = pULSE;
    data['BLOODPRESSUREHI'] = bLOODPRESSUREHI;
    data['BLOODPRESSURELO'] = bLOODPRESSURELO;
    data['RESPIRATORYRATE'] = rESPIRATORYRATE;
    data['height'] = height;
    data['weight'] = weight;
    data['BMI'] = bMI;
    data['WEIGHTPERCENT'] = wEIGHTPERCENT;
    data['HEADCIRCUM'] = hEADCIRCUM;
    data['HEIGHTPERCENT'] = hEIGHTPERCENT;
    data['HEADCIRCUMPERCENT'] = hEADCIRCUMPERCENT;
    data['PAIN'] = pAIN;
    data['FBS'] = fBS;
    data['RBS'] = rBS;
    data['WAIST'] = wAIST;
    data['HIP'] = hIP;
    data['OXYGENSATURATION'] = oXYGENSATURATION;
    return data;
  }
}

class RISKFACTORS {
  String? cHRONIC;
  String? cONGENITAL;
  String? rTA;
  String? wORKRELATED;
  String? vACCINATION;
  String? cHECKUP;
  String? pSYCHIATRIC;
  String? iNFERTILITY;
  String? pREGNANCY;
  String? iNDICATELMP;
  String? eMERGENCYCASE;
  String? dURATIONOFILLNESS;
  String? dMY;

  RISKFACTORS(
      {this.cHRONIC,
        this.cONGENITAL,
        this.rTA,
        this.wORKRELATED,
        this.vACCINATION,
        this.cHECKUP,
        this.pSYCHIATRIC,
        this.iNFERTILITY,
        this.pREGNANCY,
        this.iNDICATELMP,
        this.eMERGENCYCASE,
        this.dURATIONOFILLNESS,
        this.dMY});

  RISKFACTORS.fromJson(Map<String, dynamic> json) {
    cHRONIC = json['CHRONIC'];
    cONGENITAL = json['CONGENITAL'];
    rTA = json['RTA'];
    wORKRELATED = json['WORK_RELATED'];
    vACCINATION = json['VACCINATION'];
    cHECKUP = json['CHECK_UP'];
    pSYCHIATRIC = json['PSYCHIATRIC'];
    iNFERTILITY = json['INFERTILITY'];
    pREGNANCY = json['PREGNANCY'];
    iNDICATELMP = json['INDICATE_LMP'];
    eMERGENCYCASE = json['EMERGENCY_CASE'];
    dURATIONOFILLNESS = json['DURATION_OF_ILLNESS'];
    dMY = json['D_M_Y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CHRONIC'] = cHRONIC;
    data['CONGENITAL'] = cONGENITAL;
    data['RTA'] = rTA;
    data['WORK_RELATED'] = wORKRELATED;
    data['VACCINATION'] = vACCINATION;
    data['CHECK_UP'] = cHECKUP;
    data['PSYCHIATRIC'] = pSYCHIATRIC;
    data['INFERTILITY'] = iNFERTILITY;
    data['PREGNANCY'] = pREGNANCY;
    data['INDICATE_LMP'] = iNDICATELMP;
    data['EMERGENCY_CASE'] = eMERGENCYCASE;
    data['DURATION_OF_ILLNESS'] = dURATIONOFILLNESS;
    data['D_M_Y'] = dMY;
    return data;
  }
}

class VisitData {
  String? mDENNAME;
  String? cOMMINT;
  String? oUTOCOMMINT;
  String? nAMEMEDICATION;

  VisitData(
      {this.mDENNAME, this.cOMMINT, this.oUTOCOMMINT, this.nAMEMEDICATION});

  VisitData.fromJson(Map<String, dynamic> json) {
    mDENNAME = json['MD_EN_NAME'];
    cOMMINT = json['COMMINT'];
    oUTOCOMMINT = json['OUTO_COMMINT'];
    nAMEMEDICATION = json['NAME_MEDICATION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MD_EN_NAME'] = mDENNAME;
    data['COMMINT'] = cOMMINT;
    data['OUTO_COMMINT'] = oUTOCOMMINT;
    data['NAME_MEDICATION'] = nAMEMEDICATION;
    return data;
  }
}

class MEDICATION {
  String? iTEMNAME;

  MEDICATION({this.iTEMNAME});

  MEDICATION.fromJson(Map<String, dynamic> json) {
    iTEMNAME = json['ITEM_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEM_NAME'] = iTEMNAME;
    return data;
  }
}

class LABAROTYR {
  String? rECEIPTHEADERID;
  String? iTEMID;
  String? iTEMCODE;
  String? iTEMNAME;
  String? pARENTITEM;

  LABAROTYR(
      {this.rECEIPTHEADERID,
        this.iTEMID,
        this.iTEMCODE,
        this.iTEMNAME,
        this.pARENTITEM});

  LABAROTYR.fromJson(Map<String, dynamic> json) {
    rECEIPTHEADERID = json['RECEIPT_HEADER_ID'];
    iTEMID = json['ITEM_ID'];
    iTEMCODE = json['ITEM_CODE'];
    iTEMNAME = json['ITEM_NAME'];
    pARENTITEM = json['PARENT_ITEM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RECEIPT_HEADER_ID'] = rECEIPTHEADERID;
    data['ITEM_ID'] = iTEMID;
    data['ITEM_CODE'] = iTEMCODE;
    data['ITEM_NAME'] = iTEMNAME;
    data['PARENT_ITEM'] = pARENTITEM;
    return data;
  }
}

class RADIOLGY {
  String? rECEIPTHEADERID;
  String? iTEMID;
  String? iTEMCODE;
  String? iTEMNAME;
  String? parentItem;

  RADIOLGY(
      {this.rECEIPTHEADERID,
        this.iTEMID,
        this.iTEMCODE,
        this.iTEMNAME,
        this.parentItem});

  RADIOLGY.fromJson(Map<String, dynamic> json) {
    rECEIPTHEADERID = json['RECEIPT_HEADER_ID'];
    iTEMID = json['ITEM_ID'];
    iTEMCODE = json['ITEM_CODE'];
    iTEMNAME = json['ITEM_NAME'];
    parentItem = json['parent_item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RECEIPT_HEADER_ID'] = rECEIPTHEADERID;
    data['ITEM_ID'] = iTEMID;
    data['ITEM_CODE'] = iTEMCODE;
    data['ITEM_NAME'] = iTEMNAME;
    data['parent_item'] = parentItem;
    return data;
  }
}
