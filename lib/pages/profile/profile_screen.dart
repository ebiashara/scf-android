import 'package:flutter/material.dart';
import '../../widgets/notification_widget.dart';
import '../../widgets/popup_widget.dart';
import '../../configs/colors.dart';
import '../../configs/screen_configs.dart';
import '../../configs/constants.dart';
import '../../pages/dashboard/dashboard_screen.dart';
import '../../models/login_resp_msg.dart';
import '../../models/profile_response_message.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../pages/update_profile/update_profile_screen.dart';
import '../../services/api_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  static String routeName = "/profile_screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   UserDetails userDetails;
  ProfileResponseMessage _profileResponseMessage;
  List<UserProfile> _userprofile;
  List<TextEditingController> controllerInput;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _newLatterSubscription = false;
  bool _emailSubscription = false;
  bool _isLoading = false;
  String firstname,lastname, companyName, emailAddress, mobile_number;

  Future<List> _getUserprofile() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));
    String userID = userDets.userID;

    var token = userDets.token;
    setState(() {
      _isLoading = true;
    });
    _profileResponseMessage = await APIHelper().userprofile(userID, token);
    _userprofile = _profileResponseMessage.result;

    setState(() {
      _userprofile = _profileResponseMessage.result;
      lastname = _userprofile[0].lastName;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserprofile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.profile),
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
      body:  _isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.orange),
            ),
          )
        : Container(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getSizeOfScreenWidth(60)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(Constants.profile_firstname)),
                          Expanded(
                            flex: 2,
                            child:
                                _scfInput(inputText: _userprofile[0].firstName),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text(Constants.profile_lastname)),
                          Expanded(
                            flex: 2,
                            child:
                                _scfInput(inputText: _userprofile[0].lastName),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text(Constants.profile_title)),
                          Expanded(
                            flex: 2,
                            child: _scfInput(inputText: _userprofile[0].title),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text(Constants.company_name)),
                          Expanded(
                            flex: 2,
                            child: _scfInput(
                                inputText: _userprofile[0].companyName),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text(Constants.email_address)),
                          Expanded(
                            flex: 2,
                            child: _scfInput(
                                inputText: _userprofile[0].emailAddress),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text(Constants.phone_number)),
                          Expanded(
                            flex: 2,
                            child:
                                _scfInput(inputText: _userprofile[0].mobileNo),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text(Constants.alt_phone_number)),
                          Expanded(
                            flex: 2,
                            child:
                                _scfInput(inputText: _userprofile[0].phoneNo),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Text(Constants.role_name)),
                          Expanded(
                            flex: 2,
                            child:
                                _scfInput(inputText: _userprofile[0].roleName),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              child: newsLetterCheckbox(Constants.news_letter,
                                  _newLatterSubscription),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              child: emailCheckbox(Constants.email_subscription,
                                  _emailSubscription),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 20.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue)),
                                  onPressed: () =>
                                      editUserProfile(_userprofile),
                                  child: const Text(Constants.edit),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () {
                                    _getUserprofile();
                                    Navigator.pushNamed(
                                        context,DashboardScreen.routeName);
                                  },
                                  child: const Text(Constants.cancel),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  Widget _scfInput({String inputText}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(
        enabled: false,
        // controller: controllerInput[index],
        decoration: InputDecoration(
          hintText: inputText,
        ),
      ),
    );
  }

  //reusable checkbox
  Widget newsLetterCheckbox(String title, bool boolValue) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                _newLatterSubscription = !_newLatterSubscription;
                _emailSubscription = !_emailSubscription;
              });
            }),
        Container(margin: EdgeInsets.only(left: 10.0), child: Text(title)),
      ],
    );
  }

  Widget emailCheckbox(String title, bool boolValue) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                _emailSubscription = !_emailSubscription;
              });
            }),
        Container(margin: EdgeInsets.only(left: 10.0), child: Text(title)),
      ],
    );
  }

  editUserProfile(_userprofile) {
    var title = _userprofile[0].title.toString();
    var firstname = _userprofile[0].firstName.toString();
    var lastname = _userprofile[0].lastName.toString();
    var companyName = _userprofile[0].companyName.toString();
    var emailAddress = _userprofile[0].emailAddress.toString();
    var altPhone = _userprofile[0].phoneNo.toString();

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(altPhone: altPhone,emailAddress: emailAddress,companyName: companyName, title:title,firstname: firstname,lastname: lastname,)));
  }
}
