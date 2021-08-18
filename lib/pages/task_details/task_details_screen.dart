import 'package:flutter/material.dart';
import '../../widgets/notification_widget.dart';
import '../../widgets/popup_widget.dart';
import '../../configs/colors.dart';
import '../../configs/screen_configs.dart';
import '../../configs/constants.dart';
import '../../pages/tasks/tasks_screen.dart';
import '../../models/doc_rep_msg.dart';
import '../../models/reject_resp_msg.dart';
import '../../models/todo_dets_resp_msg.dart';
import '../../services/pdfApi.dart';
import '../../services/pdf_invoice_api.dart';
import '../../services/api_helper.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../models/user_details.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';



class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({Key key}) : super(key: key);
  static String routeName = '/task_details';

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
   bool isTaskResultEmpty = false;
  UserDetails userDetails;
  ApproveResult _approveResult;
  Documents documents;
  List<TaskDets> taskDetsResults;
  TaskByIdResponseMessage _taskByIdResponseMessage;
  RejectRespMessage _rejectRespMessage;

  DateTime currentDate = DateTime.now();
  var date, timestamp;

  bool _isLoading = false;
  var role;
  var compID;
  String message;
  String status;
  String approver_status;

  Future<List> _approveReject(String approver_status) async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));
    var documents = Documents.fromJson(
        await SharedPreferenceHelper.read(Configs.DOCUMENT_ID));

    var token = userDets.token;
    int docID = documents.docID;
    var idfrID = documents.idfrid;
    var userID = userDets.userID;
    approver_status;
    setState(() {
      _isLoading = true;
    });
    _rejectRespMessage =
        await APIHelper().approveDoc(docID, userID, approver_status, token);
    setState(() {
      _approveResult = _rejectRespMessage.result;
      _isLoading = false;
    });
  }

  Future<List> _approverApproveDoc(String approver_status) async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));
    var documents = Documents.fromJson(
        await SharedPreferenceHelper.read(Configs.DOCUMENT_ID));

    var token = userDets.token;
    int docID = documents.docID;
    var idfrID = documents.idfrid;
    var userID = userDets.userID;
    setState(() {
      _isLoading = true;
    });
    _rejectRespMessage =
        await APIHelper().approveDoc(docID, userID, status, token);
    setState(() {
      _approveResult = _rejectRespMessage.result;
      _isLoading = false;
    });
  }

  Future<List> _getTaskDetails() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));
    var documents = Documents.fromJson(
        await SharedPreferenceHelper.read(Configs.DOCUMENT_ID));
    var role_type = userDets.roleName;
    var token = userDets.token;
    var documentID = documents.docID;
    var companyID = userDets.companyID;

    setState(() {
      _isLoading = true;
    });
    _taskByIdResponseMessage = await APIHelper().taskDetails(documentID, token);

    setState(() {
      taskDetsResults = _taskByIdResponseMessage.result;
      role = role_type;
      compID = companyID;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getTaskDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.task_details),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: kBrightColor,
        iconTheme:
            IconThemeData(color: Colors.white, size: getSizeOfScreenHeight(45)),
        actions: [
         NamedIcon(),
          Padding(
            padding: EdgeInsets.only(top: getSizeOfScreenHeight(5)),
            child: PopupWidget(),
          ),
        ],
      ),
      body:  Container(
        width: MediaQuery.of(context).size.width,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
              )
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(taskDetsResults.isNotEmpty
                                    ? "${taskDetsResults[0].supplierName}"
                                    : ""),
                              )),
                          Expanded(
                              flex: 1,
                              child: ListTile(
                                  title: Text(
                                      taskDetsResults.isNotEmpty
                                          ? "${taskDetsResults[0].supplierName}"
                                          : "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  isThreeLine: true,
                                  subtitle: Text(taskDetsResults.isNotEmpty
                                      ? "Email: ${taskDetsResults[0].buyerEmail}"
                                      : ""))),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          taskDetsResults.isNotEmpty
                              ? taskDetsResults[0].ifrcViewDetails[0].docType
                              : "",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: ListTile(
                                  title: Text(Constants.buyer,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  isThreeLine: true,
                                  subtitle: Text(taskDetsResults.isNotEmpty
                                      ? "${taskDetsResults[0].buyerName}"
                                      : ""))),
                          Expanded(
                              flex: 2,
                              child: ListTile(
                                  title: Text(Constants.date_received,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  isThreeLine: true,
                                  subtitle: Text(taskDetsResults.isNotEmpty
                                      ? "${taskDetsResults[0].datecreated}"
                                      : ""))),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "${(DateFormat('d-M-yyyy').parse(taskDetsResults[0].dueDate)).compareTo(currentDate)}"),
                      GFAccordion(
                          title: Constants.financial_info.toUpperCase(),
                          contentChild: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: ListTile(
                                      title: Text(Constants.due_date),
                                      isThreeLine: true,
                                      subtitle: Text(taskDetsResults.isNotEmpty
                                          ? "${taskDetsResults[0].dueDate}\n Currency: ${taskDetsResults[0].currency}"
                                          : ""))),
                              Expanded(
                                  flex: 2,
                                  child: ListTile(
                                      title: Text(taskDetsResults.isNotEmpty
                                          ? "${Constants.max_tenor} ${taskDetsResults[0].maximumTenor}"
                                          : ""),
                                      isThreeLine: true,
                                      subtitle: Text(taskDetsResults.isNotEmpty
                                          ? "${Constants.financial_tenor}	${taskDetsResults[0].financingTenor}"
                                          : ""))),
                            ],
                          ),
                          collapsedIcon: Icon(Icons.add),
                          expandedIcon: Icon(Icons.minimize)),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: DataTable(
                            headingRowColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              return Colors.grey[300];
                            }),
                            showBottomBorder: true,
                            columns: <DataColumn>[
                              // DataColumn(label: Text("Total")),
                              DataColumn(label: Text(Constants.ref_no)),
                              DataColumn(label: Text(Constants.amount)),
                              DataColumn(label: Text(Constants.net_amount)),
                            ],
                            rows: <DataRow>[
                              DataRow(cells: <DataCell>[
                                DataCell(Text(taskDetsResults.isEmpty
                                    ? ""
                                    : "${taskDetsResults[0].docRefNo}")),
                                DataCell(Text(taskDetsResults.isEmpty
                                    ? ""
                                    : "${taskDetsResults[0].totalAmount}	")),
                                DataCell(Text(taskDetsResults.isEmpty
                                    ? ""
                                    : "${taskDetsResults[0].settlementAmount}")),
                              ]),
                              DataRow(cells: <DataCell>[
                                DataCell(Text(
                                  taskDetsResults.isEmpty ? "" : Constants.total,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  taskDetsResults.isEmpty
                                      ? ""
                                      : "${taskDetsResults[0].totalAmount}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  taskDetsResults.isEmpty
                                      ? ""
                                      : "${taskDetsResults[0].settlementAmount}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ])
                            ]),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 30.0, right: 15.0, left: 15.0),
                          child: Column(
                            children: <Widget>[
                              role == Constants.maker
                                  ? buildMaker(context)
                                  : role == Constants.checker
                                      ? buildChecker(context)
                                      : role == Constants.maker_checker
                                          ? buildMakerChecker(context)
                                          : role == Constants.maker_approver
                                              ? buildMakerApprover(context)
                                              : role == Constants.approver
                                                  ? Container(
                                                      child: Column(
                                                      children: [
                                                        Text(Constants
                                                                .last_status +
                                                            taskDetsResults[0]
                                                                .lastStatus),
                                                        Text(Constants
                                                                .requested_by +
                                                            taskDetsResults[0]
                                                                .creatorName +
                                                            "(${taskDetsResults[0].datecreated})"),
                                                        Text(Constants
                                                                .checked_by +
                                                            taskDetsResults[0]
                                                                .checkerName +
                                                            "(${taskDetsResults[0].checkedDate})"),
                                                        taskDetsResults[0]
                                                                        .lastStatus ==
                                                                    Constants
                                                                        .checked &&
                                                                taskDetsResults[0]
                                                                        .sellerID ==
                                                                    compID &&
                                                                taskDetsResults[0]
                                                                        .pendingLimitSeller >
                                                                    taskDetsResults[0]
                                                                        .totalAmount
                                                            ? Row(
                                                                children: [
                                                                  _approveButton(
                                                                    btnBgColor:
                                                                        Colors
                                                                            .blue,
                                                                    btnText:
                                                                        Constants
                                                                            .approve,
                                                                    onClick:
                                                                        () {
                                                                      approver_status =
                                                                          Constants
                                                                              .approver_approved;

                                                                      _approveReject(
                                                                          approver_status);
                                                                      if (_approveResult
                                                                              .message !=
                                                                          null) {
                                                                        message =
                                                                            _approveResult.message;
                                                                        status =
                                                                            _approveResult.status;
                                                                        buildShowDialog(
                                                                            context);
                                                                      } else {}
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                    width: 12.0,
                                                                  ),
                                                                  _approveButton(
                                                                    btnBgColor:
                                                                        Colors
                                                                            .blue,
                                                                    btnText:
                                                                        Constants
                                                                            .rejected,
                                                                    onClick:
                                                                        () {
                                                                      approver_status =
                                                                          Constants
                                                                              .approver_rejected;

                                                                      _approveReject(
                                                                          approver_status);
                                                                      if (_approveResult
                                                                              .message !=
                                                                          null) {
                                                                        message =
                                                                            _approveResult.message;
                                                                        status =
                                                                            _approveResult.status;
                                                                        buildShowDialog(
                                                                            context);
                                                                      } else {}
                                                                    },
                                                                  )
                                                                ],
                                                              )
                                                            : taskDetsResults[0]
                                                                            .lastStatus ==
                                                                        Constants
                                                                            .checked &&
                                                                    taskDetsResults[0]
                                                                            .sellerID ==
                                                                        compID &&
                                                                    taskDetsResults[0]
                                                                            .pendingLimitSeller <
                                                                        taskDetsResults[0]
                                                                            .totalAmount
                                                                ? Row(
                                                                    children: [
                                                                      Text(
                                                                        Constants
                                                                            .approval_limit,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : taskDetsResults[0].lastStatus == Constants.approver_approved &&
                                                                        taskDetsResults[0].sellerID !=
                                                                            compID &&
                                                                        taskDetsResults[0].pendingLimitBuyer <
                                                                            taskDetsResults[0]
                                                                                .totalAmount
                                                                    ? Row(
                                                                        children: [
                                                                          _approveButton(
                                                                            btnBgColor:
                                                                                Colors.blue,
                                                                            btnText:
                                                                                Constants.approve,
                                                                            onClick:
                                                                                () {
                                                                              approver_status = Constants.buyer_approved;

                                                                              _approveReject(approver_status);
                                                                              if (_approveResult.message != null) {
                                                                                message = _approveResult.message;
                                                                                status = _approveResult.status;
                                                                                buildShowDialog(context);
                                                                              } else {}
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                12.0,
                                                                          ),
                                                                          _approveButton(
                                                                            btnBgColor:
                                                                                Colors.blue,
                                                                            btnText:
                                                                                Constants.rejected,
                                                                            onClick:
                                                                                () {
                                                                              approver_status = Constants.buyer_rejected;

                                                                              _approveReject(approver_status);
                                                                              if (_approveResult.message != null) {
                                                                                message = _approveResult.message;
                                                                                status = _approveResult.status;
                                                                                buildShowDialog(context);
                                                                              } else {}
                                                                            },
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : taskDetsResults[0].lastStatus == Constants.checked &&
                                                                            taskDetsResults[0].sellerID ==
                                                                                compID &&
                                                                            taskDetsResults[0].pendingLimitSeller < taskDetsResults[0].totalAmount
                                                                        ? Row(
                                                                            children: [
                                                                              Text(
                                                                                Constants.approval_limit,
                                                                                style: TextStyle(color: Colors.red),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Container(
                                                                            child: Column(
                                                                            children: [
                                                                              Text(taskDetsResults[0].checkerName != null ? Constants.checked_by + taskDetsResults[0].checkerName + "(${taskDetsResults[0].checkedDate})" : ""),
                                                                              Text(taskDetsResults[0].approverName != null ? Constants.approved_by + taskDetsResults[0].approverName + "(${taskDetsResults[0].approvedDate})" : ""),
                                                                              Text(taskDetsResults[0].oppPartyApproverName != null ? Constants.buyer_approved_by + taskDetsResults[0].oppPartyApproverName + "(${taskDetsResults[0].oppPartyApprovedDate})" : ""),
                                                                            ],
                                                                          ))
                                                      ],
                                                    ))
                                                  : role ==
                                                          Constants
                                                              .maker_checker_approver
                                                      ? Container(
                                                          child: Column(
                                                              children: [
                                                              Text(Constants
                                                                      .last_status +
                                                                  taskDetsResults[
                                                                          0]
                                                                      .lastStatus),
                                                              Text(Constants
                                                                      .requested_by +
                                                                  taskDetsResults[
                                                                          0]
                                                                      .creatorName +
                                                                  "(${taskDetsResults[0].datecreated})"),
                                                              Text(taskDetsResults[
                                                                              0]
                                                                          .checkerName !=
                                                                      null
                                                                  ? Constants
                                                                          .checked_by +
                                                                      taskDetsResults[
                                                                              0]
                                                                          .checkerName +
                                                                      "(${taskDetsResults[0].checkedDate})"
                                                                  : ""),
                                                              Text(taskDetsResults[
                                                                              0]
                                                                          .approverName !=
                                                                      null
                                                                  ? Constants
                                                                          .approved_by +
                                                                      taskDetsResults[
                                                                              0]
                                                                          .approverName +
                                                                      "(${taskDetsResults[0].approvedDate})"
                                                                  : ""),
                                                              Text(taskDetsResults[
                                                                              0]
                                                                          .oppPartyApproverName !=
                                                                      null
                                                                  ? Constants
                                                                          .buyer_approved_by +
                                                                      taskDetsResults[
                                                                              0]
                                                                          .oppPartyApproverName +
                                                                      "(${taskDetsResults[0].oppPartyApprovedDate})"
                                                                  : ""),
                                                              taskDetsResults[0]
                                                                          .isOppPartyApproved &&
                                                                      taskDetsResults[0]
                                                                              .lastStatus ==
                                                                          Constants
                                                                              .buyer_approved
                                                                  ? Container(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          taskDetsResults[0].sellerID == compID
                                                                              ? _approveButton(
                                                                                  btnBgColor: Colors.blue,
                                                                                  btnText: Constants.send_discount_request,
                                                                                  onClick: () {
                                                                                    approver_status = Constants.sent_to_financier;
                                                                                    _approveReject(approver_status);
                                                                                    if (_approveResult.message != null) {
                                                                                      message = _approveResult.message;
                                                                                      status = _approveResult.status;
                                                                                      buildShowDialog(context);
                                                                                    } else {}
                                                                                  },
                                                                                )
                                                                              : taskDetsResults[0].buyerID == taskDetsResults[0].creatorCompanyID
                                                                                  ? _approveButton(
                                                                                      btnBgColor: Colors.blue,
                                                                                      btnText: Constants.send_discount_request,
                                                                                      onClick: () {
                                                                                        approver_status = Constants.sent_to_financier;
                                                                                        _approveReject(approver_status);
                                                                                        if (_approveResult.message != null) {
                                                                                          message = _approveResult.message;
                                                                                          status = _approveResult.status;
                                                                                          buildShowDialog(context);
                                                                                        } else {}
                                                                                      },
                                                                                    )
                                                                                  : Container()
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : taskDetsResults[0].lastStatus ==
                                                                              Constants
                                                                                  .draft &&
                                                                          taskDetsResults[0].sellerID ==
                                                                              compID
                                                                      ? Row(
                                                                          children: [
                                                                            _approveButton(
                                                                              btnBgColor: Colors.blue,
                                                                              btnText: Constants.check,
                                                                              onClick: () {
                                                                                _approveReject(approver_status);
                                                                                approver_status = Constants.checked;
                                                                                if (_approveResult.message != null) {
                                                                                  message = _approveResult.message;
                                                                                  status = _approveResult.status;
                                                                                  buildShowDialog(context);
                                                                                } else {}
                                                                              },
                                                                            ),
                                                                            SizedBox(
                                                                              width: 12.0,
                                                                            ),
                                                                            _approveButton(
                                                                              btnBgColor: Colors.blue,
                                                                              btnText: Constants.rejected,
                                                                              onClick: () {
                                                                                _approveReject(approver_status);
                                                                                approver_status = Constants.checker_rejected;
                                                                                if (_approveResult.message != null) {
                                                                                  message = _approveResult.message;
                                                                                  status = _approveResult.status;
                                                                                  buildShowDialog(context);
                                                                                } else {}
                                                                              },
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : taskDetsResults[0].lastStatus == Constants.checked &&
                                                                              taskDetsResults[0].sellerID == compID
                                                                          ? Container(
                                                                              child: Column(
                                                                                children: [
                                                                                  Text("Constants.checked_by: ${taskDetsResults[0].checkerName}" + "(${taskDetsResults[0].checkedDate})"),
                                                                                  Row(
                                                                                    children: [
                                                                                      _approveButton(
                                                                                        btnBgColor: Colors.blue,
                                                                                        btnText: Constants.approve,
                                                                                        onClick: () {
                                                                                          approver_status = Constants.approver_approved;

                                                                                          _approveReject(approver_status);
                                                                                          if (_approveResult.message != null) {
                                                                                            message = _approveResult.message;
                                                                                            status = _approveResult.status;
                                                                                            buildShowDialog(context);
                                                                                          } else {}
                                                                                        },
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 12.0,
                                                                                      ),
                                                                                      _approveButton(
                                                                                        btnBgColor: Colors.blue,
                                                                                        btnText: Constants.rejected,
                                                                                        onClick: () {
                                                                                          approver_status = Constants.approver_rejected;

                                                                                          _approveReject(approver_status);
                                                                                          if (_approveResult.message != null) {
                                                                                            message = _approveResult.message;
                                                                                            status = _approveResult.status;
                                                                                            buildShowDialog(context);
                                                                                          } else {}
                                                                                        },
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : taskDetsResults[0].lastStatus == Constants.approver_approved && taskDetsResults[0].sellerID != compID
                                                                              ? Row(
                                                                                  children: [
                                                                                    _approveButton(
                                                                                      btnBgColor: Colors.blue,
                                                                                      btnText: Constants.approve,
                                                                                      onClick: () {
                                                                                        approver_status = Constants.buyer_approved;

                                                                                        _approveReject(approver_status);
                                                                                        if (_approveResult.message != null) {
                                                                                          message = _approveResult.message;
                                                                                          status = _approveResult.status;
                                                                                          buildShowDialog(context);
                                                                                        } else {}
                                                                                      },
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 12.0,
                                                                                    ),
                                                                                    _approveButton(
                                                                                      btnBgColor: Colors.blue,
                                                                                      btnText: Constants.rejected,
                                                                                      onClick: () {
                                                                                        approver_status = Constants.buyer_rejected;

                                                                                        _approveReject(approver_status);
                                                                                        if (_approveResult.message != null) {
                                                                                          message = _approveResult.message;
                                                                                          status = _approveResult.status;
                                                                                          buildShowDialog(context);
                                                                                        } else {}
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              : Container(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Text(taskDetsResults[0].checkerName != null ? Constants.checked_by + taskDetsResults[0].checkerName + "(${taskDetsResults[0].checkedDate})" : ""),
                                                                                      Text(taskDetsResults[0].approverName != null ? Constants.approved_by + taskDetsResults[0].approverName + "(${taskDetsResults[0].approvedDate})" : ""),
                                                                                      Text(taskDetsResults[0].oppPartyApproverName != null ? Constants.buyer_approved_by + taskDetsResults[0].oppPartyApproverName + "(${taskDetsResults[0].oppPartyApprovedDate})" : ""),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                            ]))
                                                      : Container(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: _loginBtn(
                                  text: "Download PDF",
                                  onClick: () async {
                                    // print(taskDetsResults);
                                    final pdfFile =
                                        await PdfInvoiceApi.generateInvoice(
                                            taskDetsResults);
                                    PdfApi.openFile(pdfFile);
                                  },
                                  bgColor: Color(0xccF45C2C),
                                  textColor: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: _loginBtn(
                              text: Constants.cancel,
                              onClick: () {
                                Navigator.pushNamed(
                                    context, TasksScreen.routeName);
                              },
                              bgColor: Colors.white,
                              textColor: Color(0xccF45C2C),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )));
  }

  Container buildMakerApprover(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(Constants.last_status + taskDetsResults[0].lastStatus),
          Text(Constants.requested_by +
              taskDetsResults[0].creatorName +
              "(${taskDetsResults[0].datecreated})"),
          taskDetsResults[0].lastStatus == Constants.checker_rejected
              ? Container()
              : Container(
                  child: Column(
                    children: [
                      Text(taskDetsResults[0].checkerName != null
                          ? Constants.checked_by +
                              taskDetsResults[0].checkerName +
                              "(${taskDetsResults[0].checkedDate})"
                          : ""),
                      Text(taskDetsResults[0].approverName != null
                          ? Constants.approved_by +
                              taskDetsResults[0].approverName +
                              "(${taskDetsResults[0].approvedDate})"
                          : ""),
                      Text(taskDetsResults[0].oppPartyApproverName != null
                          ? Constants.buyer_approved_by +
                              taskDetsResults[0].oppPartyApproverName +
                              "(${taskDetsResults[0].oppPartyApprovedDate})"
                          : ""),
                    ],
                  ),
                ),
          taskDetsResults[0].isOppPartyApproved &&
                  taskDetsResults[0].lastStatus == Constants.buyer_approved
              ? Container(
                  child: Row(
                    children: [
                      taskDetsResults[0].sellerID == compID
                          ? _approveButton(
                              btnBgColor: Colors.blue,
                              btnText: Constants.send_discount_request,
                              onClick: () {
                                approver_status = Constants.sent_to_financier;
                                _approveReject(approver_status);
                                if (_approveResult.message != null) {
                                  message = _approveResult.message;
                                  status = _approveResult.status;
                                  buildShowDialog(context);
                                } else {}
                              },
                            )
                          : taskDetsResults[0].buyerID ==
                                  taskDetsResults[0].creatorCompanyID
                              ? _approveButton(
                                  btnBgColor: Colors.blue,
                                  btnText: Constants.send_discount_request,
                                  onClick: () {
                                    approver_status =
                                        Constants.sent_to_financier;
                                    _approveReject(approver_status);
                                    if (_approveResult.message != null) {
                                      message = _approveResult.message;
                                      status = _approveResult.status;
                                      buildShowDialog(context);
                                    } else {}
                                  },
                                )
                              : Container()
                    ],
                  ),
                )
              : taskDetsResults[0].lastStatus == Constants.checked &&
                      taskDetsResults[0].sellerID == compID
                  ? Row(
                      children: [
                        _approveButton(
                          btnBgColor: Colors.blue,
                          btnText: Constants.approve,
                          onClick: () {
                            approver_status = Constants.approver_approved;

                            _approveReject(approver_status);
                            if (_approveResult.message != null) {
                              message = _approveResult.message;
                              status = _approveResult.status;
                              buildShowDialog(context);
                            } else {}
                          },
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        _approveButton(
                          btnBgColor: Colors.blue,
                          btnText: Constants.rejected,
                          onClick: () {
                            approver_status = Constants.approver_rejected;

                            _approveReject(approver_status);
                            if (_approveResult.message != null) {
                              message = _approveResult.message;
                              status = _approveResult.status;
                              buildShowDialog(context);
                            } else {}
                          },
                        )
                      ],
                    )
                  : taskDetsResults[0].lastStatus ==
                              Constants.approver_approved &&
                          taskDetsResults[0].sellerID != compID
                      ? Row(
                          children: [
                            _approveButton(
                              btnBgColor: Colors.blue,
                              btnText: Constants.approve,
                              onClick: () {
                                approver_status = Constants.buyer_approved;

                                _approveReject(approver_status);
                                if (_approveResult.message != null) {
                                  message = _approveResult.message;
                                  status = _approveResult.status;
                                  buildShowDialog(context);
                                } else {}
                              },
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            _approveButton(
                              btnBgColor: Colors.blue,
                              btnText: Constants.rejected,
                              onClick: () {
                                approver_status = Constants.buyer_rejected;

                                _approveReject(approver_status);
                                if (_approveResult.message != null) {
                                  message = _approveResult.message;
                                  status = _approveResult.status;
                                  buildShowDialog(context);
                                } else {}
                              },
                            ),
                          ],
                        )
                      : Container(
                          child: Column(
                          children: [
                            Text(taskDetsResults[0].checkerName != null
                                ? Constants.checked_by +
                                    taskDetsResults[0].checkerName +
                                    "(${taskDetsResults[0].checkedDate})"
                                : ""),
                            Text(taskDetsResults[0].approverName != null
                                ? Constants.approved_by +
                                    taskDetsResults[0].approverName +
                                    "(${taskDetsResults[0].approvedDate})"
                                : ""),
                            Text(taskDetsResults[0].oppPartyApproverName != null
                                ? Constants.buyer_approved_by +
                                    taskDetsResults[0].oppPartyApproverName +
                                    "(${taskDetsResults[0].oppPartyApprovedDate})"
                                : ""),
                          ],
                        )),
        ],
      ),
    );
  }

  Container buildMakerChecker(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(Constants.last_status + taskDetsResults[0].lastStatus),
          Text(Constants.requested_by +
              taskDetsResults[0].creatorName +
              "(${taskDetsResults[0].datecreated})"),
          taskDetsResults[0].lastStatus == Constants.checker_rejected
              ? Container()
              : Container(
                  child: Column(
                    children: [
                      Text(taskDetsResults[0].checkerName != null
                          ? Constants.checked_by +
                              taskDetsResults[0].checkerName +
                              "(${taskDetsResults[0].checkedDate})"
                          : ""),
                      Text(taskDetsResults[0].approverName != null
                          ? Constants.approved_by +
                              taskDetsResults[0].approverName +
                              "(${taskDetsResults[0].approvedDate})"
                          : ""),
                      Text(taskDetsResults[0].oppPartyApproverName != null
                          ? Constants.buyer_approved_by +
                              taskDetsResults[0].oppPartyApproverName +
                              "(${taskDetsResults[0].oppPartyApprovedDate})"
                          : ""),
                    ],
                  ),
                ),
          taskDetsResults[0].isOppPartyApproved &&
                  taskDetsResults[0].lastStatus == Constants.buyer_approved
              ? Container(
                  child: Row(
                    children: [
                      taskDetsResults[0].sellerID == compID
                          ? _approveButton(
                              btnBgColor: Colors.blue,
                              btnText: Constants.send_discount_request,
                              onClick: () {
                                approver_status = Constants.sent_to_financier;
                                _approveReject(approver_status);
                                if (_approveResult.message != null) {
                                  message = _approveResult.message;
                                  status = _approveResult.status;
                                  buildShowDialog(context);
                                } else {}
                              },
                            )
                          : taskDetsResults[0].buyerID ==
                                  taskDetsResults[0].creatorCompanyID
                              ? _approveButton(
                                  btnBgColor: Colors.blue,
                                  btnText: Constants.send_discount_request,
                                  onClick: () {
                                    approver_status =
                                        Constants.sent_to_financier;
                                    _approveReject(approver_status);
                                    if (_approveResult.message != null) {
                                      message = _approveResult.message;
                                      status = _approveResult.status;
                                      buildShowDialog(context);
                                    } else {}
                                  },
                                )
                              : Container()
                    ],
                  ),
                )
              : taskDetsResults[0].lastStatus == Constants.draft &&
                      taskDetsResults[0].sellerID == compID
                  ? Row(
                      children: [
                        _approveButton(
                          btnBgColor: Colors.blue,
                          btnText: Constants.check,
                          onClick: () {
                            _approveReject(approver_status);
                            approver_status = Constants.checked;
                            if (_approveResult.message != null) {
                              message = _approveResult.message;
                              status = _approveResult.status;
                              buildShowDialog(context);
                            } else {}
                          },
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        _approveButton(
                          btnBgColor: Colors.blue,
                          btnText: Constants.rejected,
                          onClick: () {
                            _approveReject(approver_status);
                            approver_status = Constants.checker_rejected;
                            if (_approveResult.message != null) {
                              message = _approveResult.message;
                              status = _approveResult.status;
                              buildShowDialog(context);
                            } else {}
                          },
                        ),
                      ],
                    )
                  : Container(
                      child: Column(
                        children: [
                          Text(taskDetsResults[0].checkerName != null
                              ? Constants.checked_by +
                                  taskDetsResults[0].checkerName +
                                  "(${taskDetsResults[0].checkedDate})"
                              : ""),
                          Text(taskDetsResults[0].approverName != null
                              ? Constants.buyer_approved_by +
                                  taskDetsResults[0].approverName +
                                  "(${taskDetsResults[0].approvedDate})"
                              : ""),
                          Text(taskDetsResults[0].oppPartyApproverName != null
                              ? Constants.buyer_approved_by +
                                  taskDetsResults[0].oppPartyApproverName +
                                  "(${taskDetsResults[0].oppPartyApprovedDate})"
                              : ""),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }

  Container buildChecker(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(Constants.last_status + taskDetsResults[0].lastStatus),
          Text(Constants.requested_by +
              taskDetsResults[0].creatorName +
              "(${taskDetsResults[0].datecreated})"),
          taskDetsResults[0].lastStatus == Constants.draft &&
                  taskDetsResults[0].sellerID == compID &&
                  (DateFormat('d-M-yyyy').parse(taskDetsResults[0].dueDate))
                          .compareTo(currentDate) >
                      0
              ? Row(
                  children: [
                    _approveButton(
                      btnBgColor: Colors.blue,
                      btnText: Constants.check,
                      onClick: () {
                        _approveReject(approver_status);
                        approver_status = Constants.checked;
                        if (_approveResult.message != null) {
                          message = _approveResult.message;
                          status = _approveResult.status;
                          buildShowDialog(context);
                        } else {}
                      },
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    _approveButton(
                      btnBgColor: Colors.blue,
                      btnText: Constants.rejected,
                      onClick: () {
                        _approveReject(approver_status);
                        approver_status = Constants.checker_rejected;
                        if (_approveResult.message != null) {
                          message = _approveResult.message;
                          status = _approveResult.status;
                          buildShowDialog(context);
                        } else {}
                      },
                    ),
                  ],
                )
              : taskDetsResults[0].lastStatus == Constants.draft &&
                      taskDetsResults[0].sellerID == compID &&
                      (DateFormat('d-M-yyyy').parse(taskDetsResults[0].dueDate))
                              .compareTo(currentDate) >
                          0
                  ? Text("Document Maturity date has passed")
                  : Container(
                      child: Column(
                        children: [
                          Text(taskDetsResults[0].checkerName != null
                              ? Constants.checked_by +
                                  taskDetsResults[0].checkerName +
                                  "(${taskDetsResults[0].checkedDate})"
                              : ""),
                          Text(taskDetsResults[0].approverName != null
                              ? Constants.buyer_approved_by +
                                  taskDetsResults[0].approverName +
                                  "(${taskDetsResults[0].approvedDate})"
                              : ""),
                          Text(taskDetsResults[0].oppPartyApproverName != null
                              ? Constants.buyer_approved_by +
                                  taskDetsResults[0].oppPartyApproverName +
                                  "(${taskDetsResults[0].oppPartyApprovedDate})"
                              : ""),
                        ],
                      ),
                    ),
        ],
      ),
    );
  }

  Container buildMaker(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(Constants.last_status + taskDetsResults[0].lastStatus),
          Text(Constants.requested_by +
              taskDetsResults[0].creatorName +
              "(${taskDetsResults[0].datecreated})"),
          taskDetsResults[0].lastStatus == Constants.checker_rejected
              ? Container()
              : Container(
                  child: Column(
                    children: [
                      Text(taskDetsResults[0].checkerName != null
                          ? Constants.checked_by +
                              taskDetsResults[0].checkerName +
                              "(${taskDetsResults[0].checkedDate})"
                          : ""),
                      Text(taskDetsResults[0].approverName != null
                          ? Constants.approved_by +
                              taskDetsResults[0].approverName +
                              "(${taskDetsResults[0].approvedDate})"
                          : ""),
                      Text(taskDetsResults[0].oppPartyApproverName != null
                          ? Constants.buyer_approved_by +
                              taskDetsResults[0].oppPartyApproverName +
                              "(${taskDetsResults[0].oppPartyApprovedDate})"
                          : ""),
                    ],
                  ),
                ),
          taskDetsResults[0].isOppPartyApproved &&
                  taskDetsResults[0].lastStatus == Constants.buyer_approved
              ? Container(
                  child: Row(
                    children: [
                      taskDetsResults[0].sellerID == compID
                          ? _approveButton(
                              btnBgColor: Colors.blue,
                              btnText: Constants.send_discount_request,
                              onClick: () {
                                approver_status = Constants.sent_to_financier;
                                _approveReject(approver_status);
                                if (_approveResult.message != null) {
                                  message = _approveResult.message;
                                  status = _approveResult.status;
                                  buildShowDialog(context);
                                } else {}
                              },
                            )
                          : taskDetsResults[0].buyerID ==
                                  taskDetsResults[0].creatorCompanyID
                              ? _approveButton(
                                  btnBgColor: Colors.blue,
                                  btnText: Constants.send_discount_request,
                                  onClick: () {
                                    approver_status =
                                        Constants.sent_to_financier;
                                    _approveReject(approver_status);
                                    if (_approveResult.message != null) {
                                      message = _approveResult.message;
                                      status = _approveResult.status;
                                      buildShowDialog(context);
                                    } else {}
                                  },
                                )
                              : Container()
                    ],
                  ),
                )
              : TextButton(),
        ],
      ),
    );
  }
   Future buildShowDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(status),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
            ));
  }

  Widget _textInput(String label) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(label),
    );
  }

  Widget _textInputBold(
    String label,
  ) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _loginBtn({text, onClick, bgColor, textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            primary: bgColor),
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }

  Widget _approveButton({btnBgColor, onClick, btnText}) {
    return Expanded(
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: btnBgColor,
          ),
          onPressed: onClick,
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
