import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contract_list_resp_msg.dart';
import '../models/contract_resp_msg.dart';
import '../models/cur_fin_resp_msg.dart';
import '../models/customer_resp_msg.dart';
import '../models/docById_resp_msg.dart';
import '../models/doc_rep_msg.dart';
import '../models/document_message.dart';
import '../models/financier_resp_msg.dart';
import '../models/frgt_pswd_rsp_msg.dart';
import '../models/login_resp_msg.dart';
import '../models/ove_trans_resp_msg.dart';
import '../models/profile_response_message.dart';
import '../models/reject_resp_msg.dart';
import '../models/resset_rsp_msg.dart';
import '../models/task_resp_msg.dart';
import '../models/todo_dets_resp_msg.dart';
import '../models/upcoming_trans_resp_msg.dart';
import '../models/verify_otp_resp_msg.dart';

class APIHelper {
  static const baseUrl = "http://34.251.31.12:8080";
  static const headers = {
    'Content-Type': 'application/json',
  };

  Future<LoginResponseMessage> login(
      String username, password, ipAddress) async {
    String endpoint =
        '/api/login/login?username=${username}&pass=${password}&ipaddress=${ipAddress}';

    try {
      final response =
          await http.get(Uri.parse(baseUrl + endpoint), headers: headers);
      if (response.statusCode == 200) {
        LoginResponseMessage loginResponseMessage =
            LoginResponseMessage.fromJson(jsonDecode(response.body));
        return loginResponseMessage;
      } else {
        return LoginResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return LoginResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<UpcomingSettlementsResponseMessage> upcomingSettlements(
      String companyID, token) async {
    String endpoint =
        '/api/Dashboard/GetUpcomingSettlement/?CompanyID=${companyID}&FinancerID="0"';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        UpcomingSettlementsResponseMessage upcomingSettlementsResponseMessage =
            UpcomingSettlementsResponseMessage.fromJson(
                jsonDecode(response.body));
        return upcomingSettlementsResponseMessage;
      } else {
        return UpcomingSettlementsResponseMessage(
            message: "An errorr has ocuured");
      }
    } catch (e) {
      return UpcomingSettlementsResponseMessage(
          message: "An errorr has ocuured");
    }
  }

  Future<DocumentResponseMessage> getDocuments(
      String companyID, contractID, token) async {
    String endpoint =
        '/api/Document/GetAllDocumentList/?CompanyID=${companyID}&ContractID=${contractID}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        DocumentResponseMessage documentsResponseMessage =
            DocumentResponseMessage.fromJson(jsonDecode(response.body));
        // print(documentsResponseMessage);

        return documentsResponseMessage;
      } else {
        return DocumentResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return DocumentResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<ContractResponseMessage> getContracts(String companyID, token) async {
    String endpoint =
        '/api/contract/GetAllContractList/?CompanyID=${companyID}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        ContractResponseMessage contractResponseMessage =
            ContractResponseMessage.fromJson(jsonDecode(response.body));
        return contractResponseMessage;
      } else {
        return ContractResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return ContractResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<DocumentByIdResponseMessage> documentDetails(
      int docID, String token) async {
    String endpoint = '/api/Document/GetDocumentView/?DocID=${docID}';
    try {
      final response = await http.get(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        DocumentByIdResponseMessage results =
            DocumentByIdResponseMessage.fromJson(jsonDecode(response.body));
        return results;
      } else {
        return DocumentByIdResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return DocumentByIdResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<ForgotPassResponseMessage> createUser(String username) async {
    try {
      final response = await http.post(
        Uri.parse('http://34.251.31.12:8080' +
            '/api/user/UserForgotPassword?user=${username}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
        }),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        ForgotPassResponseMessage album =
            ForgotPassResponseMessage.fromJson(jsonDecode(response.body));
        return album;
      } else {
        return ForgotPassResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return ForgotPassResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<ResetPasswordResponseMessage> resetPass(
      String userID, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('http://34.251.31.12:8080' +
            '/api/user/UserForgotPasswordVerify?UserID=${userID}&OTP=${otp}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // body: jsonEncode(<String, String>{
        //   'userID': userID,
        // }),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        ResetPasswordResponseMessage tempPassword =
            ResetPasswordResponseMessage.fromJson(jsonDecode(response.body));
        return tempPassword;
      } else {
        return ResetPasswordResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return ResetPasswordResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<UserResetResponseMessage> userResetPass(
      String userID, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('http://34.251.31.12:8080' +
            '/api/user/UserResetPassword?UserID=${userID}&NewPassword=${newPassword}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // body: jsonEncode(<String, String>{
        //   'userID': userID,
        // }),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        UserResetResponseMessage results =
            UserResetResponseMessage.fromJson(jsonDecode(response.body));
        return results;
      } else {
        return UserResetResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return UserResetResponseMessage(message: "An errorr has ocuured");
    }
  }


  Future<ProfileResponseMessage> userprofile(
      String userID, String token) async {
    try {
      final response = await http.post(
        Uri.parse('http://34.251.31.12:8080' +
            '/api/user/GetUserByID/?id=${userID}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token,
        },
        // body: jsonEncode(<String, String>{
        //   'userID': userID,
        // }),
      );
      if (response.statusCode == 200) {
        ProfileResponseMessage results =
            ProfileResponseMessage.fromJson(jsonDecode(response.body));
        return results;
      } else {
        return ProfileResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return ProfileResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<TaskResponseMessage> tasks(String companyID, userID, token) async {
    String endpoint =
        '/api/Document/GetAllDocumentForApproval/?CompanyID=${companyID}&UserID=${userID}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        TaskResponseMessage taskResponseMessage =
            TaskResponseMessage.fromJson(jsonDecode(response.body));
        return taskResponseMessage;
      } else {
        return TaskResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return TaskResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<TaskByIdResponseMessage> taskDetails(int docID, String token) async {
    String endpoint = '/api/Document/GetDocumentView/?DocID=${docID}';
    try {
      final response = await http.get(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        TaskByIdResponseMessage results =
            TaskByIdResponseMessage.fromJson(jsonDecode(response.body));
        return results;
      } else {
        return TaskByIdResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return TaskByIdResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<GetOverdueTransactionsResponseMessage> overdueTransactions(
      String companyID, token) async {
    String endpoint =
        '/api/Dashboard/GetOverdueTransactions/?FinancerID=${companyID}&CompanyID=""';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        GetOverdueTransactionsResponseMessage
            getOverdueTransactionsResponseMessage =
            GetOverdueTransactionsResponseMessage.fromJson(
                jsonDecode(response.body));
        return getOverdueTransactionsResponseMessage;
      } else {
        return GetOverdueTransactionsResponseMessage(
            message: "An errorr has ocuured");
      }
    } catch (e) {
      return GetOverdueTransactionsResponseMessage(
          message: "An errorr has ocuured");
    }
  }

  Future<CustFinResponseMessage> customerFinancierSummary(
      String companyID, token) async {
    String endpoint =
        '/api/Dashboard/GetCompanySummary/?FinancerID=0&CompanyID=${companyID}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        CustFinResponseMessage custFinResponseMessage =
            CustFinResponseMessage.fromJson(jsonDecode(response.body));
        return custFinResponseMessage;
      } else {
        return CustFinResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return CustFinResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<RejectRespMessage> approveDocument(
      int docID, String userID, status, token) async {
    String endpoint =
        '/api/Document/DocumentStatusUpdate/?DocID=${docID}&UserID=${userID}&Status=${status}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        RejectRespMessage rejectRespMessage =
            RejectRespMessage.fromJson(jsonDecode(response.body));
        return rejectRespMessage;
      } else {
        return RejectRespMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return RejectRespMessage(message: "An errorr has ocuured");
    }
  }

  Future<RejectRespMessage> approveDoc(
      int docID, String userID, status, token) async {
    String endpoint =
        '/api/Document/DocumentStatusUpdate/?DocID=${docID}&UserID=${userID}&Status=${status}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        RejectRespMessage rejectRespMessage =
            RejectRespMessage.fromJson(jsonDecode(response.body));
        return rejectRespMessage;
      } else {
        return RejectRespMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return RejectRespMessage(message: "An errorr has ocuured");
    }
  }

  Future<FinancierResponseMessage> getFinancier(
      String companyID, String product, token) async {
    String endpoint =
        '/api/Document/GetFinancerList/?companyID=${companyID}&Product=${product}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        FinancierResponseMessage financierResponseMessage =
            FinancierResponseMessage.fromJson(jsonDecode(response.body));
        return financierResponseMessage;
      } else {
        return FinancierResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return FinancierResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<CustomerListResponseMessage> getCustomer(
      String companyID, financierID, product, token) async {
    String endpoint =
        '/api/Document/GetCompanyList/?companyID=${companyID}&FinancerID=${financierID}&Product=${product}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        CustomerListResponseMessage customerListResponseMessage =
            CustomerListResponseMessage.fromJson(jsonDecode(response.body));
        return customerListResponseMessage;
      } else {
        return CustomerListResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return CustomerListResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<ContractListResponseMessage> getContractList(
      String financierID, buyerID, supplierID, product, token) async {
    String endpoint =
        '/api/Document/GetContractList/?FinancerID=${financierID}&BuyerID=${buyerID}&SupplierID=${supplierID}&Product=${product}';

    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        ContractListResponseMessage contractListResponseMessage =
            ContractListResponseMessage.fromJson(jsonDecode(response.body));
        return contractListResponseMessage;
      } else {
        return ContractListResponseMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return ContractListResponseMessage(message: "An errorr has ocuured");
    }
  }

  Future<DocumentMessage> createDoc(product,contractID,companyID,buyerID,supplierID,financierID,currency,id,documentType,referenceNo,documentDate,maturityDate,amount,
  
  comments,createdBY,status,token) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://34.251.31.12:8080/api/Document/AddQuickDocument'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode(<String, Object>{
          "Product": product,
          "ContractID": contractID,
          "CompanyID": companyID,
          "BuyerID": buyerID,
          "SellerID": supplierID,
          "FinancerID": financierID,
          "MaturityDate": null,
          "Currency": '1',
          "TotalAmount": 0,
          "Comments": null,
          "CreatedBy": createdBY,
          "Status": null,
          "DocumentDetailsAdd": [
            {
              "ID": id,
              "DocumentType": documentType,
              "ReferenceNo": referenceNo,
              "BuyerCode": null,
              "SellerCode": null,
              "FinancerCode": null,
              "DocumentDate": documentDate,
              "MaturityDate": maturityDate,
              "Amount": amount,
              "Currency": null,
              "Comments": null
            },
          ]
        }),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        DocumentMessage documentMessage =
            DocumentMessage.fromJson(jsonDecode(response.body));
        return documentMessage;
      } else {
        return DocumentMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return DocumentMessage(message: "An errorr has ocuured");
    }
  }
   Future<DocumentMessage> editUser( userID,
        _titleController,
        _firstnameController,
        _lastnameController,
        _emailController,
        _altPhoneController,token) async {
    

    try {
      final response = await http.post(
        Uri.parse('http://34.251.31.12:8080/api/user/UpdateUser'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode(<String, Object>{
          "UserID": userID,
          "Title": _titleController,
          "FirstName": _firstnameController,
          "LastName": _lastnameController,
          "EmailAddress": _emailController,
          "PhoneNo": _altPhoneController,
          "ProfilePhoto": "",
          "SubNewsLetter": true,
          "SubEmailNotification": true,
          "UpdatedBy": userID
        }),
      );
      if (response.statusCode == 200) {
        DocumentMessage documentMessage =
            DocumentMessage.fromJson(jsonDecode(response.body));
        return documentMessage;
      } else {
        return DocumentMessage(message: "An errorr has ocuured");
      }
    } catch (e) {
      return DocumentMessage(message: "An errorr has ocuured");
    }
  }
}
