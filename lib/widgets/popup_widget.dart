import 'package:flutter/material.dart';
import '../configs/constants.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';
import '../pages/profile/profile_screen.dart';
import '../pages/sign_in/signin_screen.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconSize: 30,
        // onSelected: barChoice,
        itemBuilder: (BuildContext context) {
          return Constants.barChoices.map((String barChoice) {
            return PopupMenuItem<String>(
                child: GestureDetector(
                    onTap: () {
                      if (barChoice == Constants.profile) {
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        } else if (barChoice == Constants.logout) {
                          SharedPreferenceHelper.remove(Configs.LOGIN_SESSION_DATA);
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        } else {}
                    },
                    child: Text(barChoice)),
                value: barChoice);
          }).toList();
        });
  }
}
