import '../../configs/screen_configs.dart';
import '../../widgets/notification_widget.dart';
import '../../widgets/sidenav.dart';
import '../../widgets/popup_widget.dart';
import 'package:flutter/material.dart';
import '../../pages/tasks/tasks_screen.dart';
import '../../models/cur_fin_resp_msg.dart';
import '../../models/login_resp_msg.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../services/api_helper.dart';
import '../../configs/constants.dart';
import '../../widgets/clip_path_widget.dart';
import '../../widgets/dashboard_card_widget.dart';
import '../../functions.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);
  static String routeName = '/dashboard_screen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserDetails userDetails;
  CustFinResponseMessage _custFinResponseMessage;
  bool _isLoading = false;
  String dropdownValue = 'KES';
  String amtFinanced = "";
  String noOfContracts = "";
  String noOfIDRs = "";
  String noOfIFRs = "";

  Future<String> customerFinancierSummary() async {
    String totalAmountFinanced = "0";
    String numberOfContracts = "0";
    String numberOfIDRs = "0";
    String numberOfIFRs = "0";

    setState(() {
      _isLoading = true;
    });
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    var compID = userDets.companyID;
    var token = userDets.token;

    _custFinResponseMessage =
        await APIHelper().customerFinancierSummary(compID, token);
    totalAmountFinanced = _custFinResponseMessage.result[0].amountFinanced;
    amtFinanced = totalAmountFinanced;
    numberOfContracts = _custFinResponseMessage.result[0].noOfContracts;
    noOfContracts = numberOfContracts;
    numberOfIDRs = _custFinResponseMessage.result[0].noOfIDRs;
    noOfIDRs = numberOfIDRs;
    numberOfIFRs = _custFinResponseMessage.result[0].noOfIFRs;
    noOfIFRs = numberOfIFRs;

    setState(() {
      amtFinanced = totalAmountFinanced;
      noOfContracts = numberOfContracts;
      noOfIDRs = numberOfIDRs;
      noOfIFRs = numberOfIFRs;
      _isLoading = false;
    });
  }

  @override
  @override
  void initState() {
    super.initState();
    customerFinancierSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        
        backgroundColor: Color.fromRGBO(255, 82, 48, 1),
        // leading: Icon(Icons.menu),
        actions: [
          NamedIcon(),
          Padding(
            padding: EdgeInsets.only(top: getSizeOfScreenHeight(5)),
            child: PopupWidget(),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomBar(),
       drawer: SideNav(),
      body: Container(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      ClipPathWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 15.0),
                                Row(
                                  children: [
                                    Text(
                                      Constants.amount_financed,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      amtFinanced == '' ? "0" : amtFinanced,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
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
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                            Material(
                              elevation: 1.0,
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.white,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, TasksScreen.routeName);
                                },
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 30.0),
                                child: Text(
                                  Constants.tasks.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      DasboardCardWidget(),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 20.0),
                          child: Text(
                            Constants.summary,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 35.0, bottom: 15.0, right: 35.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: buildCard(
                                  title: Constants.invoice_financed,
                                  value: noOfIFRs == "" ? "0" : noOfIFRs,
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                child: buildCard(
                                    title: Constants.invoice_discounted,
                                    value: noOfIDRs == "" ? "0" : noOfIDRs,
                                    color: Color(0xffF45C2C)),
                              ),
                            ],
                          ),
                        ),
                        // UpcomingTable(),
                        // OverdueTable(),
                      ],
                    ),
                  )
                ],
              ),
            ),
    ),
    );
  }
  

  
  // void barChoice(String choice) {
  //   if (choice == Constants.profile) {
  //     Navigator.pushNamed(context, ProfileScreen.routeName);
  //   } else if (choice == Constants.logout) {
  //     SharedPreferenceHelper.remove(Configs.LOGIN_SESSION_DATA);
  //     Navigator.pushNamed(context, SignInScreen.routeName);
  //   } else {}
  // }
}
