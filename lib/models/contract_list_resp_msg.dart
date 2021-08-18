class ContractListResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<ContractListResult> result;

  ContractListResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  ContractListResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<ContractListResult>();
      json['result'].forEach((v) {
        result.add(new ContractListResult.fromJson(v));
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

class ContractListResult {
  int contractID;
  String contractName;
  int curID;
  String currencyName;

  ContractListResult({this.contractID, this.contractName, this.curID, this.currencyName});

  ContractListResult.fromJson(Map<String, dynamic> json) {
    contractID = json['contractID'];
    contractName = json['contractName'];
    curID = json['curID'];
    currencyName = json['currencyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contractID'] = this.contractID;
    data['contractName'] = this.contractName;
    data['curID'] = this.curID;
    data['currencyName'] = this.currencyName;
    return data;
  }
}