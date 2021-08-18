import 'package:eb_scf_mobile_app/pages/Login.dart';
import 'package:eb_scf_mobile_app/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'pages/sign_in/signin_screen.dart';
import 'routes.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Ebiashara SCF',
      theme: ThemeData(
        fontFamily: "Mulish",
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.purple
         
        ),
        // home: SignInScreen(),
      routes: routes,
      initialRoute: SignInScreen.routeName,
    );
  }
  
}
