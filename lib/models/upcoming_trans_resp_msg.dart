class UpcomingSettlementsResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<UpcomingSettlements> result;

  UpcomingSettlementsResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  UpcomingSettlementsResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<UpcomingSettlements>();
      json['result'].forEach((v) {
        result.add(new UpcomingSettlements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['responseException'] = this.responseException;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingSettlements {
  String serialNo;
  String companyName;
  String principalAmount;
  String currency;
  String maturityDate;
  String supplierCompanyName;

  UpcomingSettlements(
      {this.serialNo,
      this.companyName,
      this.principalAmount,
      this.currency,
      this.maturityDate,
      this.supplierCompanyName});

  UpcomingSettlements.fromJson(Map<String, dynamic> json) {
    serialNo = json['SerialNo'];
    companyName = json['CompanyName'];
    principalAmount = json['PrincipalAmount'];
    currency = json['Currency'];
    maturityDate = json['MaturityDate'];
    supplierCompanyName = json['SupplierCompanyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SerialNo'] = this.serialNo;
    data['CompanyName'] = this.companyName;
    data['PrincipalAmount'] = this.principalAmount;
    data['Currency'] = this.currency;
    data['MaturityDate'] = this.maturityDate;
    data['SupplierCompanyName'] = this.supplierCompanyName;
    return data;
  }
}