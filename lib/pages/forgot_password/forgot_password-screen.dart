import 'package:flutter/material.dart';
import '../../configs/screen_configs.dart';
import '../../configs/colors.dart';
import '../../configs/constants.dart';
import '../../pages/verify_otp/verify_otp_screen.dart';
import '../../pages/sign_in/signin_screen.dart';
import '../../widgets/default_button.dart';
import '../../widgets/form_error_widget.dart';
import '../../services/api_helper.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = "/forgot_password";
  const ForgotPasswordScreen({Key key}) : super(key: key);
    
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _usernameController = TextEditingController();

  bool _isLoading = false;
  String errorMessage;
  String errorTitle;

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String username, password;
  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      
       appBar: AppBar(
        elevation: 0,
        backgroundColor: kBrightColor,
        iconTheme: IconThemeData(color: Colors.black, size: getSizeOfScreenHeight(45)),
      ),
      body:Form(
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
              padding:
                  EdgeInsets.symmetric(horizontal: screenVerticalPadding),
              child: Column(
                children: [
                  SizedBox(height: ScreenConfig.screenHeight * 0.05),
                  Text(
                    Constants.forgot_password,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getSizeOfScreenWidth(80),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: getSizeOfScreenHeight(30),
                  ),
                  Text(
                    Constants.forgot_password_title,
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
                  FormError(errors: errors),
                  SizedBox(
                    height: getSizeOfScreenHeight(60),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DefaultButton(
                        press: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            final _futureUser = APIHelper()
                                .createUser(_usernameController.text);
                            _futureUser.then((value) => {
                                  if (value.result.message ==
                                      Constants.otp_sent)
                                    {
                                      SharedPreferenceHelper.save(
                                          Configs.RESET_PASSWORD_DATA,
                                          value.result),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OTPScreen(),
                                          settings: RouteSettings(
                                              arguments: value.result),
                                        ),
                                      ),
                                    }
                                  else
                                    {
                                      errorMessage = value.result.message,
                                      errorTitle = Constants.user_not_found,
                                      buildShowDialog(context),
                                    }
                                });
                          }
                        },
                        text: Constants.send.toUpperCase(),
                      )),
                      SizedBox(
                        width: getSizeOfScreenWidth(30),
                      ),
                      Expanded(
                          child: DefaultButton(
                        press: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                        text: Constants.cancel.toUpperCase(),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: getSizeOfScreenHeight(40),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
            contentPadding:
                EdgeInsets.only( left: ScreenConfig.screenWidth * 0.05),
            hintText: Constants.username,
            hintStyle: TextStyle(color: Colors.black38)),
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
}