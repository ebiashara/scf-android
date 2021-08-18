import '../../configs/screen_configs.dart';
import '../../pages/add_document/add_document_screen.dart';
import '../../widgets/notification_widget.dart';
import '../../widgets/popup_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../pages/task_details/task_details_screen.dart';
import '../../models/contractbyId_resp_msg.dart';
import '../../models/doc_rep_msg.dart';
import '../../models/contract_resp_msg.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../models/user_details.dart';
import '../../services/api_helper.dart';
import '../../configs/colors.dart';
import '../../configs/constants.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({Key key}) : super(key: key);
  static String routeName = '/documents_screen';

  @override
  _DocumentsScreenState createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  UserDetails userDetails;
  Contracts contracts;
  DocumentResponseMessage _documentResponseMessage;
  String dropdownValue = 'KSH';
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
          Navigator.pushNamed(context, AddDocumentScreen.routeName);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
      appBar: AppBar(
        
        title: Text(Constants.documents),
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
          : Container(
              child: Column(children:[
                _searchField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(Constants.ref_no,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(Constants.status,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(Constants.amount,
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
              ],)
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
              });
            },
          ),
        ),
      ),
    );
  }

   _listItem(index) {
    return Card(
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
                          builder: (_) => TaskDetailsScreen(),
                          settings: RouteSettings(arguments: _documentResults[index])));
                },
              ),
              subtitle: Text(_documentResults[index].docType),
            ),
          ),
         Expanded(
              child: ElevatedButton(
            child: Text(_filteredDocumentResults[index].status),
            style: _filteredDocumentResults[index].status=="Checked"?ButtonStyle(
              textStyle: MaterialStateProperty.all(TextStyle(color: Colors.green[200],fontWeight: FontWeight.bold)),
                backgroundColor: MaterialStateProperty.all(Colors.green[50]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green[100]),
                ))):
                ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange[50]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.orange[100]),
                ))) 
          )),
          Expanded(
            child: ListTile(
              title: Text(_documentResults[index].totalAmount.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(_documentResults[index].maturityDate),
            ),
          ),
        ],
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