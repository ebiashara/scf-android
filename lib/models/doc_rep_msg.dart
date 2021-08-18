class DocumentResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<Documents> result;

  DocumentResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  DocumentResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<Documents>();
      json['result'].forEach((v) {
        result.add(new Documents.fromJson(v));
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

class Documents {
  int docID;
  int idfrid;
  String docPrefix;
  String docType;
  String ownerName;
  String companyName;
  String buyerCompanyName;
  String sellerCompanyName;
  String currency;
  double invoiceTotal;
  double totalAmount;
  int financeTenor;
  double sharedRevenueAmt;
  double interestAmt;
  double commissionAmt;
  double exciseTaxAmt;
  int createdBy;
  String createdByName;
  String status;
  String datecreated;
  String maturityDate;
  int documentCount;
  String contractID;

  Documents(
      {this.docID,
      this.idfrid,
      this.docPrefix,
      this.docType,
      this.ownerName,
      this.companyName,
      this.buyerCompanyName,
      this.sellerCompanyName,
      this.currency,
      this.invoiceTotal,
      this.totalAmount,
      this.financeTenor,
      this.sharedRevenueAmt,
      this.interestAmt,
      this.commissionAmt,
      this.exciseTaxAmt,
      this.createdBy,
      this.createdByName,
      this.status,
      this.datecreated,
      this.maturityDate,
      this.documentCount,
      this.contractID});

  Documents.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    idfrid = json['idfrid'];
    docPrefix = json['docPrefix'];
    docType = json['docType'];
    ownerName = json['ownerName'];
    companyName = json['companyName'];
    buyerCompanyName = json['buyerCompanyName'];
    sellerCompanyName = json['sellerCompanyName'];
    currency = json['currency'];
    invoiceTotal = json['invoiceTotal'];
    totalAmount = json['totalAmount'];
    financeTenor = json['financeTenor'];
    sharedRevenueAmt = json['sharedRevenueAmt'];
    interestAmt = json['interestAmt'];
    commissionAmt = json['commissionAmt'];
    exciseTaxAmt = json['exciseTaxAmt'];
    createdBy = json['createdBy'];
    createdByName = json['createdByName'];
    status = json['status'];
    datecreated = json['datecreated'];
    maturityDate = json['maturityDate'];
    documentCount = json['documentCount'];
    contractID = json['contractID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = this.docID;
    data['idfrid'] = this.idfrid;
    data['docPrefix'] = this.docPrefix;
    data['docType'] = this.docType;
    data['ownerName'] = this.ownerName;
    data['companyName'] = this.companyName;
    data['buyerCompanyName'] = this.buyerCompanyName;
    data['sellerCompanyName'] = this.sellerCompanyName;
    data['currency'] = this.currency;
    data['invoiceTotal'] = this.invoiceTotal;
    data['totalAmount'] = this.totalAmount;
    data['financeTenor'] = this.financeTenor;
    data['sharedRevenueAmt'] = this.sharedRevenueAmt;
    data['interestAmt'] = this.interestAmt;
    data['commissionAmt'] = this.commissionAmt;
    data['exciseTaxAmt'] = this.exciseTaxAmt;
    data['createdBy'] = this.createdBy;
    data['createdByName'] = this.createdByName;
    data['status'] = this.status;
    data['datecreated'] = this.datecreated;
    data['maturityDate'] = this.maturityDate;
    data['documentCount'] = this.documentCount;
    data['contractID'] = this.contractID;
    return data;
  }
}