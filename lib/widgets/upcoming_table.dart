import 'package:flutter/material.dart';
import '../configs/constants.dart';
import '../models/login_resp_msg.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../models/upcoming_trans_resp_msg.dart';
import '../services/api_helper.dart';

class UpcomingTable extends StatefulWidget {
  UpcomingTable({Key key}) : super(key: key);

  @override
  _UpcomingTableState createState() => _UpcomingTableState();
}

class _UpcomingTableState extends State<UpcomingTable> {
  String dropdownValue = 'KES';
  UserDetails userDetails;
  UpcomingSettlementsResponseMessage _upcomingSettlementsResponseMessage;

  List<UpcomingSettlements> results = [];

  _UpcomingTableState() {
     _getUpcomingSettlements();
  }


  Future<List> _getUpcomingSettlements() async {
   
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var compID = userDets.companyID;
    var token = userDets.token;

    _upcomingSettlementsResponseMessage =
        await APIHelper().upcomingSettlements(compID, token);
    results =
        _upcomingSettlementsResponseMessage.result;

    // return results;
    setState(() {
      results =
        _upcomingSettlementsResponseMessage.result;
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
                    "Upcoming Settlements",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.bottomCenter,
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
            ),
          )
        ],
      ),
    );
  }

  Widget _text({String textUpper, String textBotom}) {
    return Container(
      child: Column(
        children: [
          Text(textUpper),
          Text(textBotom)
        ],
      ),
    );
  }
}
