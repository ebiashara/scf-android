import 'package:eb_scf_mobile_app/services/api_helper.dart';
import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../configs/constants.dart';
import '../../pages/dashboard/dashboard_screen.dart';
import '../../widgets/default_button.dart';
import '../../configs/screen_configs.dart';
import '../forgot_password/forgot_password-screen.dart';
import '../../widgets/form_error_widget.dart';
import '../../models/login_resp_msg.dart';
import '../../services/ip_info_helpler.dart';
import '../../services/package_ino_hnelper.dart';
import '../../services/device_info_helper.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
// import '../../services/api_helper.dart'

class SignInScreen extends StatefulWidget {
   const SignInScreen({Key key}) : super(key: key);

static String routeName = '/sign_in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
   UserDetails userDetails;
  bool _isLoading = false;
  String errorMessage;
  String errorTitle;

  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _isRememberMe = false;

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String username, password;

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
    ScreenConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: kBrightColor,
      ),
      
      body: 
     Form(
      key: _formKey,
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kBrightColor,
              kDullColor,
            ],
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenVerticalPadding),
              child: Column(
                children: [
                  SizedBox(height: ScreenConfig.screenHeight * 0.13),
                  Text(
                    Constants.sign_in,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getSizeOfScreenWidth(100),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Constants.sign_in_title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: getSizeOfScreenHeight(40),
                  ),
                  buildUsernameFormField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: getSizeOfScreenHeight(40),
                  ),
                  buildPasswordFormField(),
                  SizedBox(
                    height: getSizeOfScreenHeight(20),
                  ),
                  FormError(errors: errors),
                  Row(
                    children: [
                      _rememberMeCB(),
                      Spacer(),
                      _forgotPasswordBtn(),
                    ],
                  ),
                  SizedBox(
                    height: getSizeOfScreenHeight(40),
                  ),
                  DefaultButton(
                    press: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        final loginResult = APIHelper().login(
                            _usernameController.text,
                            _passwordController.text,
                            "ip");

                        loginResult.then((value) => {
                              if (value.result.status == Constants.success)
                                {
                                  _isLoading = false,
                                  SharedPreferenceHelper.save(
                                      Configs.LOGIN_SESSION_DATA, value.result),
                                  Navigator.pushNamed(
                                      context, DashboardScreen.routeName)
                                }
                              else if (value.result.status == Constants.fail)
                                {
                                  errorMessage = value.result.message,
                                  errorTitle = Constants.login_failed,
                                  buildShowDialog(context),
                                }
                              else
                                {}
                            });
                      }
                    },
                    text: Constants.login,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: getSizeOfScreenHeight(40),
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    errorTitle,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              content: Text(
                errorMessage,
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Constants.ok.toUpperCase(),
                      style: TextStyle(color: kBrightColor, fontSize: 20),
                    ))
              ],
            ));
  }

  Container buildPasswordFormField() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenConfig.screenHeight * 0.02),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
          ]),
      height: ScreenConfig.screenHeight * 0.06,
      child: TextFormField(
        onSaved: (newValue) => password,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPassNullError)) {
            setState(() {
              errors.remove(kPassNullError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kPassNullError)) {
            setState(() {
              errors.add(kPassNullError);
            });
          }
          return null;
        },
        controller: _passwordController,
        obscureText: true,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: textFieldPadding),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xccF45C2C),
            ),
            hintText: Constants.password,
            hintStyle: TextStyle(color: Colors.black38)),
      ),
    );
  }

  Container buildUsernameFormField() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenConfig.screenHeight * 0.02),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
          ]),
      height: ScreenConfig.screenHeight * 0.06,
      child: TextFormField(
        onSaved: (newValue) => username,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kEmailNullError)) {
            setState(() {
              errors.remove(kEmailNullError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kEmailNullError)) {
            setState(() {
              errors.add(kEmailNullError);
            });
          }
          return null;
        },
        controller: _usernameController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: textFieldPadding),
            prefixIcon: Icon(
              Icons.account_circle,
              color: Color(0xccF45C2C),
            ),
            hintText: Constants.username,
            hintStyle: TextStyle(color: Colors.black38)),
      ),
    );
  }

  Widget _forgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: GestureDetector(
          child: Text(
            Constants.forgot_password,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          onTap: () {
            Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
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
            Constants.remember_me,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
