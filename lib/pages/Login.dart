import 'package:eb_scf_mobile_app/models/shared_preferences/shared_pref_configs.dart';
import 'package:eb_scf_mobile_app/models/shared_preferences/shared_preferences.dart';
import 'package:eb_scf_mobile_app/pages/dashboard/dashboard_screen.dart';
import 'package:eb_scf_mobile_app/services/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_details.dart';
import '../pages/forgot_password.dart';
import '../pages/sign_in/signin_screen.dart';
import '../services/device_info_helper.dart';
import '../services/ip_info_helpler.dart';
import '../services/package_ino_hnelper.dart';
import '../widgets/form_error_widget.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserDetails userDetails;
  bool _isLoading = false;
  bool _isRememberMe = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorMessage;
  String errorTitle;

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = ["Demo Error"];

  

  Future init() async {
    final ipAddress = await IpInfoHelper.getIpAddress();
    final deviceInfo = await DeviceInfoHelper.getDeviceInfo();
    final deviceVersion = await DeviceInfoHelper.getOsVersion();
    final operatingSystem = await DeviceInfoHelper.getOS();
    final screenResolution = await DeviceInfoHelper.getScreenResolution();
    final appVersion = await PackageInfoHelper.getPackageVersion();

    Map<String, dynamic> map = {};

    if (!mounted) return;
    setState(() => map = {
          "IP address": ipAddress,
          "Device Information": deviceInfo,
          "Operating system": operatingSystem,
          "Screen resolution": screenResolution,
          "Device Version": deviceVersion,
          "Application Version": appVersion,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ))
          : AnnotatedRegion<SystemUiOverlayStyle>(
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
                            Color(0xffff5624),
                            // Color(0x66ff5624),
                            Color(0x99ff5624),
                            // Color(0xccff5624),
                          ],
                        )),
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 120),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              _emailInput(),
                              SizedBox(height: 10.0,),
                              FormError(errors: errors),
                              SizedBox(
                                height: 20,
                              ),
                              _passwordInput(),
                             
                              _forgotPasswordBtn(),
                              _rememberMeCB(),
                              //  FormErrors(errors: errors),
                              SizedBox(
                                height: 40.0,
                              ),
                              _loginBtn()
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
          "Username",
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
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Color(0xccF45C2C),
                ),
                hintText: "Username",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget _passwordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Password",
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
            controller: _passwordController,
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
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget _forgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: GestureDetector(
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ForgotPassword()));
          },
        ),
      ),
    );
  }

  Widget _rememberMeCB() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: _isRememberMe,
                checkColor: Colors.orange,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _isRememberMe = value;
                  });
                },
              )),
          Text(
            "Remember me",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _loginBtn() {
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
        onPressed: () {
          //   if (_formKey.currentState.validate()) {
          //   _formKey.currentState.save();
          // }

          Navigator.push(
              context,
              (MaterialPageRoute(
                builder: (context) => SignInScreen(),
              )));

          final loginResult = APIHelper()
              .login(_usernameController.text, _passwordController.text, "ip");
          loginResult.then((value) => {
                if (value.result.status == "Success")
                  {
                    SharedPreferenceHelper.save(
                        Configs.LOGIN_SESSION_DATA, value.result),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                        settings: RouteSettings(arguments: value.result),
                      ),
                    )
                  }
                else if (value.result.status == "Fail")
                  {
                    errorMessage = value.result.message,
                    errorTitle = "Error",
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text(errorTitle),
                              content: Text(errorMessage),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Ok"))
                              ],
                            )),
                  }
                else
                  {}
              });
        },
        child: Text(
          "Login",
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xccF45C2C)),
        ),
      ),
    );
  }
}

