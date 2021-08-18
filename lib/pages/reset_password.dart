import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/frgt_pswd_rsp_msg.dart';
import '../models/resset_rsp_msg.dart';
import '../pages/Login.dart';
import '../services/api_helper.dart';

class RessetPassword extends StatefulWidget {
  RessetPassword({Key key}) : super(key: key);

  @override
  _RessetPasswordState createState() => _RessetPasswordState();
}

class _RessetPasswordState extends State<RessetPassword> {
  Future<UserResetResponseMessage> userResetResponseMessage;
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                          "Reset password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        _passwordInput(
                            text: "New password",
                            controller: _confirmPasswordController,
                            hint: "Enter new password"),
                        SizedBox(
                          height: 20,
                        ),
                        _passwordInput(
                            text: "Confirm password",
                            controller: _passwordController,
                            hint: " Confirm your password"),
                        Row(
                          children: [
                            Expanded(
                                child: _loginBtn(
                                    text: "CONFIRM",
                                    onClick: () {
                                      userResetResponseMessage = APIHelper()
                                          .userResetPass(
                                              userID, _passwordController.text);
                                      userResetResponseMessage.then((value) => {
                                            if (value.result.status ==
                                                "Success")
                                              {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Login())),
                                              }
                                            else
                                              {Text("PAssword reset failed")}
                                          });
                                    })),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: _loginBtn(
                                    text: "CANCEL",
                                    onClick: () {
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

  Widget _passwordInput({String text, controller, hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
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
            controller: controller,
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xccF45C2C),
                ),
                hintText: hint,
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }
}
