class AmountFinancedResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<AmountFinanced> result;

  AmountFinancedResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  AmountFinancedResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<AmountFinanced>();
      json['result'].forEach((v) {
        result.add(new AmountFinanced.fromJson(v));
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

class AmountFinanced {
  String currency;
  String financedAmount;

  AmountFinanced({this.currency, this.financedAmount});

  AmountFinanced.fromJson(Map<String, dynamic> json) {
    currency = json['Currency'];
    financedAmount = json['FinancedAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Currency'] = this.currency;
    data['FinancedAmount'] = this.financedAmount;
    return data;
  }
}