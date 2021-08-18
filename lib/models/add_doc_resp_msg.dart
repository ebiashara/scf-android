class AddDocRspMsg {
  String product;
  int contractID;
  int companyID;
  int buyerID;
  int sellerID;
  int financerID;
  Null maturityDate;
  String currency;
  int totalAmount;
  Null comments;
  int createdBy;
  Null status;
  List<DocumentDetailsAdd> documentDetailsAdd;

  AddDocRspMsg(
      {this.product,
      this.contractID,
      this.companyID,
      this.buyerID,
      this.sellerID,
      this.financerID,
      this.maturityDate,
      this.currency,
      this.totalAmount,
      this.comments,
      this.createdBy,
      this.status,
      this.documentDetailsAdd});

  AddDocRspMsg.fromJson(Map<String, dynamic> json) {
    product = json['Product'];
    contractID = json['ContractID'];
    companyID = json['CompanyID'];
    buyerID = json['BuyerID'];
    sellerID = json['SellerID'];
    financerID = json['FinancerID'];
    maturityDate = json['MaturityDate'];
    currency = json['Currency'];
    totalAmount = json['TotalAmount'];
    comments = json['Comments'];
    createdBy = json['CreatedBy'];
    status = json['Status'];
    if (json['DocumentDetailsAdd'] != null) {
      documentDetailsAdd = new List<DocumentDetailsAdd>();
      json['DocumentDetailsAdd'].forEach((v) {
        documentDetailsAdd.add(new DocumentDetailsAdd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product'] = this.product;
    data['ContractID'] = this.contractID;
    data['CompanyID'] = this.companyID;
    data['BuyerID'] = this.buyerID;
    data['SellerID'] = this.sellerID;
    data['FinancerID'] = this.financerID;
    data['MaturityDate'] = this.maturityDate;
    data['Currency'] = this.currency;
    data['TotalAmount'] = this.totalAmount;
    data['Comments'] = this.comments;
    data['CreatedBy'] = this.createdBy;
    data['Status'] = this.status;
    if (this.documentDetailsAdd != null) {
      data['DocumentDetailsAdd'] =
          this.documentDetailsAdd.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentDetailsAdd {
  String iD;
  String documentType;
  String referenceNo;
  Null buyerCode;
  Null sellerCode;
  Null financerCode;
  String documentDate;
  String maturityDate;
  int amount;
  Null currency;
  Null comments;

  DocumentDetailsAdd(
      {this.iD,
      this.documentType,
      this.referenceNo,
      this.buyerCode,
      this.sellerCode,
      this.financerCode,
      this.documentDate,
      this.maturityDate,
      this.amount,
      this.currency,
      this.comments});

  DocumentDetailsAdd.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    documentType = json['DocumentType'];
    referenceNo = json['ReferenceNo'];
    buyerCode = json['BuyerCode'];
    sellerCode = json['SellerCode'];
    financerCode = json['FinancerCode'];
    documentDate = json['DocumentDate'];
    maturityDate = json['MaturityDate'];
    amount = json['Amount'];
    currency = json['Currency'];
    comments = json['Comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['DocumentType'] = this.documentType;
    data['ReferenceNo'] = this.referenceNo;
    data['BuyerCode'] = this.buyerCode;
    data['SellerCode'] = this.sellerCode;
    data['FinancerCode'] = this.financerCode;
    data['DocumentDate'] = this.documentDate;
    data['MaturityDate'] = this.maturityDate;
    data['Amount'] = this.amount;
    data['Currency'] = this.currency;
    data['Comments'] = this.comments;
    return data;
  }
}