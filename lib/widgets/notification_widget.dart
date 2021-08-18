import 'package:flutter/material.dart';
import '../configs/screen_configs.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../models/task_resp_msg.dart';
import '../models/user_details.dart';
import '../pages/tasks/tasks_screen.dart';
import '../services/api_helper.dart';

class NamedIcon extends StatefulWidget {
  const NamedIcon({
    Key key,
  }) : super(key: key);

  @override
  _NamedIconState createState() => _NamedIconState();
}

class _NamedIconState extends State<NamedIcon> {
  bool _isLoading = false;
  UserDetails userDetails;
  TaskResponseMessage _taskResponseMessage;

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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, TasksScreen.routeName);
      },
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.notification_important,
                  size: getSizeOfScreenHeight(40),
                ),
                // Text(text, overflow: TextOverflow.ellipsis),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                alignment: Alignment.center,
                child: Text(_results.length.toString()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
