class CustFinResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<CustomerFinancerSummary> result;

  CustFinResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  CustFinResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<CustomerFinancerSummary>();
      json['result'].forEach((v) {
        result.add(new CustomerFinancerSummary.fromJson(v));
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

class CustomerFinancerSummary {
  String amountFinanced;
  String noOfContracts;
  String noOfIDRs;
  String noOfIFRs;

  CustomerFinancerSummary(
      {this.amountFinanced, this.noOfContracts, this.noOfIDRs, this.noOfIFRs});

  CustomerFinancerSummary.fromJson(Map<String, dynamic> json) {
    amountFinanced = json['AmountFinanced'];
    noOfContracts = json['NoOfContracts'];
    noOfIDRs = json['NoOfIDRs'];
    noOfIFRs = json['NoOfIFRs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmountFinanced'] = this.amountFinanced;
    data['NoOfContracts'] = this.noOfContracts;
    data['NoOfIDRs'] = this.noOfIDRs;
    data['NoOfIFRs'] = this.noOfIFRs;
    return data;
  }
}