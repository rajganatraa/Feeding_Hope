import 'package:donation_app/admin/userlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Auth/login.dart';
import 'chatlist.dart';

class AdminPage extends StatefulWidget {
  final SharedPreferences prefs;

  const AdminPage({Key? key, required this.prefs}) : super(key: key);
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('images/logo.png', width: 30),
            SizedBox(width: 10),
            Text(
              'Feeding Hope',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        leading: Icon(
          CupertinoIcons.checkmark_shield,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.prefs.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(prefs: widget.prefs),
                  ),
                  (route) => false);
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ChatList(prefs: widget.prefs),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserList(prefs: widget.prefs)));
        },
        child: Icon(
          CupertinoIcons.chat_bubble_text,
          color: Colors.white,
        ),
      ),
    );
  }
}
