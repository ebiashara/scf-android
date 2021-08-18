class ProfileResponseMessage {
  String status;
  String statusCode;
  String message;
  Null responseException;
  List<UserProfile> result;

  ProfileResponseMessage(
      {this.status,
      this.statusCode,
      this.message,
      this.responseException,
      this.result});

  ProfileResponseMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    responseException = json['responseException'];
    if (json['result'] != null) {
      result = new List<UserProfile>();
      json['result'].forEach((v) {
        result.add(new UserProfile.fromJson(v));
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

class UserProfile {
  String userID;
  int companyID;
  int adminID;
  String companyName;
  String roleName;
  String title;
  String firstName;
  String lastName;
  String userName;
  String userPass;
  String emailAddress;
  String phoneNo;
  String isdCode;
  String mobileNo;
  int roleID;
  String roleType;
  String roleLevel;
  String profilePhoto;
  bool subNewsLetter;
  bool subEmailNotification;
  bool isActive;
  int updatedBy;
  bool isBranding;
  String updatedByName;
  String createdByName;
  bool adminVerified;

  UserProfile(
      {this.userID,
      this.companyID,
      this.adminID,
      this.companyName,
      this.roleName,
      this.title,
      this.firstName,
      this.lastName,
      this.userName,
      this.userPass,
      this.emailAddress,
      this.phoneNo,
      this.isdCode,
      this.mobileNo,
      this.roleID,
      this.roleType,
      this.roleLevel,
      this.profilePhoto,
      this.subNewsLetter,
      this.subEmailNotification,
      this.isActive,
      this.updatedBy,
      this.isBranding,
      this.updatedByName,
      this.createdByName,
      this.adminVerified});

  UserProfile.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    companyID = json['companyID'];
    adminID = json['adminID'];
    companyName = json['companyName'];
    roleName = json['roleName'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    userPass = json['userPass'];
    emailAddress = json['emailAddress'];
    phoneNo = json['phoneNo'];
    isdCode = json['isdCode'];
    mobileNo = json['mobileNo'];
    roleID = json['roleID'];
    roleType = json['roleType'];
    roleLevel = json['roleLevel'];
    profilePhoto = json['profilePhoto'];
    subNewsLetter = json['subNewsLetter'];
    subEmailNotification = json['subEmailNotification'];
    isActive = json['isActive'];
    updatedBy = json['updatedBy'];
    isBranding = json['isBranding'];
    updatedByName = json['updatedByName'];
    createdByName = json['createdByName'];
    adminVerified = json['adminVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['companyID'] = this.companyID;
    data['adminID'] = this.adminID;
    data['companyName'] = this.companyName;
    data['roleName'] = this.roleName;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userName'] = this.userName;
    data['userPass'] = this.userPass;
    data['emailAddress'] = this.emailAddress;
    data['phoneNo'] = this.phoneNo;
    data['isdCode'] = this.isdCode;
    data['mobileNo'] = this.mobileNo;
    data['roleID'] = this.roleID;
    data['roleType'] = this.roleType;
    data['roleLevel'] = this.roleLevel;
    data['profilePhoto'] = this.profilePhoto;
    data['subNewsLetter'] = this.subNewsLetter;
    data['subEmailNotification'] = this.subEmailNotification;
    data['isActive'] = this.isActive;
    data['updatedBy'] = this.updatedBy;
    data['isBranding'] = this.isBranding;
    data['updatedByName'] = this.updatedByName;
    data['createdByName'] = this.createdByName;
    data['adminVerified'] = this.adminVerified;
    return data;
  }
}