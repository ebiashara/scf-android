class HelpResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<Help> result;

  HelpResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  HelpResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<Help>();
      json['result'].forEach((v) {
        result.add(new Help.fromJson(v));
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

class Help {
  int srNo;
  int faqid;
  String faqFor;
  String faqTitle;
  String faqDesc;
  bool isActive;
  String datecreated;
  int displayOrder;

  Help(
      {this.srNo,
      this.faqid,
      this.faqFor,
      this.faqTitle,
      this.faqDesc,
      this.isActive,
      this.datecreated,
      this.displayOrder});

  Help.fromJson(Map<String, dynamic> json) {
    srNo = json['srNo'];
    faqid = json['faqid'];
    faqFor = json['faqFor'];
    faqTitle = json['faqTitle'];
    faqDesc = json['faqDesc'];
    isActive = json['isActive'];
    datecreated = json['datecreated'];
    displayOrder = json['displayOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['srNo'] = this.srNo;
    data['faqid'] = this.faqid;
    data['faqFor'] = this.faqFor;
    data['faqTitle'] = this.faqTitle;
    data['faqDesc'] = this.faqDesc;
    data['isActive'] = this.isActive;
    data['datecreated'] = this.datecreated;
    data['displayOrder'] = this.displayOrder;
    return data;
  }
}