class CustomerListResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<CustomerResult> result;

  CustomerListResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  CustomerListResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<CustomerResult>();
      json['result'].forEach((v) {
        result.add(new CustomerResult.fromJson(v));
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

class CustomerResult {
  int companyID;
  String companyName;
  String buyerSupplier;

  CustomerResult({this.companyID, this.companyName, this.buyerSupplier});

  CustomerResult.fromJson(Map<String, dynamic> json) {
    companyID = json['companyID'];
    companyName = json['companyName'];
    buyerSupplier = json['buyerSupplier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyID'] = this.companyID;
    data['companyName'] = this.companyName;
    data['buyerSupplier'] = this.buyerSupplier;
    return data;
  }
}