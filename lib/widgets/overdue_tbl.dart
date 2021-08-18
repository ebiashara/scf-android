import 'package:flutter/material.dart';
import '../configs/constants.dart';
import '../models/login_resp_msg.dart';
import '../models/ove_trans_resp_msg.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../services/api_helper.dart';

class OverdueTable extends StatefulWidget {
  OverdueTable({Key key}) : super(key: key);

  @override
  _OverdueTableState createState() => _OverdueTableState();
}

class _OverdueTableState extends State<OverdueTable> {
  String dropdownValue = 'KES';
  UserDetails userDetails;
  GetOverdueTransactionsResponseMessage _getOverdueTransactionsResponseMessage;

  List<GetOverdueTransactions> results = [];

  _OverdueTableState() {
     _getOverdueTransactions();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _getOverdueTransactions();
  // }

  Future<List> _getOverdueTransactions() async {
   
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var compID = userDets.companyID;
    var token = userDets.token;

    _getOverdueTransactionsResponseMessage =
        await APIHelper().overdueTransactions(compID, token);
    results =
        _getOverdueTransactionsResponseMessage.result;

    // return results;
    setState(() {
      results =
        _getOverdueTransactionsResponseMessage.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 35.0, bottom: 25.0, top:20.0, right: 35.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    "Overdue Transactions",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.bottomRight,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    underline: Container(
                      height: 1,
                      color: Colors.black26,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: Constants.currencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: DataTable(
              showBottomBorder: true,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Customer',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Amount',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Due Date',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows:results
                  .map<DataRow>((element) => DataRow(cells: [
                        DataCell(Text(element.companyName.toString())),
                        DataCell(Text(element.principalAmount.toString())),
                        DataCell(
                            Text(element.maturityDate.toString())),
                      ]))
                  .toList()
                // DataRow(
                //   cells: <DataCell>[
                //     DataCell(Text('William')),
                //     DataCell(Text('27')),
                //     DataCell(Text('4/4/2021')),
                //   ],
                // ),
                // ],
                ),
          )
        ],
      ),
    );
  }
}
