import 'dart:async';

import 'package:flutter/material.dart';
import '../models/contractbyId_resp_msg.dart';
import '../models/doc_rep_msg.dart';
import '../models/contract_resp_msg.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../models/user_details.dart';
import '../pages/add_document/add_document_screen.dart';
import '../pages/todo_details.dart';
import '../services/api_helper.dart';

class Docs extends StatefulWidget {
  Docs({Key key}) : super(key: key);

  @override
  _DocsState createState() => _DocsState();
}

class _DocsState extends State<Docs> {
  final _debouncer = Debouncer(mililiseconds: 500);
  UserDetails userDetails;
  Contracts contracts;
  // ContractResponseMessage _contractResponseMessage;
  DocumentResponseMessage _documentResponseMessage;
  String dropdownValue = 'KSH';
  // List<Contracts> _contractResults;
  List<Documents> _documentResults;
  List<Documents> _filteredDocumentResults;
  List<ContractById> contractByIdResults = [];
  int contractID;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _filteredDocumentResults = [];
    _documentResults = [];
    _getDocuments();
  }

  TextEditingController _searchController = TextEditingController();
  // String _searchResult = '';

  Future<List> _getDocuments() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));
    var contracts = Contracts.fromJson(
        await SharedPreferenceHelper.read(Configs.CONTRACT_ID));

    var compID = userDets.companyID;

    var token = userDets.token;
    var contractID = contracts.contractID;
    setState(() {
      _isLoading = true;
    });
    _documentResponseMessage =
        await APIHelper().getDocuments(compID, contractID, token);
    _documentResults = _documentResponseMessage.result;

    setState(() {
      _documentResults = _documentResponseMessage.result;
      _filteredDocumentResults = _documentResponseMessage.result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
              context, AddDocumentScreen.routeName);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ))
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
                  child: Text('Documents',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0)),
                ),
                SizedBox(height: 5.0),
                _searchField(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Ref No',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('Status',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('Amount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (_filteredDocumentResults.length > 0) {
                        return _listItem(index);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                    itemCount: _filteredDocumentResults.length,
                  ),
                ),
              ],
            ),
    );
  }

  _listItem(index) {
    return Card(
      child: Flexible(
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: GestureDetector(
                  child: Text(
                    _documentResults[index].docID.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.blue),
                  ),
                  onTap: () {
                    SharedPreferenceHelper.save(
                        Configs.DOCUMENT_ID, _documentResults[index]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TaskDetails(),
                            settings: RouteSettings(
                                arguments: _documentResults[index].docType)));
                  },
                ),
                subtitle: Text(_documentResults[index].buyerCompanyName),
              ),
            ),
            Expanded(
                child: ElevatedButton(
                    child: Text(
                      _documentResults[index].status,
                      textAlign: TextAlign.center,
                    ),
                    style: _documentResults[index].status == "Financed"
                        ? ButtonStyle(
                            textStyle: MaterialStateProperty.all(TextStyle(
                                color: Colors.green[200],
                                fontWeight: FontWeight.bold)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[50]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green[100]),
                            )))
                        : ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange[50]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.orange[100]),
                            ))))),
            Expanded(
              child: ListTile(
                title: Text(_documentResults[index].totalAmount.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(_documentResults[index].maturityDate),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _searchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
              controller: _searchController,
              decoration: new InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  _filteredDocumentResults =
                      _documentResults.where((documentResult) {
                    var searchResults = documentResult.docID
                            .toString()
                            .toLowerCase()
                            .contains(text) ||
                        documentResult.status
                            .toString()
                            .toLowerCase()
                            .contains(text) ||
                        documentResult.maturityDate
                            .toString()
                            .toLowerCase()
                            .contains(text) ||
                        documentResult.totalAmount
                            .toString()
                            .toLowerCase()
                            .contains(text);
                    return searchResults;
                  }).toList();
                });
              }),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                _searchController.clear();
                onSearchTextChanged('');
                // _searchResult = '';
              });
            },
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _filteredDocumentResults.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _filteredDocumentResults.forEach((userDetail) {
      if (userDetail.docID
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) ||
          userDetail.status
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) ||
          userDetail.status
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
        _filteredDocumentResults.add(userDetail);
    });

    setState(() {});
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
