class DocumentByIdResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<DocumentDets> result;

  DocumentByIdResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  DocumentByIdResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<DocumentDets>();
      json['result'].forEach((v) {
        result.add(new DocumentDets.fromJson(v));
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

class DocumentDets {
  String idfrid;
  String lastStatus;
  String financerStatus;
  String buyerID;
  String sellerID;
  String buyerLogo;
  String buyerName;
  String buyerAddress;
  String buyerEmail;
  String buyerWebsite;
  String supplierLogo;
  String supplierName;
  String supplierAddress;
  String supplierEmail;
  String supplierWebsite;
  String financerLogo;
  String financerName;
  String docRefNo;
  String datecreated;
  String dateTimecreated;
  String dueDate;
  String currency;
  String financingPercentage;
  String interestRatePA;
  String commissionPer;
  String exciseTaxPer;
  String maximumTenor;
  String financingTenor;
  bool isChecked;
  bool isApproved;
  bool isOppPartyApproved;
  String creatorName;
  String checkerName;
  String approverName;
  String oppPartyApproverName;
  String financerApproverName;
  double invoiceTotal;
  double totalAmount;
  double interestAmt;
  double commissionAmt;
  double settlementAmount;
  String ownerCompanyID;
  String creatorCompanyID;
  int id;
  int financerID;
  int contractID;
  int curID;
  bool isPartialPayemntDone;
  String ledgerStatus;
  double partialAmount;
  bool isSettled;
  String settlementDate;
  bool isFinanced;
  String financeDate;
  String maturityDate;
  double exciseTaxAmt;
  double approvalLevel1;
  double approvalLevel2;
  double approvalLevel3;
  double approvalLevel4;
  double approvalLevel5;
  double pendingLimitBuyer;
  double pendingLimitSeller;
  String checkedDate;
  String approvedDate;
  String oppPartyApprovedDate;
  String financerApprovedDate;
  String financeLedgerID;
  bool isAutoFinance;
  List<IfrcViewDetails> ifrcViewDetails;

  DocumentDets(
      {this.idfrid,
      this.lastStatus,
      this.financerStatus,
      this.buyerID,
      this.sellerID,
      this.buyerLogo,
      this.buyerName,
      this.buyerAddress,
      this.buyerEmail,
      this.buyerWebsite,
      this.supplierLogo,
      this.supplierName,
      this.supplierAddress,
      this.supplierEmail,
      this.supplierWebsite,
      this.financerLogo,
      this.financerName,
      this.docRefNo,
      this.datecreated,
      this.dateTimecreated,
      this.dueDate,
      this.currency,
      this.financingPercentage,
      this.interestRatePA,
      this.commissionPer,
      this.exciseTaxPer,
      this.maximumTenor,
      this.financingTenor,
      this.isChecked,
      this.isApproved,
      this.isOppPartyApproved,
      this.creatorName,
      this.checkerName,
      this.approverName,
      this.oppPartyApproverName,
      this.financerApproverName,
      this.invoiceTotal,
      this.totalAmount,
      this.interestAmt,
      this.commissionAmt,
      this.settlementAmount,
      this.ownerCompanyID,
      this.creatorCompanyID,
      this.id,
      this.financerID,
      this.contractID,
      this.curID,
      this.isPartialPayemntDone,
      this.ledgerStatus,
      this.partialAmount,
      this.isSettled,
      this.settlementDate,
      this.isFinanced,
      this.financeDate,
      this.maturityDate,
      this.exciseTaxAmt,
      this.approvalLevel1,
      this.approvalLevel2,
      this.approvalLevel3,
      this.approvalLevel4,
      this.approvalLevel5,
      this.pendingLimitBuyer,
      this.pendingLimitSeller,
      this.checkedDate,
      this.approvedDate,
      this.oppPartyApprovedDate,
      this.financerApprovedDate,
      this.financeLedgerID,
      this.isAutoFinance,
      this.ifrcViewDetails});

  DocumentDets.fromJson(Map<String, dynamic> json) {
    idfrid = json['idfrid'];
    lastStatus = json['lastStatus'];
    financerStatus = json['financerStatus'];
    buyerID = json['buyerID'];
    sellerID = json['sellerID'];
    buyerLogo = json['buyerLogo'];
    buyerName = json['buyerName'];
    buyerAddress = json['buyerAddress'];
    buyerEmail = json['buyerEmail'];
    buyerWebsite = json['buyerWebsite'];
    supplierLogo = json['supplierLogo'];
    supplierName = json['supplierName'];
    supplierAddress = json['supplierAddress'];
    supplierEmail = json['supplierEmail'];
    supplierWebsite = json['supplierWebsite'];
    financerLogo = json['financerLogo'];
    financerName = json['financerName'];
    docRefNo = json['docRefNo'];
    datecreated = json['datecreated'];
    dateTimecreated = json['dateTimecreated'];
    dueDate = json['dueDate'];
    currency = json['currency'];
    financingPercentage = json['financingPercentage'];
    interestRatePA = json['interestRatePA'];
    commissionPer = json['commissionPer'];
    exciseTaxPer = json['exciseTaxPer'];
    maximumTenor = json['maximumTenor'];
    financingTenor = json['financingTenor'];
    isChecked = json['isChecked'];
    isApproved = json['isApproved'];
    isOppPartyApproved = json['isOppPartyApproved'];
    creatorName = json['creatorName'];
    checkerName = json['checkerName'];
    approverName = json['approverName'];
    oppPartyApproverName = json['oppPartyApproverName'];
    financerApproverName = json['financerApproverName'];
    invoiceTotal = json['invoiceTotal'];
    totalAmount = json['totalAmount'];
    interestAmt = json['interestAmt'];
    commissionAmt = json['commissionAmt'];
    settlementAmount = json['settlementAmount'];
    ownerCompanyID = json['ownerCompanyID'];
    creatorCompanyID = json['creatorCompanyID'];
    id = json['id'];
    financerID = json['financerID'];
    contractID = json['contractID'];
    curID = json['curID'];
    isPartialPayemntDone = json['isPartialPayemntDone'];
    ledgerStatus = json['ledgerStatus'];
    partialAmount = json['partialAmount'];
    isSettled = json['isSettled'];
    settlementDate = json['settlementDate'];
    isFinanced = json['isFinanced'];
    financeDate = json['financeDate'];
    maturityDate = json['maturityDate'];
    exciseTaxAmt = json['exciseTaxAmt'];
    approvalLevel1 = json['approvalLevel1'];
    approvalLevel2 = json['approvalLevel2'];
    approvalLevel3 = json['approvalLevel3'];
    approvalLevel4 = json['approvalLevel4'];
    approvalLevel5 = json['approvalLevel5'];
    pendingLimitBuyer = json['pendingLimitBuyer'];
    pendingLimitSeller = json['pendingLimitSeller'];
    checkedDate = json['checkedDate'];
    approvedDate = json['approvedDate'];
    oppPartyApprovedDate = json['oppPartyApprovedDate'];
    financerApprovedDate = json['financerApprovedDate'];
    financeLedgerID = json['financeLedgerID'];
    isAutoFinance = json['isAutoFinance'];
    if (json['ifrcViewDetails'] != null) {
      ifrcViewDetails = new List<IfrcViewDetails>();
      json['ifrcViewDetails'].forEach((v) {
        ifrcViewDetails.add(new IfrcViewDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idfrid'] = this.idfrid;
    data['lastStatus'] = this.lastStatus;
    data['financerStatus'] = this.financerStatus;
    data['buyerID'] = this.buyerID;
    data['sellerID'] = this.sellerID;
    data['buyerLogo'] = this.buyerLogo;
    data['buyerName'] = this.buyerName;
    data['buyerAddress'] = this.buyerAddress;
    data['buyerEmail'] = this.buyerEmail;
    data['buyerWebsite'] = this.buyerWebsite;
    data['supplierLogo'] = this.supplierLogo;
    data['supplierName'] = this.supplierName;
    data['supplierAddress'] = this.supplierAddress;
    data['supplierEmail'] = this.supplierEmail;
    data['supplierWebsite'] = this.supplierWebsite;
    data['financerLogo'] = this.financerLogo;
    data['financerName'] = this.financerName;
    data['docRefNo'] = this.docRefNo;
    data['datecreated'] = this.datecreated;
    data['dateTimecreated'] = this.dateTimecreated;
    data['dueDate'] = this.dueDate;
    data['currency'] = this.currency;
    data['financingPercentage'] = this.financingPercentage;
    data['interestRatePA'] = this.interestRatePA;
    data['commissionPer'] = this.commissionPer;
    data['exciseTaxPer'] = this.exciseTaxPer;
    data['maximumTenor'] = this.maximumTenor;
    data['financingTenor'] = this.financingTenor;
    data['isChecked'] = this.isChecked;
    data['isApproved'] = this.isApproved;
    data['isOppPartyApproved'] = this.isOppPartyApproved;
    data['creatorName'] = this.creatorName;
    data['checkerName'] = this.checkerName;
    data['approverName'] = this.approverName;
    data['oppPartyApproverName'] = this.oppPartyApproverName;
    data['financerApproverName'] = this.financerApproverName;
    data['invoiceTotal'] = this.invoiceTotal;
    data['totalAmount'] = this.totalAmount;
    data['interestAmt'] = this.interestAmt;
    data['commissionAmt'] = this.commissionAmt;
    data['settlementAmount'] = this.settlementAmount;
    data['ownerCompanyID'] = this.ownerCompanyID;
    data['creatorCompanyID'] = this.creatorCompanyID;
    data['id'] = this.id;
    data['financerID'] = this.financerID;
    data['contractID'] = this.contractID;
    data['curID'] = this.curID;
    data['isPartialPayemntDone'] = this.isPartialPayemntDone;
    data['ledgerStatus'] = this.ledgerStatus;
    data['partialAmount'] = this.partialAmount;
    data['isSettled'] = this.isSettled;
    data['settlementDate'] = this.settlementDate;
    data['isFinanced'] = this.isFinanced;
    data['financeDate'] = this.financeDate;
    data['maturityDate'] = this.maturityDate;
    data['exciseTaxAmt'] = this.exciseTaxAmt;
    data['approvalLevel1'] = this.approvalLevel1;
    data['approvalLevel2'] = this.approvalLevel2;
    data['approvalLevel3'] = this.approvalLevel3;
    data['approvalLevel4'] = this.approvalLevel4;
    data['approvalLevel5'] = this.approvalLevel5;
    data['pendingLimitBuyer'] = this.pendingLimitBuyer;
    data['pendingLimitSeller'] = this.pendingLimitSeller;
    data['checkedDate'] = this.checkedDate;
    data['approvedDate'] = this.approvedDate;
    data['oppPartyApprovedDate'] = this.oppPartyApprovedDate;
    data['financerApprovedDate'] = this.financerApprovedDate;
    data['financeLedgerID'] = this.financeLedgerID;
    data['isAutoFinance'] = this.isAutoFinance;
    if (this.ifrcViewDetails != null) {
      data['ifrcViewDetails'] =
          this.ifrcViewDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IfrcViewDetails {
  String docType;
  String referenceNo;
  String invoiceAmount;
  String amount;
  String interest;
  String netCommission;
  String settlementAmount;
  String documentDate;
  String maturityDate;

  IfrcViewDetails(
      {this.docType,
      this.referenceNo,
      this.invoiceAmount,
      this.amount,
      this.interest,
      this.netCommission,
      this.settlementAmount,
      this.documentDate,
      this.maturityDate});

  IfrcViewDetails.fromJson(Map<String, dynamic> json) {
    docType = json['docType'];
    referenceNo = json['referenceNo'];
    invoiceAmount = json['invoiceAmount'];
    amount = json['amount'];
    interest = json['interest'];
    netCommission = json['netCommission'];
    settlementAmount = json['settlementAmount'];
    documentDate = json['documentDate'];
    maturityDate = json['maturityDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docType'] = this.docType;
    data['referenceNo'] = this.referenceNo;
    data['invoiceAmount'] = this.invoiceAmount;
    data['amount'] = this.amount;
    data['interest'] = this.interest;
    data['netCommission'] = this.netCommission;
    data['settlementAmount'] = this.settlementAmount;
    data['documentDate'] = this.documentDate;
    data['maturityDate'] = this.maturityDate;
    return data;
  }
}