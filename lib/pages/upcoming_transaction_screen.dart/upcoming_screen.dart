import '../../widgets/notification_widget.dart';
import '../../widgets/popup_widget.dart';

import '../../configs/constants.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../configs/screen_configs.dart';
import 'dart:async';
import '../../models/login_resp_msg.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../models/upcoming_trans_resp_msg.dart';
import '../../services/api_helper.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key key}) : super(key: key);
  static String routeName = '/upcoming_screen';

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
   final _debouncer = Debouncer(mililiseconds: 500);
  String dropdownValue = 'KSH';
  UserDetails userDetails;
  bool _isLoading = false;
  UpcomingSettlementsResponseMessage _upcomingSettlementsResponseMessage;
  List<UpcomingSettlements> _results;
  List<UpcomingSettlements> _filterResults;

  TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();
    _results = [];
    _filterResults = [];
    _getUpcomingSettlements();
  }

  Future<List> _getUpcomingSettlements() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var compID = userDets.companyID;
    var token = userDets.token;

    _upcomingSettlementsResponseMessage =
        await APIHelper().upcomingSettlements(compID, token);
    _results = _upcomingSettlementsResponseMessage.result;

    setState(() {
      _results = _upcomingSettlementsResponseMessage.result;
      _filterResults = _upcomingSettlementsResponseMessage.result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text( Constants.upcoming_settlements_title),
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
      
      body:Container(
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
                SizedBox(
                  height: getSizeOfScreenHeight(20),
                ),
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
                              DataCell(
                                  Text(element.principalAmount.toString())),
                              DataCell(Text(element.maturityDate.toString())),
                            ]))
                        .toList()),
              ],
            ),
    ),
    );
  } Card _searchField() {
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
                  _filterResults = _results.where((element) => 
                (element.companyName.toLowerCase().contains(string))
                ).toList();
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
class Debouncer {
  final int mililiseconds;
  Timer _timer;
  VoidCallback action;

  Debouncer({this.mililiseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = new Timer(Duration(milliseconds: mililiseconds), action);
  }
}
