import 'package:flutter/material.dart';
import '../models/doc_rep_msg.dart';
import '../models/login_resp_msg.dart';
import '../models/reject_resp_msg.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../models/todo_dets_resp_msg.dart';
import '../services/api_helper.dart';
import '../services/pdfApi.dart';
import '../services/pdf_invoice_api.dart';
import 'package:getwidget/getwidget.dart';

class TaskDetails extends StatefulWidget {
  TaskDetails({Key key}) : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  UserDetails userDetails;
  ApproveResult _approveResult;
  Documents documents;
  List<TaskDets> taskDetsResults;
  TaskByIdResponseMessage _taskByIdResponseMessage;
  RejectRespMessage _rejectRespMessage;

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
    // String status = "Checker Rejected";
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
    taskDetsResults = [];

    _getTaskDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.black54,
                            iconSize: 30.0,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.notifications_none),
                            color: Colors.black54,
                            iconSize: 30.0,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      "${taskDetsResults[0].supplierName}"),
                                )),
                            Expanded(
                                flex: 1,
                                child: ListTile(
                                    title: Text(
                                        "${taskDetsResults[0].supplierName}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    isThreeLine: true,
                                    subtitle: Text(
                                        "Email: ${taskDetsResults[0].buyerEmail}"))),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(taskDetsResults[0].ifrcViewDetails[0].docType,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: ListTile(
                                    title: Text("Buyer: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    isThreeLine: true,
                                    subtitle: Text(
                                        "${taskDetsResults[0].buyerName}"))),
                            Expanded(
                                flex: 2,
                                child: ListTile(
                                    title: Text("Date Received :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    isThreeLine: true,
                                    subtitle: Text(
                                        "${taskDetsResults[0].datecreated}"))),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GFAccordion(
                            title: 'FINANCIAL INFORMATION',
                            contentChild: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: ListTile(
                                        title: Text("Due date: "),
                                        isThreeLine: true,
                                        subtitle: Text(
                                            "${taskDetsResults[0].dueDate}\n Currency: ${taskDetsResults[0].currency}"))),
                                Expanded(
                                    flex: 2,
                                    child: ListTile(
                                        title: Text(
                                            "Maximum Tenor: ${taskDetsResults[0].maximumTenor}"),
                                        isThreeLine: true,
                                        subtitle: Text(
                                            "Financing Tenor:	${taskDetsResults[0].financingTenor}"))),
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
                        DataTable(
                            headingRowColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              return Colors.grey[300];
                            }),
                            showBottomBorder: true,
                            columns: <DataColumn>[
                              // DataColumn(label: Text("Total")),
                              DataColumn(label: Text("Ref No")),
                              DataColumn(label: Text("Amount")),
                              DataColumn(label: Text("Net Amount")),
                            ],
                            rows: <DataRow>[
                              DataRow(cells: <DataCell>[
                                DataCell(
                                    Text("${taskDetsResults[0].docRefNo}")),
                                DataCell(
                                    Text("${taskDetsResults[0].totalAmount}	")),
                                DataCell(Text(
                                    "${taskDetsResults[0].settlementAmount}")),
                              ]),
                              DataRow(cells: <DataCell>[
                                DataCell(Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  "${taskDetsResults[0].totalAmount}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                                DataCell(Text(
                                  "${taskDetsResults[0].settlementAmount}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ])
                            ]),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 30.0, right: 15.0, left: 15.0),
                            child: Column(
                              children: <Widget>[
                                role == 'Maker'
                                    ? Container(
                                        child: Column(
                                          children: [
                                            Text("Last Status: " +
                                                taskDetsResults[0].lastStatus),
                                            Text("Requested By: " +
                                                taskDetsResults[0].creatorName +
                                                "(${taskDetsResults[0].datecreated})"),
                                            taskDetsResults[0].lastStatus ==
                                                    "Checker Rejected"
                                                ? Container()
                                                : Container(
                                                    child: Column(
                                                      children: [
                                                        Text(taskDetsResults[0]
                                                                    .checkerName !=
                                                                null
                                                            ? "Checked By: " +
                                                                taskDetsResults[
                                                                        0]
                                                                    .checkerName +
                                                                "(${taskDetsResults[0].checkedDate})"
                                                            : ""),
                                                        Text(taskDetsResults[0]
                                                                    .approverName !=
                                                                null
                                                            ? "Approved By: " +
                                                                taskDetsResults[
                                                                        0]
                                                                    .approverName +
                                                                "(${taskDetsResults[0].approvedDate})"
                                                            : ""),
                                                        Text(taskDetsResults[0]
                                                                    .oppPartyApproverName !=
                                                                null
                                                            ? "Buyer Approved By: " +
                                                                taskDetsResults[
                                                                        0]
                                                                    .oppPartyApproverName +
                                                                "(${taskDetsResults[0].oppPartyApprovedDate})"
                                                            : ""),
                                                      ],
                                                    ),
                                                  ),
                                            taskDetsResults[0]
                                                        .isOppPartyApproved &&
                                                    taskDetsResults[0]
                                                            .lastStatus ==
                                                        "Buyer Approved"
                                                ? Container(
                                                    child: Row(
                                                      children: [
                                                        taskDetsResults[0]
                                                                    .sellerID ==
                                                                compID
                                                            ? _approveButton(btnBgColor: Colors.blue, btnText: "Send Discount Request", onClick: () {
                                                                  approver_status =
                                                                      'Sent To Financier';
                                                                  _approveReject(
                                                                      approver_status);
                                                                  if (_approveResult
                                                                          .message !=
                                                                      null) {
                                                                    message =
                                                                        _approveResult
                                                                            .message;
                                                                    status =
                                                                        _approveResult
                                                                            .status;
                                                                    buildShowDialog(context);
                                                                  } else {}
                                                                },)
                                                            : taskDetsResults[0]
                                                                        .buyerID ==
                                                                    taskDetsResults[
                                                                            0]
                                                                        .creatorCompanyID
                                                                ? _approveButton(
                                                                    btnBgColor:
                                                                        Colors
                                                                            .blue,
                                                                    btnText:
                                                                        "Send Discount Request",
                                                                    onClick:
                                                                        () {
                                                                      approver_status =
                                                                          'Sent To Financier';
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
                                                                : Container()
                                                      ],
                                                    ),
                                                  )
                                                : TextButton(),
                                          ],
                                        ),
                                      )
                                    : role == 'Checker'
                                        ? Container(
                                            child: Column(
                                              children: [
                                                Text("Last Status: " +
                                                    taskDetsResults[0]
                                                        .lastStatus),
                                                Text("Requested By: " +
                                                    taskDetsResults[0]
                                                        .creatorName +
                                                    "(${taskDetsResults[0].datecreated})"),
                                                taskDetsResults[0].lastStatus ==
                                                            "Draft" &&
                                                        taskDetsResults[0]
                                                                .sellerID ==
                                                            compID
                                                    ? Row(
                                                        children: [
                                                          _approveButton(
                                                            btnBgColor:
                                                                Colors.blue,
                                                            btnText: "Check",
                                                            onClick: () {
                                                              _approveReject(
                                                                  approver_status);
                                                              approver_status =
                                                                  "Checked";
                                                              if (_approveResult
                                                                      .message !=
                                                                  null) {
                                                                message =
                                                                    _approveResult
                                                                        .message;
                                                                status =
                                                                    _approveResult
                                                                        .status;
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
                                                                Colors.blue,
                                                            btnText: "Reject",
                                                            onClick: () {
                                                              _approveReject(
                                                                  approver_status);
                                                              approver_status =
                                                                  "Checker Rejected";
                                                              if (_approveResult
                                                                      .message !=
                                                                  null) {
                                                                message =
                                                                    _approveResult
                                                                        .message;
                                                                status =
                                                                    _approveResult
                                                                        .status;
                                                                buildShowDialog(
                                                                    context);
                                                              } else {}
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    : Container(
                                                        child: Column(
                                                          children: [
                                                            Text(taskDetsResults[
                                                                            0]
                                                                        .checkerName !=
                                                                    null
                                                                ? "Checked By: " +
                                                                    taskDetsResults[
                                                                            0]
                                                                        .checkerName +
                                                                    "(${taskDetsResults[0].checkedDate})"
                                                                : ""),
                                                            Text(taskDetsResults[
                                                                            0]
                                                                        .approverName !=
                                                                    null
                                                                ? "Approved By: " +
                                                                    taskDetsResults[
                                                                            0]
                                                                        .approverName +
                                                                    "(${taskDetsResults[0].approvedDate})"
                                                                : ""),
                                                            Text(taskDetsResults[
                                                                            0]
                                                                        .oppPartyApproverName !=
                                                                    null
                                                                ? "Buyer Approved By: " +
                                                                    taskDetsResults[
                                                                            0]
                                                                        .oppPartyApproverName +
                                                                    "(${taskDetsResults[0].oppPartyApprovedDate})"
                                                                : ""),
                                                          ],
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          )
                                        : role == 'Approver'
                                            ? Container(
                                                child: Column(
                                                children: [
                                                  Text("Last Status: " +
                                                      taskDetsResults[0]
                                                          .lastStatus),
                                                  Text("Requested By: " +
                                                      taskDetsResults[0]
                                                          .creatorName +
                                                      "(${taskDetsResults[0].datecreated})"),
                                                  Text("Checked By: " +
                                                      taskDetsResults[0]
                                                          .checkerName +
                                                      "(${taskDetsResults[0].checkedDate})"),
                                                  taskDetsResults[0]
                                                                  .lastStatus ==
                                                              "Checked" &&
                                                          taskDetsResults[0]
                                                                  .sellerID ==
                                                              compID
                                                      ? Row(
                                                          children: [
                                                            _approveButton(
                                                              btnBgColor:
                                                                  Colors.blue,
                                                              btnText:
                                                                  "Approve",
                                                              onClick: () {
                                                                approver_status =
                                                                    'Approver Approved';

                                                                _approveReject(
                                                                    approver_status);
                                                                if (_approveResult
                                                                        .message !=
                                                                    null) {
                                                                  message =
                                                                      _approveResult
                                                                          .message;
                                                                  status =
                                                                      _approveResult
                                                                          .status;
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
                                                                  Colors.blue,
                                                              btnText: "Reject",
                                                              onClick: () {
                                                                approver_status =
                                                                    'Approver Rejected';

                                                                _approveReject(
                                                                    approver_status);
                                                                if (_approveResult
                                                                        .message !=
                                                                    null) {
                                                                  message =
                                                                      _approveResult
                                                                          .message;
                                                                  status =
                                                                      _approveResult
                                                                          .status;
                                                                  buildShowDialog(
                                                                      context);
                                                                } else {}
                                                              },
                                                            )
                                                          ],
                                                        )
                                                      : taskDetsResults[0]
                                                                      .lastStatus ==
                                                                  "Approver Approved" &&
                                                              taskDetsResults[0]
                                                                      .sellerID !=
                                                                  compID
                                                          ? Row(
                                                              children: [
                                                                _approveButton(
                                                                  btnBgColor:
                                                                      Colors
                                                                          .blue,
                                                                  btnText:
                                                                      "Approve",
                                                                  onClick: () {
                                                                    approver_status =
                                                                        'Buyer Approved';

                                                                    _approveReject(
                                                                        approver_status);
                                                                    if (_approveResult
                                                                            .message !=
                                                                        null) {
                                                                      message =
                                                                          _approveResult
                                                                              .message;
                                                                      status =
                                                                          _approveResult
                                                                              .status;
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
                                                                      "Reject",
                                                                  onClick: () {
                                                                    approver_status =
                                                                        'Buyer Rejected';

                                                                    _approveReject(
                                                                        approver_status);
                                                                    if (_approveResult
                                                                            .message !=
                                                                        null) {
                                                                      message =
                                                                          _approveResult
                                                                              .message;
                                                                      status =
                                                                          _approveResult
                                                                              .status;
                                                                      buildShowDialog(
                                                                          context);
                                                                    } else {}
                                                                  },
                                                                ),
                                                              ],
                                                            )
                                                          : Container(
                                                              child: Column(
                                                              children: [
                                                                Text(taskDetsResults[0]
                                                                            .checkerName !=
                                                                        null
                                                                    ? "Checked By: " +
                                                                        taskDetsResults[0]
                                                                            .checkerName +
                                                                        "(${taskDetsResults[0].checkedDate})"
                                                                    : ""),
                                                                Text(taskDetsResults[0]
                                                                            .approverName !=
                                                                        null
                                                                    ? "Approved By: " +
                                                                        taskDetsResults[0]
                                                                            .approverName +
                                                                        "(${taskDetsResults[0].approvedDate})"
                                                                    : ""),
                                                                Text(taskDetsResults[0]
                                                                            .oppPartyApproverName !=
                                                                        null
                                                                    ? "Buyer Approved By: " +
                                                                        taskDetsResults[0]
                                                                            .oppPartyApproverName +
                                                                        "(${taskDetsResults[0].oppPartyApprovedDate})"
                                                                    : ""),
                                                              ],
                                                            ))
                                                ],
                                              ))
                                            : role=="Maker-Checker-Approver"
                                            ?Container(
                                              child: Column(
                                          children: [
                                            Text("Last Status: " +
                                                taskDetsResults[0].lastStatus),
                                            Text("Requested By: " +
                                                taskDetsResults[0].creatorName +
                                                "(${taskDetsResults[0].datecreated})"),
                                                   Text(taskDetsResults[0]
                                                                .checkerName !=
                                                            null
                                                        ? "Checked By: " +
                                                            taskDetsResults[
                                                                    0]
                                                                .checkerName +
                                                            "(${taskDetsResults[0].checkedDate})"
                                                        : ""),
                                                    Text(taskDetsResults[0]
                                                                .approverName !=
                                                            null
                                                        ? "Approved By: " +
                                                            taskDetsResults[
                                                                    0]
                                                                .approverName +
                                                            "(${taskDetsResults[0].approvedDate})"
                                                        : ""),
                                                        Text(taskDetsResults[0]
                                                                    .oppPartyApproverName !=
                                                                null
                                                            ? "Buyer Approved By: " +
                                                                taskDetsResults[
                                                                        0]
                                                                    .oppPartyApproverName +
                                                                "(${taskDetsResults[0].oppPartyApprovedDate})"
                                                            : ""),
                                                         taskDetsResults[0]
                                                        .isOppPartyApproved &&
                                                    taskDetsResults[0]
                                                            .lastStatus ==
                                                        "Buyer Approved"
                                                ? Container(
                                                    child: Row(
                                                      children: [
                                                        
                                                        taskDetsResults[0]
                                                                    .sellerID ==
                                                                compID
                                                            ? _approveButton(btnBgColor: Colors.blue, btnText: "Send Discount Request", onClick: () {
                                                                  approver_status =
                                                                      'Sent To Financier';
                                                                  _approveReject(
                                                                      approver_status);
                                                                  if (_approveResult
                                                                          .message !=
                                                                      null) {
                                                                    message =
                                                                        _approveResult
                                                                            .message;
                                                                    status =
                                                                        _approveResult
                                                                            .status;
                                                                    buildShowDialog(context);
                                                                  } else {}
                                                                },)
                                                            : taskDetsResults[0]
                                                                        .buyerID ==
                                                                    taskDetsResults[
                                                                            0]
                                                                        .creatorCompanyID
                                                                ? _approveButton(
                                                                    btnBgColor:
                                                                        Colors
                                                                            .blue,
                                                                    btnText:
                                                                        "Send Discount Request",
                                                                    onClick:
                                                                        () {
                                                                      approver_status =
                                                                          'Sent To Financier';
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
                                                                : Container()
                                                      ],
                                                    ),
                                                  ):
                                                taskDetsResults[0].lastStatus=="Draft" && taskDetsResults[0].sellerID==compID ?
                                                        Row(
                                                        children: [
                                                          _approveButton(
                                                            btnBgColor:
                                                                Colors.blue,
                                                            btnText: "Check",
                                                            onClick: () {
                                                              _approveReject(
                                                                  approver_status);
                                                              approver_status =
                                                                  "Checked";
                                                              if (_approveResult
                                                                      .message !=
                                                                  null) {
                                                                message =
                                                                    _approveResult
                                                                        .message;
                                                                status =
                                                                    _approveResult
                                                                        .status;
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
                                                                Colors.blue,
                                                            btnText: "Reject",
                                                            onClick: () {
                                                              _approveReject(
                                                                  approver_status);
                                                              approver_status =
                                                                  "Checker Rejected";
                                                              if (_approveResult
                                                                      .message !=
                                                                  null) {
                                                                message =
                                                                    _approveResult
                                                                        .message;
                                                                status =
                                                                    _approveResult
                                                                        .status;
                                                                buildShowDialog(
                                                                    context);
                                                              } else {}
                                                            },
                                                          ),
                                                        ],
                                                      ): taskDetsResults[0].lastStatus=="Checked" && taskDetsResults[0]
                                                                  .sellerID ==
                                                              compID ?Container(
                                                        child: Column(
                                                          children: [
                                                            Text("Checked By: ${taskDetsResults[0].checkerName}" +
                                                                        "(${taskDetsResults[0].checkedDate})"),
                                                            
                                                            
                                                          Row(children: [
                                                            _approveButton(
                                                              btnBgColor:
                                                                  Colors.blue,
                                                              btnText:
                                                                  "Approve",
                                                              onClick: () {
                                                                approver_status =
                                                                    'Approver Approved';

                                                                _approveReject(
                                                                    approver_status);
                                                                if (_approveResult
                                                                        .message !=
                                                                    null) {
                                                                  message =
                                                                      _approveResult
                                                                          .message;
                                                                  status =
                                                                      _approveResult
                                                                          .status;
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
                                                                  Colors.blue,
                                                              btnText: "Reject",
                                                              onClick: () {
                                                                approver_status =
                                                                    'Approver Rejected';

                                                                _approveReject(
                                                                    approver_status);
                                                                if (_approveResult
                                                                        .message !=
                                                                    null) {
                                                                  message =
                                                                      _approveResult
                                                                          .message;
                                                                  status =
                                                                      _approveResult
                                                                          .status;
                                                                  buildShowDialog(
                                                                      context);
                                                                } else {}
                                                              },
                                                            )
                                                          ],
                                                        )
                                                          ],
                                                        ),
                                                      ):taskDetsResults[0]
                                                                      .lastStatus ==
                                                                  "Approver Approved" &&
                                                              taskDetsResults[0]
                                                                      .sellerID !=
                                                                  compID
                                                          ? Row(
                                                              children: [
                                                              
                                                                _approveButton(
                                                                  btnBgColor:
                                                                      Colors
                                                                          .blue,
                                                                  btnText:
                                                                      "Approve",
                                                                  onClick: () {
                                                                    approver_status =
                                                                        'Buyer Approved';

                                                                    _approveReject(
                                                                        approver_status);
                                                                    if (_approveResult
                                                                            .message !=
                                                                        null) {
                                                                      message =
                                                                          _approveResult
                                                                              .message;
                                                                      status =
                                                                          _approveResult
                                                                              .status;
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
                                                                      "Reject",
                                                                  onClick: () {
                                                                    approver_status =
                                                                        'Buyer Rejected';

                                                                    _approveReject(
                                                                        approver_status);
                                                                    if (_approveResult
                                                                            .message !=
                                                                        null) {
                                                                      message =
                                                                          _approveResult
                                                                              .message;
                                                                      status =
                                                                          _approveResult
                                                                              .status;
                                                                      buildShowDialog(
                                                                          context);
                                                                    } else {}
                                                                  },
                                                                ),
                                                              ],
                                                            ):Container(
                                                              child: Column(
                                                      children: [
                                                        Text(taskDetsResults[0]
                                                                    .checkerName !=
                                                                null
                                                            ? "Checked By: " +
                                                                taskDetsResults[
                                                                        0]
                                                                    .checkerName +
                                                                "(${taskDetsResults[0].checkedDate})"
                                                            : ""),
                                                        Text(taskDetsResults[0]
                                                                    .approverName !=
                                                                null
                                                            ? "Approved By: " +
                                                                taskDetsResults[
                                                                        0]
                                                                    .approverName +
                                                                "(${taskDetsResults[0].approvedDate})"
                                                            : ""),
                                                        Text(taskDetsResults[0]
                                                                    .oppPartyApproverName !=
                                                                null
                                                            ? "Buyer Approved By: " +
                                                                taskDetsResults[
                                                                        0]
                                                                    .oppPartyApproverName +
                                                                "(${taskDetsResults[0].oppPartyApprovedDate})"
                                                            : ""),
                                                      ],
                                                    ),
                                                            )
                                          ])):Container(),

                                //  role=='checker'?Row(
                                //    children: [
                                //      Text(role)
                                //    ],
                                //  ):role=='Approver'?Row(
                                //    children: [
                                //      Text(role)
                                //    ],
                                //  ):Row(
                                //    children: [
                                //      Text(role)
                                //    ],
                                //  )
                              ],
                            ),
                          ),
                        ),
                        // !taskDetsResults[0].isApproved
                        //     ? Container(
                        //         child: Padding(
                        //           padding: EdgeInsets.only(
                        //               top: 30.0, right: 15.0, left: 15.0),
                        //           child: Column(
                        //             children: [
                        //                 Text("Last Status:"+taskDetsResults[0].lastStatus),
                        //                 Text("Requested by:"+taskDetsResults[0].creatorName),
                        //               Row(
                        //                 children: [

                        //                   TextButton(
                        //                       style: TextButton.styleFrom(
                        //                         backgroundColor: Colors.blue,
                        //                       ),
                        //                       onPressed: () {},
                        //                       child: Text(
                        //                         taskDetsResults[0].isChecked
                        //                             ? "Approve"
                        //                             : "Checked",
                        //                         style:
                        //                             TextStyle(color: Colors.white),
                        //                       )),
                        //                   SizedBox(
                        //                     width: 30.0,
                        //                   ),
                        //                   TextButton(
                        //                       style: TextButton.styleFrom(
                        //                         backgroundColor: Colors.blue,
                        //                       ),
                        //                       onPressed: () {
                        //                         _approveReject();
                        //                         if (_approveResult.message != null) {
                        //                           setState(() {
                        //                             _isLoading = false;
                        //                           });
                        //                           Text(_approveResult.message);
                        //                         }
                        //                       },
                        //                       child: Text("Reject",
                        //                           style: TextStyle(
                        //                               color: Colors.white)))
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //     : Container(),
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
                                text: "Canel",
                                onClick: () {},
                                bgColor: Colors.white,
                                textColor: Color(0xccF45C2C),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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
