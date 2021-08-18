import 'dart:io';

import 'package:eb_scf_mobile_app/configs/colors.dart';
import 'package:eb_scf_mobile_app/configs/screen_configs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/Documents.dart';
import '../pages/contracts.dart';
import '../pages/dashboard/dashboard_screen.dart';
import '../pages/sign_in/signin_screen.dart';
import '../pages/task_details/task_details_screen.dart';

import '../configs/screen_configs.dart';
import '../models/cur_fin_resp_msg.dart';
import '../models/login_resp_msg.dart';
import '../models/shared_preferences/shared_pref_configs.dart';
import '../models/shared_preferences/shared_preferences.dart';

class SideNav extends StatefulWidget {
  const SideNav({Key key}) : super(key: key);

  @override
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  UserDetails userDetails;
  CustFinResponseMessage _custFinResponseMessage;
  bool _isLoading = false;
  String dropdownValue = 'KES';
  var email;
  var username;

  Future<String> customerSummary() async {
    setState(() {
      _isLoading = true;
    });
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));

    setState(() {
       username = userDets.username;
       email = userDets.emailAddress;
      _isLoading = false;
    });
  }

  @override
  @override
  void initState() {
    super.initState();
    customerSummary();
  }

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenConfig.screenWidth * 0.75,
      child: ListView(
        //removes the white space above the drawer
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: UserAccountsDrawerHeader(
              accountName: Text(username==null?"":username),
              accountEmail: Text(email==null?"":email),
              currentAccountPicture: CircleAvatar(
                radius: 60,
                child: ClipOval(
                  child: profileImage(),
                ),
              ),
              decoration: BoxDecoration(
                // if the image does not load display blue background
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kBrightColor,
                    // Color(0x66F45C2C),
                    kBrightColor
                    // Color(0xccF45C2C),
                  ],
                ),
                image: DecorationImage(
                    image: AssetImage('assets/backgroundimage.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Dashboard"),
            onTap: () =>
                {Navigator.pushNamed(context, DashboardScreen.routeName)},
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text("Contracts"),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cont()))
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text("Documents"),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Docs()))
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.notifications),
          //   title: Text("Notifications"),
          //   trailing: ClipOval(
          //     child: Container(
          //       color: Colors.red,
          //       width: 20.0,
          //       height: 20.0,
          //       child: Center(child: Text("2",style: TextStyle(color: Colors.white,fontSize: 12.0),)),
          //     ),
          //   ),
          //   // onTap: ()=>{
          //   //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()))
          //   // },
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Profile"),
            // onTap: ()=>{
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()))
            // },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text("Tasks"),
            onTap: () =>
                {Navigator.pushNamed(context, TaskDetailsScreen.routeName)},
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help"),
            // onTap: ()=>{
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Back()))
            // },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () => {
              // SharedPreferenceHelper.save(
              //           Configs.LOGIN_SESSION_DATA, value.result),
              Navigator.pushNamed(context, SignInScreen.routeName)
            },
          ),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/profpic.jpg")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (builder) => bottomSheet());
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 28.0,
            ),
          ),
        )
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
