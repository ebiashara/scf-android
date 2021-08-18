import 'dart:async';

import 'package:flutter/material.dart';
import '../models/contract_resp_msg.dart';
import '../models/contractbyId_resp_msg.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../models/user_details.dart';
import '../pages/Documents.dart';
import '../services/api_helper.dart';

class Cont extends StatefulWidget {
  Cont({Key key}) : super(key: key);

  @override
  _ContState createState() => _ContState();
}

class _ContState extends State<Cont> {
  final _debouncer = Debouncer(mililiseconds: 500);
  bool _isLoading = false;
  UserDetails userDetails;
  ContractResponseMessage _contractResponseMessage;
  Future<ContractByIdResponseMessage> _contractByIdResponseMessage;

  String dropdownValue = 'KSH';
  TextEditingController _searchController = TextEditingController();
  String _searchResult = '';


  List<Contracts> _results;
  List<Contracts> _contractResults;
  List<Contracts> _filteredContractResults;
  List<ContractById> contractByID_results = [];

  Future<List> _getContracts() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var compID = userDets.companyID;
    var token = userDets.token;
    _contractResponseMessage = await APIHelper().getContracts(compID, token);
    _contractResults = _contractResponseMessage.result;

    setState(() {
      _contractResults = _contractResponseMessage.result;
      _filteredContractResults = _contractResponseMessage.result;
    });
  }

  @override
  void initState() {
    _getContracts();
    _results = [];
    _contractResults = [];
    super.initState();
  }

  SingleChildScrollView _databody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(
                label: Text('ID'),
              ),
              DataColumn(
                label: Text('FIRST NAME'),
              ),
              DataColumn(
                label: Text('LAST NAME'),
              ),
            ],
            rows: _contractResults
                .map<DataRow>((element) => DataRow(cells: [
                      DataCell(Text(element.contractID.toString()),
                      onTap: (){
                          SharedPreferenceHelper.save(Configs.CONTRACT_ID, element);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Docs(),
                                    settings: RouteSettings(
                                    arguments: element)));
                      }),
                      DataCell(Text(element.seller.toString())),
                      DataCell(Text(element.buyer.toString())),
                    ]))
                .toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Text('Contracts',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Container(
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
                    items: <String>['KSH', 'RAND']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
            ),
            SizedBox(height: 5.0),
            _searchField(),
            _databody()
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
                  _filteredContractResults = _contractResults
                      .where((element) =>
                          (element.contractID.toString().contains(string)))
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
