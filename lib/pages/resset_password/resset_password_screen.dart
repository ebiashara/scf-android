import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import '../../pages/sign_in/signin_screen.dart';
import '../../models/frgt_pswd_rsp_msg.dart';
import '../../configs/constants.dart';
import '../../models/resset_rsp_msg.dart';
import '../../widgets/default_button.dart';
import '../../configs/screen_configs.dart';
import '../../widgets/form_error_widget.dart';
import '../../models/login_resp_msg.dart';
import '../../services/api_helper.dart';

class RessetPasswordScreen extends StatefulWidget {
  const RessetPasswordScreen({Key key}) : super(key: key);
  static String routeName = '/resset_password_screen';

  @override
  _RessetPasswordScreenState createState() => _RessetPasswordScreenState();
}

class _RessetPasswordScreenState extends State<RessetPasswordScreen> {
   UserDetails userDetails;
  bool _isLoading = false;
  String errorMessage;
  String errorTitle;
  Future<UserResetResponseMessage> userResetResponseMessage;

  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  bool _isObscure = true;

  String confirmPassword, password;
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    String userID = user.userID;
    ScreenConfig().init(context);
     return Scaffold(
       appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: kBrightColor,
      ),
      body: Form(
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
                  EdgeInsets.symmetric(horizontal: getSizeOfScreenWidth(40)),
              child: Column(
                children: [
                  SizedBox(height: ScreenConfig.screenHeight * 0.05),
                  Text(
                    Constants.reset,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getSizeOfScreenWidth(80),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Constants.reset_title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: getSizeOfScreenHeight(40),
                  ),
                  buildPasswordFormField(
                      hint: Constants.new_password,
                      contoller: _passwordController,
                      onSavedValue: password),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: getSizeOfScreenHeight(60),
                  ),
                  buildConfirmPasswordFormField(
                      hint: Constants.confirm_password,
                      contoller: _confirmPasswordController,
                      onSavedValue: confirmPassword),
                  SizedBox(
                    height: getSizeOfScreenHeight(20),
                  ),
                  FormError(errors: errors),
                  SizedBox(
                    height: getSizeOfScreenHeight(40),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultButton(
                          press: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              userResetResponseMessage = APIHelper()
                                  .userResetPass(
                                      userID, _passwordController.text);
                              userResetResponseMessage.then((value) => {
                                    if (value.result.status ==
                                        Constants.success)
                                      {
                                        errorMessage = value.result.message,
                                        errorTitle =
                                            Constants.password_reset_succes,
                                        buildShowSuccessDialog(context),
                                      }
                                    else
                                      {
                                        errorMessage = value.result.message,
                                        errorTitle =
                                            Constants.password_reset_failed,
                                        buildShowDialog(context),
                                      }
                                  });
                            }
                          },
                          text: Constants.reset_text.toUpperCase(),
                        ),
                      ),
                      SizedBox(
                        width: getSizeOfScreenWidth(40),
                      ),
                      Expanded(
                        child: DefaultButton(
                          press: () {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          },
                          text: Constants.cancel.toUpperCase(),
                        ),
                      ),
                    ],
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

  Future buildShowSuccessDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: getSizeOfScreenHeight(40),
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    errorTitle,
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              content: Text(
                errorMessage,
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                    child: Text(
                      Constants.ok.toUpperCase(),
                      style: TextStyle(color: kBrightColor, fontSize: 20),
                    ))
              ],
            ));
  }

  Container buildPasswordFormField({String hint, contoller, onSavedValue}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenConfig.screenHeight * 0.02),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
          ]),
      height: ScreenConfig.screenHeight * 0.08,
      child: TextFormField(
        onSaved: (newValue) => onSavedValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPassNullError)) {
            setState(() {
              errors.remove(kPassNullError);
            });
          } else if (_passwordController.text ==
              _confirmPasswordController.text) {
            setState(() {
              errors.remove(kMatchPassError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kPassNullError)) {
            setState(() {
              errors.add(kPassNullError);
            });
          } else if (_passwordController.text !=
                  _confirmPasswordController.text &&
              !errors.contains(kMatchPassError)) {
            setState(() {
              errors.add(kMatchPassError);
            });
          }
          return null;
        },
        controller: contoller,
        obscureText: true,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only( left: ScreenConfig.screenWidth * 0.05),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xccF45C2C),
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xccF45C2C))),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black38)),
      ),
    );
  }

  Container buildConfirmPasswordFormField(
      {String hint, contoller, onSavedValue}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenConfig.screenHeight * 0.02),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
          ]),
      height: ScreenConfig.screenHeight * 0.08,
      child: TextFormField(
        onSaved: (newValue) => onSavedValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPassNullError)) {
            setState(() {
              errors.remove(kPassNullError);
            });
          } else if (_passwordController.text ==
              _confirmPasswordController.text) {
            setState(() {
              errors.remove(kMatchPassError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kPassNullError)) {
            setState(() {
              errors.add(kPassNullError);
            });
          } else if (_passwordController.text !=
                  _confirmPasswordController.text &&
              !errors.contains(kMatchPassError)) {
            setState(() {
              errors.add(kMatchPassError);
            });
          }
          return null;
        },
        controller: contoller,
        obscureText: true,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only( left: ScreenConfig.screenWidth * 0.05),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xccF45C2C),
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xccF45C2C))),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black38)),
      ),
    );
  }
}