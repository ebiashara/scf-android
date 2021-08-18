class ForgotPassResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  User result;

  ForgotPassResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  ForgotPassResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    result = json['result'] != null ? new User.fromJson(json['result']) : null;
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

class User {
  String userID;
  Null otp;
  String email;
  String mobileNo;
  String userName;
  String message;

  User(
      {this.userID,
      this.otp,
      this.email,
      this.mobileNo,
      this.userName,
      this.message});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    otp = json['otp'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    userName = json['userName'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['otp'] = this.otp;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['userName'] = this.userName;
    data['message'] = this.message;
    return data;
  }
}