import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../configs/constants.dart';
import '../models/frgt_pswd_rsp_msg.dart';
import '../models/verify_otp_resp_msg.dart';
import '../pages/Login.dart';
import '../pages/reset_password.dart';
import '../services/api_helper.dart';

class VerifyOTP extends StatefulWidget {
  VerifyOTP({Key key}) : super(key: key);

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController _otpController = TextEditingController();
  Future<ResetPasswordResponseMessage> resetPasswordResponseMessage;
  @override
  Widget build(BuildContext context) {
    
    final User user = ModalRoute.of(context).settings.arguments;
    String userID = user.userID;
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
                          Constants.otp_title,
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
                                    text: "CONFIRM",
                                    onClick: () {
                                       resetPasswordResponseMessage = APIHelper()
                                .resetPass(userID, _otpController.text);
                            resetPasswordResponseMessage.then((value) => {
                                  if (value.result.message == "OTP Verified")
                                    {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RessetPassword(),
                                              settings: RouteSettings(
                                                  arguments: user))),
                                    }
                                  else
                                    {Text("PAssword reset failed")}
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
          "One Time Password has been sent on your mobile no & email address.",
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
            controller: _otpController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14, left: 14),
                hintText: "Enter your 4 digit PIN",
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
