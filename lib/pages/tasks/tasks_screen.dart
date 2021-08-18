import 'package:flutter/material.dart';
import '../../widgets/notification_widget.dart';
import '../../widgets/popup_widget.dart';
import '../../configs/colors.dart';
import '../../configs/screen_configs.dart';
import '../../configs/constants.dart';
import 'dart:async';

import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../models/task_resp_msg.dart';
import '../../models/user_details.dart';
import '../../pages/task_details/task_details_screen.dart';
import '../../services/api_helper.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key key}) : super(key: key);
  static String routeName = '/tasks_screen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  bool _isLoading = false;
  final _debouncer = Debouncer(mililiseconds: 500);
  UserDetails userDetails;
  TaskResponseMessage _taskResponseMessage;
  String _searchResult = '';
  TextEditingController _searchController = TextEditingController();

  List<Todos> _results;
  List<Todos> _filterResults;

  Future<List> _getTasks() async {
    setState(() {
      _isLoading = true;
    });
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var compID = userDets.companyID;
    var userID = userDets.userID;
    var token = userDets.token;

    _taskResponseMessage = await APIHelper().tasks(compID, userID, token);
    _results = _taskResponseMessage.result;

    setState(() {
      _results = _taskResponseMessage.result;
      _filterResults = _taskResponseMessage.result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _results = [];
    _getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text( Constants.tasks),
        elevation: 0,
        automaticallyImplyLeading: true,
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
                      if (_filterResults.length > 0) {
                        return _listItem(index);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                    itemCount: _filterResults.length,
                  ),
                ),
              ],
            ),
    ),
    );
  }_searchField() {
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
                  _filterResults = _results.where((documentResult) {
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
    _filterResults.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _filterResults.forEach((userDetail) {
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
              .contains(text.toLowerCase())) _filterResults.add(userDetail);
    });

    setState(() {});
  }
   _listItem(index) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: GestureDetector(
                child: Text(
                  _results[index].docID.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.blue),
                ),
                onTap: () {
                  SharedPreferenceHelper.save(
                      Configs.DOCUMENT_ID, _results[index]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TaskDetailsScreen(),
                          settings: RouteSettings(arguments: _results[index])));
                },
              ),
              subtitle: Text(_results[index].docType),
            ),
          ),
         Expanded(
              child: ElevatedButton(
            child: Text(_filterResults[index].status),
            style: _filterResults[index].status=="Checked"?ButtonStyle(
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
              title: Text(_results[index].totalAmount.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(_results[index].maturityDate),
            ),
          ),
        ],
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