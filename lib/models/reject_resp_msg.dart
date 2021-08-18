class RejectRespMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  ApproveResult result;

  RejectRespMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  RejectRespMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    result =
        json['result'] != null ? new ApproveResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['responseException'] = this.responseException;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class ApproveResult {
  String status;
  String message;

  ApproveResult({this.status, this.message});

  ApproveResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}