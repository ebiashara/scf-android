import 'package:flutter/material.dart';
import '../../../pages/resset_password/resset_password_screen.dart';
import '../../../configs/constants.dart';
import '../../../configs/screen_configs.dart';
import '../../../pages/forgot_password/forgot_password-screen.dart';
import '../../../widgets/default_button.dart';
import '../../../configs/colors.dart';
import '../../../widgets/form_error_widget.dart';
import '../../../services/api_helper.dart';
import '../../../models/verify_otp_resp_msg.dart';
import '../../../models/frgt_pswd_rsp_msg.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Future<ResetPasswordResponseMessage> resetPasswordResponseMessage;

  TextEditingController _otpController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

   bool _isLoading = false;
  String errorMessage;
  String errorTitle;

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String otp;

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    String userID = user.userID;
    ScreenConfig().init(context);
    return Form(
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
              // Color(0x66ff5624),
              kDullColor,
              // Color(0xccff5624),
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
                    Constants.verify_otp,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getSizeOfScreenWidth(80),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: getSizeOfScreenHeight(30),
                  ),
                  Text(
                    Constants.otp_title,
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
                             resetPasswordResponseMessage = APIHelper()
                                .resetPass(userID, _otpController.text);
                            resetPasswordResponseMessage.then((value) => {
                                  if (value.result.message == Constants.otp_verified)
                                    {
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RessetPasswordScreen(),
                                              settings: RouteSettings(
                                                  arguments: user))),
                                    }

                                  else if(value.result.message == Constants.invalid_otp)
                                    {
                                      errorMessage = value.result.message,
                                      errorTitle = Constants.otp_failed,
                                      buildShowDialog(context),
                                    }
                                    else{}
                                });
                          }
                        },
                        text: Constants.confirm.toUpperCase(),
                      )),
                      SizedBox(
                        width: getSizeOfScreenWidth(30),
                      ),
                      Expanded(
                          child: DefaultButton(
                        press: () {
                          Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
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
      height: ScreenConfig.screenHeight * 0.08,
      child: TextFormField(
        onSaved: (newValue) => otp,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kOtpNullError)) {
            setState(() {
              errors.remove(kOtpNullError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kOtpNullError)) {
            setState(() {
              errors.add(kOtpNullError);
            });
          }
          return null;
        },
        controller: _otpController,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.only(top: 14, left: ScreenConfig.screenWidth * 0.05),
            hintText: "One Time PIN",
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
              content: Text(errorMessage,),
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
