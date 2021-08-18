import 'dart:io';

import '../models/doc_rep_msg.dart';
import '../models/todo_dets_resp_msg.dart';
import '../services/pdfApi.dart';
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  List<TaskDets> taskDetsResults;
  DocumentResponseMessage _documentResponseMessage;
  static Future<File> generateInvoice(taskDetsResults) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
        build: (context) => [
              buildTitle(taskDetsResults),
              SizedBox(
                height: 40,
              ),
              buildType(),
              SizedBox(
                height: 40,
              ),
              buildTypeCred(taskDetsResults),
              SizedBox(
                height: 40,
              ),
              buildFinInfo(),
              SizedBox(
                height: 40,
              ),
              buildFinInfoCred(taskDetsResults),
              SizedBox(
                height: 40,
              ),
              builInvoiceTable(taskDetsResults),
              SizedBox(
                height: 20,
              ),
              // buildTotal(taskDetsResults),
              // SizedBox(
              //   height: 20,
              // ),
              // buildStatus(taskDetsResults)
            ]));
    return PdfApi.saveDocument(name: 'invoice.pdf', pdf: pdf);
  }

  static Widget buildTitle(taskDetsResults) => Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text("${taskDetsResults[0].supplierName}"),
              )),
          Expanded(
              child: Text(
                  "${taskDetsResults[0].buyerAddress}\nEmail: ${taskDetsResults[0].buyerEmail}")),
        ],
      );

  static Widget buildType() => Center(
      child: Text("INVOICE DISCOUNTING REQUEST",
          style: TextStyle(fontWeight: FontWeight.bold)));

    static Widget buildTypeCred(taskDetsResults) =>Container(
    child:  Column(children: [
      Row(
      children: [
      Expanded(
        flex: 1,
        child: 
          Text("Buyer:  ${ taskDetsResults[0].buyerName}\n Email: ${taskDetsResults[0].buyerEmail} \n Address: ${taskDetsResults[0].buyerAddress}", textAlign: TextAlign.left),
      ),
      Expanded(
        flex: 1,
        child:  Text("Ref No:  ${taskDetsResults[0].docRefNo}\n Due Date  ${taskDetsResults[0].datecreated}\nCompany Name  ${taskDetsResults[0].supplierName}\nContract No  ${taskDetsResults[0].contractID}", textAlign: TextAlign.right),
      ),
    ]),

    ])
  );


  static buildFinInfo() => Center(
        child: Text("FINANCIAL INFORMATION",
            style: TextStyle(fontWeight: FontWeight.bold)),
      );
  static Widget buildFinInfoCred(taskDetsResults) => Column(children: [
        Row(children: [
          Expanded(
            child: 
              Text(
                "Due Date: ${taskDetsResults[0].dueDate}\nCurrency: ${taskDetsResults[0].currency}", textAlign: TextAlign.left
              ),
          ),
          Expanded(
            child: 
              Text(
                "Financing Percentage:  ${taskDetsResults[0].financingPercentage}\nInterest Rate p.a:  ${taskDetsResults[0].interestRatePA}\nCommission:  ${taskDetsResults[0].commissionAmt}\nExcise Tax:  ${taskDetsResults[0].exciseTaxAmt}", textAlign: TextAlign.left
              ),
          ),
          Expanded(
            child: 
              Text(
                "Maximum Tenor:  ${taskDetsResults[0].maximumTenor}\nFinancing Tenor:  ${taskDetsResults[0].financingTenor}", textAlign: TextAlign.right
              ),
          ),

        ])
      ]);
  
  static Widget builInvoiceTable(List<TaskDets> taskDetsResults) {
    final headers = ['Type', 'Amount', 'Funded Amount', 'Interest', 'Commission','Net Amount'];

    final data = taskDetsResults.map((e) {
      return [
        e.ifrcViewDetails[0].docType, 
        e.ifrcViewDetails[0].amount, 
        e.ifrcViewDetails[0].invoiceAmount,
        e.ifrcViewDetails[0].interest,
        e.ifrcViewDetails[0].netCommission,
        e.ifrcViewDetails[0].settlementAmount
        ];
    }).toList();

    return Table.fromTextArray(
      headerStyle: TextStyle(fontWeight:FontWeight.bold ),
      headers: headers,
      data: data,
    );
  }

  //  static Widget buildTotal(List<TaskDets> taskDetsResults) {
  //   final headers = ['Type', 'Amount', 'Funded Amount', 'Interest', 'Commission','Net Amount'];

  //   final data = taskDetsResults.map((e) {
  //     return [
  //       'Total', 
  //       e.ifrcViewDetails[0].amount, 
  //       e.ifrcViewDetails[0].invoiceAmount,
  //       e.ifrcViewDetails[0].interest,
  //       e.ifrcViewDetails[0].netCommission,
  //       e.ifrcViewDetails[0].settlementAmount
  //       ];
  //   }).toList();

  //   return Table.fromTextArray(
  //     headerStyle: TextStyle(fontWeight:FontWeight.bold ),
  //     // headers: headers,
  //     data: data,
  //   );
  // }

  // static Widget buildStatus(taskDetsResults) {
  //   return Column(
  //   children: [
  //   Text("Last Status: ${taskDetsResults[0].lastStatus}\nRequested by: ${taskDetsResults[0].creatorName}\nChecked by: ${taskDetsResults[0].checkerName}\nBuyer Approved by: ${taskDetsResults[0].approverName}\nFinancier Approved On: ${taskDetsResults[0].financerApproverName}", textAlign: TextAlign.left),
   
  //   ]);
  // }
}
