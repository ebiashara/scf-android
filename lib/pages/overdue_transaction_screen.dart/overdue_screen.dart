import '../../widgets/notification_widget.dart';
import '../../widgets/popup_widget.dart';

import '../../configs/constants.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../configs/screen_configs.dart';
import '../../models/login_resp_msg.dart';
import '../../models/ove_trans_resp_msg.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../services/api_helper.dart';
import '../../widgets/debouncer.dart';

class OverdueScreen extends StatefulWidget {
  const OverdueScreen({Key key}) : super(key: key);
  static String routeName = '/overdue_screen';

  @override
  _OverdueScreenState createState() => _OverdueScreenState();
}

class _OverdueScreenState extends State<OverdueScreen> {
  final _debouncer = Debouncer(mililiseconds: 500);
  List<GetOverdueTransactions> _filterResults;
  bool _isLoading = false;
  String _searchResult = '';
  UserDetails userDetails;
  GetOverdueTransactionsResponseMessage _getOverdueTransactionsResponseMessage;

  List<GetOverdueTransactions> _results;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _results = [];
    _filterResults = [];
    _getOverdueTransactions();
  }


  Future<List> _getOverdueTransactions() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var compID = userDets.companyID;
    var token = userDets.token;

    _getOverdueTransactionsResponseMessage =
        await APIHelper().overdueTransactions(compID, token);
    _results = _getOverdueTransactionsResponseMessage.result;

    setState(() {
      _results = _getOverdueTransactionsResponseMessage.result;
      _filterResults = _getOverdueTransactionsResponseMessage.result;
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      
       appBar: AppBar(
         title: Text( Constants.overdue_transactions_title),
        elevation: 0,
        // automaticallyImplyLeading: false,
        backgroundColor: kBrightColor,
        iconTheme: IconThemeData(color: Colors.white, size: getSizeOfScreenHeight(45)),
         actions: [
          NamedIcon(),
          Padding(
            padding: EdgeInsets.only(top:getSizeOfScreenHeight(5)),
            child: PopupWidget(),
          ),
        ],
      ),
      body: Container(
      decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      //   stops: [
      //     0.1,
      //     0.4,
      //     0.6,
      //     0.9,
      //   ],
      //   colors: [
      //     kPrimaryColor,
      //     kPrimaryColor,
      //     kPrimaryColor,
      //     kPrimaryColor,
      //   ],
      // )
      ),
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
              ),
            )
          : Column(
              children: [
                SizedBox(height: getSizeOfScreenHeight(20),),
                _searchField(),
                DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(
                label: Text('Customer'),
              ),
              DataColumn(
                label: Text('Amount'),
              ),
              DataColumn(
                label: Text('Due Date'),
              ),
            ],
            rows: _filterResults
                .map<DataRow>((element) => DataRow(cells: [
                      DataCell(Text(element.companyName.toString())),
                      DataCell(Text(element.principalAmount.toString())),
                      DataCell(Text(element.maturityDate.toString())),
                    ]))
                .toList()),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
    ),
    );
  }
   Card _searchField() {
    return Card(
      elevation: 3,
      child: new ListTile(
        leading: new Icon(Icons.search),
        title: new TextField(
            controller: _searchController,
            decoration: new InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  _filterResults = _results
                      .where((element) =>
                          (element.companyName.toLowerCase().contains(string)))
                      .toList();
                });
              });
            }),
        trailing: new IconButton(
          icon: new Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              _searchController.clear();
              _searchResult = '';
            });
          },
        ),
      ),
    );
  }
}