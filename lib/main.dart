import 'package:donation_app/screens/Home/home.dart';
import 'package:donation_app/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then(
    (prefs) {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(MyApp(prefs: prefs));
    },
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'irA',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: _checkUser(),
    );
  }

  _checkUser() {
    if (prefs.getBool('is_verified') != null) {
      if (prefs.getBool('is_verified')!) {
        if (prefs.getString('uid') == 'admin') return AdminPage(prefs: prefs);
        return HomePage(prefs: prefs);
      }
    }
    return welcompage(prefs: prefs);
  }
}
