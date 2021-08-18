import 'package:flutter/material.dart';
import '../configs/colors.dart';
import '../configs/screen_configs.dart';
import '../pages/dashboard/dashboard_screen.dart';
import '../pages/documents/documents_screen.dart';
import '../pages/profile/profile_screen.dart';
import '../pages/tasks/tasks_screen.dart';
import '../widgets/notification_widget.dart';
import '../widgets/popup_widget.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class CustomAnimatedBottomBar extends StatefulWidget {
  const CustomAnimatedBottomBar({Key key}) : super(key: key);

  @override
  _CustomAnimatedBottomBarState createState() => _CustomAnimatedBottomBarState();
}

class _CustomAnimatedBottomBarState extends State<CustomAnimatedBottomBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 82, 48, 1),
        leading: Icon(Icons.menu),
        actions: [
          NamedIcon(),
          Padding(
            padding: EdgeInsets.only(top: getSizeOfScreenHeight(5)),
            child: PopupWidget(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
      body: buildPages(),
    );
    
  }

   Widget _buildBottomBar() {
    return BottomNavyBar(
      // backgroundColor: Colors.black87,
      containerHeight: getSizeOfScreenHeight(80),
      selectedIndex: index,
      onItemSelected: (index) => setState(() => this.index = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text("Home"),
            activeColor: kBrightColor,
            inactiveColor: kDullColor,
            textAlign: TextAlign.center),
        BottomNavyBarItem(
            icon: Icon(Icons.assignment),
            title: Text("Tasks"),
            activeColor: kBrightColor,
            inactiveColor: kDullColor,
            textAlign: TextAlign.center),
        BottomNavyBarItem(
            icon: Icon(Icons.article),
            title: Text("Documents"),
            activeColor: kBrightColor,
            inactiveColor: kDullColor,
            textAlign: TextAlign.center),
        BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
            activeColor: kBrightColor,
            inactiveColor: kDullColor,
            textAlign: TextAlign.center)
      ],
    );
  }

  // Widget buildBody() => Center(
  //       child: Body(),
  //     );
  Widget buildPages() {
    switch (index) {
      case 0:
        return DashboardScreen();
        break;
      case 1:
        return TasksScreen();
         break;
      case 2:
        return DocumentsScreen();
         break;
      case 3:
        return ProfileScreen();
         break;
      default:
        return DashboardScreen();
    }
  }
}