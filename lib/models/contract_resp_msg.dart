class ContractResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<Contracts> result;

  ContractResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  ContractResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<Contracts>();
      json['result'].forEach((v) {
        result.add(new Contracts.fromJson(v));
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

class Contracts {
  int contractID;
  int financerID;
  int buyerID;
  int supplierID;
  String product;
  double sharedRevenuePer;
  int maxFinanceTenor;
  double interestPAPer;
  double commissionPer;
  double exciseTaxPer;
  double maxFinancePer;
  double penaltyInterestPer;
  int penaltyGracePeriod;
  int penaltyMaxTenor;
  int buyerBankID;
  String buyerBankAccName;
  String buyerBankAccNo;
  String buyerBankAccBranch;
  String buyerBankCode;
  int buyerCurrency;
  String buyerCurrencyName;
  double buyerLimitAmount;
  int sellerBankID;
  String sellerBankAccName;
  String sellerBankAccNo;
  String sellerBankAccBranch;
  String sellerBankCode;
  int sellerCurrency;
  String sellerCurrencyName;
  double sellerLimitAmount;
  double approvalLevel1;
  double approvalLevel2;
  double approvalLevel3;
  double approvalLevel4;
  double approvalLevel5;
  int facilityBankID;
  String facilityAccName;
  String facilityAccNo;
  String facilityBankAccBranch;
  String facilityBankCode;
  String datecreated;
  bool isActive;
  String financer;
  String buyer;
  String seller;
  String facilityBankName;
  String buyerBankName;
  String sellerBankName;
  bool autoFinance;

  Contracts(
      {this.contractID,
      this.financerID,
      this.buyerID,
      this.supplierID,
      this.product,
      this.sharedRevenuePer,
      this.maxFinanceTenor,
      this.interestPAPer,
      this.commissionPer,
      this.exciseTaxPer,
      this.maxFinancePer,
      this.penaltyInterestPer,
      this.penaltyGracePeriod,
      this.penaltyMaxTenor,
      this.buyerBankID,
      this.buyerBankAccName,
      this.buyerBankAccNo,
      this.buyerBankAccBranch,
      this.buyerBankCode,
      this.buyerCurrency,
      this.buyerCurrencyName,
      this.buyerLimitAmount,
      this.sellerBankID,
      this.sellerBankAccName,
      this.sellerBankAccNo,
      this.sellerBankAccBranch,
      this.sellerBankCode,
      this.sellerCurrency,
      this.sellerCurrencyName,
      this.sellerLimitAmount,
      this.approvalLevel1,
      this.approvalLevel2,
      this.approvalLevel3,
      this.approvalLevel4,
      this.approvalLevel5,
      this.facilityBankID,
      this.facilityAccName,
      this.facilityAccNo,
      this.facilityBankAccBranch,
      this.facilityBankCode,
      this.datecreated,
      this.isActive,
      this.financer,
      this.buyer,
      this.seller,
      this.facilityBankName,
      this.buyerBankName,
      this.sellerBankName,
      this.autoFinance});

  Contracts.fromJson(Map<String, dynamic> json) {
    contractID = json['contractID'];
    financerID = json['financerID'];
    buyerID = json['buyerID'];
    supplierID = json['supplierID'];
    product = json['product'];
    sharedRevenuePer = json['sharedRevenuePer'];
    maxFinanceTenor = json['maxFinanceTenor'];
    interestPAPer = json['interestPAPer'];
    commissionPer = json['commissionPer'];
    exciseTaxPer = json['exciseTaxPer'];
    maxFinancePer = json['maxFinancePer'];
    penaltyInterestPer = json['penaltyInterestPer'];
    penaltyGracePeriod = json['penaltyGracePeriod'];
    penaltyMaxTenor = json['penaltyMaxTenor'];
    buyerBankID = json['buyerBankID'];
    buyerBankAccName = json['buyerBankAccName'];
    buyerBankAccNo = json['buyerBankAccNo'];
    buyerBankAccBranch = json['buyerBankAccBranch'];
    buyerBankCode = json['buyerBankCode'];
    buyerCurrency = json['buyerCurrency'];
    buyerCurrencyName = json['buyerCurrencyName'];
    buyerLimitAmount = json['buyerLimitAmount'];
    sellerBankID = json['sellerBankID'];
    sellerBankAccName = json['sellerBankAccName'];
    sellerBankAccNo = json['sellerBankAccNo'];
    sellerBankAccBranch = json['sellerBankAccBranch'];
    sellerBankCode = json['sellerBankCode'];
    sellerCurrency = json['sellerCurrency'];
    sellerCurrencyName = json['sellerCurrencyName'];
    sellerLimitAmount = json['sellerLimitAmount'];
    approvalLevel1 = json['approvalLevel1'];
    approvalLevel2 = json['approvalLevel2'];
    approvalLevel3 = json['approvalLevel3'];
    approvalLevel4 = json['approvalLevel4'];
    approvalLevel5 = json['approvalLevel5'];
    facilityBankID = json['facilityBankID'];
    facilityAccName = json['facilityAccName'];
    facilityAccNo = json['facilityAccNo'];
    facilityBankAccBranch = json['facilityBankAccBranch'];
    facilityBankCode = json['facilityBankCode'];
    datecreated = json['datecreated'];
    isActive = json['isActive'];
    financer = json['financer'];
    buyer = json['buyer'];
    seller = json['seller'];
    facilityBankName = json['facilityBankName'];
    buyerBankName = json['buyerBankName'];
    sellerBankName = json['sellerBankName'];
    autoFinance = json['autoFinance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contractID'] = this.contractID;
    data['financerID'] = this.financerID;
    data['buyerID'] = this.buyerID;
    data['supplierID'] = this.supplierID;
    data['product'] = this.product;
    data['sharedRevenuePer'] = this.sharedRevenuePer;
    data['maxFinanceTenor'] = this.maxFinanceTenor;
    data['interestPAPer'] = this.interestPAPer;
    data['commissionPer'] = this.commissionPer;
    data['exciseTaxPer'] = this.exciseTaxPer;
    data['maxFinancePer'] = this.maxFinancePer;
    data['penaltyInterestPer'] = this.penaltyInterestPer;
    data['penaltyGracePeriod'] = this.penaltyGracePeriod;
    data['penaltyMaxTenor'] = this.penaltyMaxTenor;
    data['buyerBankID'] = this.buyerBankID;
    data['buyerBankAccName'] = this.buyerBankAccName;
    data['buyerBankAccNo'] = this.buyerBankAccNo;
    data['buyerBankAccBranch'] = this.buyerBankAccBranch;
    data['buyerBankCode'] = this.buyerBankCode;
    data['buyerCurrency'] = this.buyerCurrency;
    data['buyerCurrencyName'] = this.buyerCurrencyName;
    data['buyerLimitAmount'] = this.buyerLimitAmount;
    data['sellerBankID'] = this.sellerBankID;
    data['sellerBankAccName'] = this.sellerBankAccName;
    data['sellerBankAccNo'] = this.sellerBankAccNo;
    data['sellerBankAccBranch'] = this.sellerBankAccBranch;
    data['sellerBankCode'] = this.sellerBankCode;
    data['sellerCurrency'] = this.sellerCurrency;
    data['sellerCurrencyName'] = this.sellerCurrencyName;
    data['sellerLimitAmount'] = this.sellerLimitAmount;
    data['approvalLevel1'] = this.approvalLevel1;
    data['approvalLevel2'] = this.approvalLevel2;
    data['approvalLevel3'] = this.approvalLevel3;
    data['approvalLevel4'] = this.approvalLevel4;
    data['approvalLevel5'] = this.approvalLevel5;
    data['facilityBankID'] = this.facilityBankID;
    data['facilityAccName'] = this.facilityAccName;
    data['facilityAccNo'] = this.facilityAccNo;
    data['facilityBankAccBranch'] = this.facilityBankAccBranch;
    data['facilityBankCode'] = this.facilityBankCode;
    data['datecreated'] = this.datecreated;
    data['isActive'] = this.isActive;
    data['financer'] = this.financer;
    data['buyer'] = this.buyer;
    data['seller'] = this.seller;
    data['facilityBankName'] = this.facilityBankName;
    data['buyerBankName'] = this.buyerBankName;
    data['sellerBankName'] = this.sellerBankName;
    data['autoFinance'] = this.autoFinance;
    return data;
  }
}