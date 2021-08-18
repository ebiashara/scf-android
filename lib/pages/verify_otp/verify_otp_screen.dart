import 'package:flutter/material.dart';
import '../../configs/colors.dart';
import 'components/body.dart';

class OTPScreen extends StatelessWidget {
  
   OTPScreen({Key key}) : super(key: key);

   static String routeName = "/verify_otp_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: kBrightColor,
        // iconTheme: IconThemeData(color: Colors.black, size: getSizeOfScreenHeight(45)),
      ),
      body: Body(),
    );
  }
}