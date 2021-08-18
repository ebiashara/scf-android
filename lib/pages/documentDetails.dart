import 'package:flutter/material.dart';
import '../configs/colors.dart';
import '../models/docById_resp_msg.dart';
import '../models/doc_rep_msg.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../models/user_details.dart';
import '../services/api_helper.dart';
import '../services/pdfApi.dart';
import '../services/pdf_invoice_api.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';


class DocumentDetails extends StatefulWidget {
  DocumentDetails({Key key}) : super(key: key);

  @override
  _DocumentDetailsState createState() => _DocumentDetailsState();
}

class _DocumentDetailsState extends State<DocumentDetails> {
  UserDetails userDetails;
  bool _isLoading = false;
  Documents documents;

  List<DocumentDets> taskDetsResults;
  List<IfrcViewDetails> ifrcViewDetails;
  IfrcViewDetails ifrc;
  DocumentByIdResponseMessage _documentByIdResponseMessage;

  Future<List> _getDocumentsDetails() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));
    var documents = Documents.fromJson(
        await SharedPreferenceHelper.read(Configs.DOCUMENT_ID));

    var token = userDets.token;
    var documentID = documents.docID;
    String documentType = documents.docType;

    setState(() {
      _isLoading = true;
    });
    _documentByIdResponseMessage =
        await APIHelper().documentDetails(documentID, token);
    taskDetsResults = _documentByIdResponseMessage.result;
    taskDetsResults.map((e) {
      ifrcViewDetails = e.ifrcViewDetails;
    });
    setState(() {
      taskDetsResults = _documentByIdResponseMessage.result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getDocumentsDetails();
    taskDetsResults = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final documentsType = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLighterColor,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none),
                color: Colors.white,
                iconSize: 30.0,
                onPressed: () {},
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                        Text(documentsType,
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
                        Text(
                          "FINANCIAL INFORMATION",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: _loginBtn(
                                    text: "Download PDF",
                                    onClick: () async {
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

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString('Welcome to PDF Succinctly!',
        PdfStandardFont(PdfFontFamily.helvetica, 30));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
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
}
