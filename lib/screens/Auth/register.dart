import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../data/save.dart';

class RegisterPage extends StatefulWidget {
  final SharedPreferences prefs;
  final String phoneNo;

  const RegisterPage({Key? key, required this.prefs, required this.phoneNo})
      : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  String _name = '', _gender = 'Male', _uType = 'Helper', _address = '';

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
      if (image == null) return;
      final imagePermanent = await saveImagePermanent(image.path);
      setState((() => this.image = imagePermanent));
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {}
  }

  Future<File> saveImagePermanent(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Widget _userProfile(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ImageProvider<Object>? backgroundImage = image != null
        ? FileImage(image!)
        : AssetImage('images/profile1.jpg') as ImageProvider;
    return Column(
      children: [
        SizedBox(height: size.height * 0.04),
        Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.3),
                    borderRadius: BorderRadius.circular(size.width * 0.25)),
                child: CircleAvatar(
                  radius: size.width * 0.25,
                  backgroundImage: backgroundImage,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 25,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.orange),
                  alignment: Alignment.bottomRight,
                  // width: size.width * 0.58,
                  // height: size.height * 0.28,
                  child: IconButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.orange)),
                    icon: Icon(
                      CupertinoIcons.photo_camera,
                      size: size.width * 0.08,
                      color: Colors.white,
                    ),
                    onPressed: () => pickImage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userName(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Your Name';
            } else {
              _name = value;
            }
            return null;
          },
          decoration: const InputDecoration(
              // labelText: "Username",
              labelStyle: TextStyle(color: Colors.orange),
              focusedBorder: OutlineInputBorder(
                  // borderSide:
                  //     BorderSide(color: Color.fromARGB(255, 16, 121, 174)),
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.orange,
              ),
              hintText: "Enter your Name ",
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
        ),
      ),
    );
  }

  Widget _userAddress(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Your Address';
            } else {
              _address = value;
            }
            return null;
          },
          decoration: const InputDecoration(
              // labelText: "Username",
              labelStyle: TextStyle(color: Colors.orange),
              focusedBorder: OutlineInputBorder(
                  // borderSide:
                  //     BorderSide(color: Color.fromARGB(255, 16, 121, 174)),
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              prefixIcon: Icon(
                Icons.location_city_rounded,
                color: Colors.orange,
              ),
              hintText: "Enter your Address ",
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
        ),
      ),
    );
  }

  Widget _userGender(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'Choose Your Gender',
          style: TextStyle(fontSize: 17, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.arrow_forward_ios, color: Colors.grey[500]),
            SizedBox(width: 10),
            ToggleSwitch(
              totalSwitches: 3,
              labels: ['Male', 'Female', 'Others'],
              icons: [Icons.male, Icons.female, Icons.call_split_rounded],
              cornerRadius: 30,
              minWidth: size.width * 0.28,
              minHeight: size.height * 0.06,
              onToggle: (index) {
                _gender = index == 0
                    ? 'Male'
                    : index == 1
                        ? 'Female'
                        : 'Others';
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _userType(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'Who are You',
          style: TextStyle(fontSize: 17, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.arrow_forward_ios, color: Colors.grey[500]),
            SizedBox(width: 10),
            ToggleSwitch(
              totalSwitches: 2,
              labels: ['Helper', 'Organisation'],
              icons: [
                CupertinoIcons.brightness_solid,
                CupertinoIcons.building_2_fill
              ],
              cornerRadius: 30,
              minWidth: size.width * 0.42,
              minHeight: size.height * 0.06,
              onToggle: (index) {
                _uType = index == 0 ? 'Helper' : 'Organisation';
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: Colors.orange,
      ),
      child: Center(
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await saveUserData(
                  context: context,
                  prefs: widget.prefs,
                  uname: _name,
                  ugender: _gender,
                  uType: _uType,
                  uaddress: _address,
                  phoneNo: widget.phoneNo,
                  uimage: image);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
          },
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _userForm(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            _userName(context),
            SizedBox(height: size.height * 0.03),
            _userAddress(context),
            SizedBox(height: size.height * 0.03),
            _userType(context),
            SizedBox(height: size.height * 0.03),
            _userGender(context),
            SizedBox(height: size.height * 0.03),
            _submitButton(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Your Information",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          _userProfile(context),
          _userForm(context),
        ],
      )),
    );
  }
}
