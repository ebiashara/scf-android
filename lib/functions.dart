import 'package:flutter/material.dart';
import 'widgets/DashCards.dart';

class AppFunctions {
   void barChoice(String choice) {
    if (choice == 'Profile') {
      print('profile');
    } else {
      print('Logout');
    }
  }
}


  Container buildCard({title,value,color}) {
    return Container(
      child: DashCards(
        title: title,
        value: value,
        color: color
      ),
    );
  }