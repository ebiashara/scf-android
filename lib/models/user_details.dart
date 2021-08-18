class LoginResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  UserDetails result;

  LoginResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  LoginResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    result =
        json['result'] != null ? new UserDetails.fromJson(json['result']) : null;
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

class UserDetails {
  String otp;
  String username;
  String status;
  String message;
  String userID;
  String emailAddress;
  String fullName;
  String mobileNo;
  String profilePhoto;
  String userType;
  String token;
  String uActivityID;
  String companyID;
  String roleName;
  String roleType;
  String companyProfile;
  String roleLevel;
  String isBranding;
  String brandingUrl;
  String financerLogo;
  List<UserPermissionsList> userPermissionsList;

  UserDetails(
      {this.otp,
      this.username,
      this.status,
      this.message,
      this.userID,
      this.emailAddress,
      this.fullName,
      this.mobileNo,
      this.profilePhoto,
      this.userType,
      this.token,
      this.uActivityID,
      this.companyID,
      this.roleName,
      this.roleType,
      this.companyProfile,
      this.roleLevel,
      this.isBranding,
      this.brandingUrl,
      this.financerLogo,
      this.userPermissionsList});

  UserDetails.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    username = json['username'];
    status = json['status'];
    message = json['message'];
    userID = json['userID'];
    emailAddress = json['emailAddress'];
    fullName = json['fullName'];
    mobileNo = json['mobileNo'];
    profilePhoto = json['profilePhoto'];
    userType = json['userType'];
    token = json['token'];
    uActivityID = json['uActivityID'];
    companyID = json['companyID'];
    roleName = json['roleName'];
    roleType = json['roleType'];
    companyProfile = json['companyProfile'];
    roleLevel = json['roleLevel'];
    isBranding = json['isBranding'];
    brandingUrl = json['brandingUrl'];
    financerLogo = json['financerLogo'];
    if (json['userPermissionsList'] != null) {
      userPermissionsList = new List<UserPermissionsList>();
      json['userPermissionsList'].forEach((v) {
        userPermissionsList.add(new UserPermissionsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['username'] = this.username;
    data['status'] = this.status;
    data['message'] = this.message;
    data['userID'] = this.userID;
    data['emailAddress'] = this.emailAddress;
    data['fullName'] = this.fullName;
    data['mobileNo'] = this.mobileNo;
    data['profilePhoto'] = this.profilePhoto;
    data['userType'] = this.userType;
    data['token'] = this.token;
    data['uActivityID'] = this.uActivityID;
    data['companyID'] = this.companyID;
    data['roleName'] = this.roleName;
    data['roleType'] = this.roleType;
    data['companyProfile'] = this.companyProfile;
    data['roleLevel'] = this.roleLevel;
    data['isBranding'] = this.isBranding;
    data['brandingUrl'] = this.brandingUrl;
    data['financerLogo'] = this.financerLogo;
    if (this.userPermissionsList != null) {
      data['userPermissionsList'] =
          this.userPermissionsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPermissionsList {
  String moduleName;
  String parentModuleName;
  bool addPerm;
  bool editPerm;
  bool deletePerm;
  bool viewPerm;
  bool exportPerm;

  UserPermissionsList(
      {this.moduleName,
      this.parentModuleName,
      this.addPerm,
      this.editPerm,
      this.deletePerm,
      this.viewPerm,
      this.exportPerm});

  UserPermissionsList.fromJson(Map<String, dynamic> json) {
    moduleName = json['moduleName'];
    parentModuleName = json['parentModuleName'];
    addPerm = json['addPerm'];
    editPerm = json['editPerm'];
    deletePerm = json['deletePerm'];
    viewPerm = json['viewPerm'];
    exportPerm = json['exportPerm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleName'] = this.moduleName;
    data['parentModuleName'] = this.parentModuleName;
    data['addPerm'] = this.addPerm;
    data['editPerm'] = this.editPerm;
    data['deletePerm'] = this.deletePerm;
    data['viewPerm'] = this.viewPerm;
    data['exportPerm'] = this.exportPerm;
    return data;
  }
}