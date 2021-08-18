class FinancierResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<financierResult> result;

  FinancierResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  FinancierResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<financierResult>();
      json['result'].forEach((v) {
        result.add(new financierResult.fromJson(v));
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

class financierResult {
  int financerID;
  String companyName;

  financierResult({this.financerID, this.companyName});

  financierResult.fromJson(Map<String, dynamic> json) {
    financerID = json['financerID'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['financerID'] = this.financerID;
    data['companyName'] = this.companyName;
    return data;
  }
}