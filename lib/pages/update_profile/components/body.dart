import 'dart:io';

import 'package:flutter/material.dart';
import '../../../configs/screen_configs.dart';
import '../../../pages/profile/profile_screen.dart';
import '../../../widgets/success_btn.dart';
import 'package:image_picker/image_picker.dart';
import '../../../configs/screen_configs.dart';

class UpdateBody extends StatefulWidget {
  String title, firstname, lastname,company_name,altPhone,email_address;
  UpdateBody({Key key, this.title, this.firstname, this.lastname,this.company_name,this.email_address,this.altPhone}) : super(key: key);

  @override
  UpdateBodyStae createState() => UpdateBodyStae();
}

class UpdateBodyStae extends State<UpdateBody> {
  bool _newLatterSubscription = false;
  bool _emailSubscription = false;
  bool _isLoading = false;

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _companyNameController = new TextEditingController();
  TextEditingController _altPhoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.title);
  }

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return _isLoading
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
                            label: "Mr/Mrs",
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
                        emailCheckbox("Email Subscription", _emailSubscription),
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: SuccessBtn(
                                  btnText: "Update",
                                  onPressed: () {},
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
}
