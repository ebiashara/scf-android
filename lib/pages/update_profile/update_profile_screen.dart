import 'package:flutter/material.dart';
import '../../models/document_message.dart';
import '../../models/login_resp_msg.dart';
import '../../models/shared_preferences/shared_pref_configs.dart';
import '../../models/shared_preferences/shared_preferences.dart';
import '../../services/api_helper.dart';
import '../../widgets/notification_widget.dart';
import '../../widgets/popup_widget.dart';
import '../../configs/colors.dart';
import '../../configs/screen_configs.dart';
import '../../configs/constants.dart';
import 'dart:io';


import '../../pages/profile/profile_screen.dart';
import '../../widgets/success_btn.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  String title, firstname, lastname, companyName, altPhone, emailAddress;
  UpdateProfileScreen(
      {Key key,
      this.title,
      this.firstname,
      this.lastname,
      this.companyName,
      this.emailAddress,
      this.altPhone})
      : super(key: key);
  static String routName = "/update_profile_screen";

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  DocumentMessage documentMessage;
  bool _newLatterSubscription = false;
  bool _emailSubscription = false;
  bool _isLoading = false;
  String documentResult, status, message;

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _companyNameController = new TextEditingController();
  TextEditingController _altPhoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();


  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future editUser() async {
    var userDets = UserDetails.fromJson(
        await SharedPreferenceHelper.read(Configs.LOGIN_SESSION_DATA));
    var token = userDets.token;
    var userID = userDets.userID;
    // setState(() {
    //   _isLoading = true;
    // });

    documentMessage = await APIHelper().editUser(
        userID,
        _titleController.text,
        _firstnameController.text,
        _lastnameController.text,
        _emailController.text,
        _altPhoneController.text,
        token);

    setState(() {
      if (documentMessage.result.message == null) {
        message = documentMessage.message;
      } else {
        message = documentMessage.result.message;
      }
      if (documentMessage.result.status == null) {
        status = documentMessage.message;
      } else {
        status = documentMessage.status;
      }

      documentResult = documentMessage.statusCode;
    });
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      _titleController.text = widget.title;
      _firstnameController.text = widget.firstname;
      _lastnameController.text = widget.lastname;
      _companyNameController.text = widget.companyName;
      _altPhoneController.text = widget.altPhone;
      _emailController.text = widget.emailAddress;
      editUser();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.update_profile),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: kBrightColor,
        iconTheme:
            IconThemeData(color: Colors.white, size: getSizeOfScreenHeight(45)),
        actions: [
          NamedIcon(),
          Padding(
            padding: EdgeInsets.only(top: getSizeOfScreenHeight(5)),
            child: PopupWidget(),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
              ),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getSizeOfScreenWidth(40)),
                      child: Column(
                        children: [
                          // profileImage(),
                          SizedBox(
                            height: 20,
                          ),
                          _textInput(
                              label: "Mr/Mrs/Miss",
                              controller: _titleController,
                              onChanged: (value) {
                                setState(() {});
                              }),
                          _textInput(
                              label: "First name",
                              controller: _firstnameController,
                              onChanged: (value) {}),
                          _textInput(
                              label: "Last name",
                              controller: _lastnameController,
                              onChanged: (value) {
                                setState(() {});
                              }),
                          _textInput(
                              label: "Company name",
                              controller: _companyNameController,
                              onChanged: (value) {
                                setState(() {});
                              }),
                          _textInput(
                              label: "Email Address",
                              controller: _emailController,
                              onChanged: (value) {
                                setState(() {});
                              }),
                          newsLetterCheckbox(
                              "News letter", _newLatterSubscription),
                          emailCheckbox(
                              "Email Subscription", _emailSubscription),
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: SuccessBtn(
                                    btnText: "Saves",
                                    onPressed: () {
                                      editUser();
                                      if (documentResult== "200") {
                                        buildShowDialog(context);
                                      } else {
                                        print("document not added");
                                      }
                                    },
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: SuccessBtn(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ProfileScreen.routeName);
                                    },
                                    btnText: "Cancel",
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
              color: Colors.teal,
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

  Widget _textInput({String label, controller, onChanged}) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
      ),
    );
  }

  Widget newsLetterCheckbox(String title, bool boolValue) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                _newLatterSubscription = !_newLatterSubscription;
                _emailSubscription = !_emailSubscription;
              });
            }),
        Container(margin: EdgeInsets.only(left: 10.0), child: Text(title)),
      ],
    );
  }

  Widget emailCheckbox(String title, bool boolValue) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                _emailSubscription = !_emailSubscription;
              });
            }),
        Container(margin: EdgeInsets.only(left: 10.0), child: Text(title)),
      ],
    );
  }

  Future buildShowDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(status),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
            ));
  }
}
