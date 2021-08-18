import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/frgt_pswd_rsp_msg.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../pages/Login.dart';
import '../pages/verify_otp.dart';
import '../services/api_helper.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);
  

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  User user;
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffF45C2C),
                      Color(0x66F45C2C),
                      Color(0x99F45C2C),
                      Color(0xccF45C2C),
                    ],
                  )),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Find your password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        _emailInput(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: _loginBtn(
                                    text: "SEND",
                                    onClick: () {
                                       final _futureUser = APIHelper()
                                      .createUser(_usernameController.text);
                                  _futureUser.then((value) => {
                                    if(value.result.message=="User found OTP has been sent."){
                                      SharedPreferenceHelper.save(
                                                  Configs.RESET_PASSWORD_DATA,
                                                  value.result),
                                       Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VerifyOTP(),
                                           settings: RouteSettings(
                                                      arguments: value.result),
                                          ),),
                                    }
                                    else{
                                      Text("OTP not sent")
                                    }
                                  });
                                    })),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child:
                                    _loginBtn(text: "CANCEL", onClick: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Login()));
                                    }))
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enter your username, mobile number or recovery email",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60.0,
          child: TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14, left: 14),
                hintText: "Username, ponenumber, email",
                hintStyle: TextStyle(
                  color: Colors.black38,
                )),
          ),
        )
      ],
    );
  }

  Widget _loginBtn({text, onClick}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            primary: Colors.white),
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xccF45C2C)),
        ),
      ),
    );
  }
}
