import 'package:donation_app/screens/Auth/login.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: camel_case_types
class welcompage extends StatelessWidget {
  final SharedPreferences prefs;
  welcompage({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, size.height * 0.09, 0, size.height * 0.001),
                child: Image.asset('images/plate2_enh2.png'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(size.height * 0.015,
                    size.height * 0.001, 0, size.height * 0.002),
                child: Text(
                  "Feeding Hope",
                  textAlign: TextAlign.start,
                  textScaleFactor: size.height * 0.0019,
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.024),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(size.height * 0.009, 0, 0, 0),
                child: Text(
                  "You can help beat hunger!",
                  textAlign: TextAlign.start,
                  textScaleFactor: size.height * 0.0015,
                  style: context.captionStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.025,
                    size.height * 0.025,
                    size.width * 0.025,
                    size.height * 0.01),
                child: DottedBorder(
                  color: Colors.orange.shade300,
                  // strokeWidth: 1.2,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(15),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(size.width * 0.02,
                            size.height * 0.012, size.width * 0.01, 0),
                        child: Text(
                          "“If you knew what I know about the power of giving,\n you would not let a single meal pass without sharing it in some way.”",
                          textAlign: TextAlign.start,
                          // textScaleFactor: 1.3,
                          // softWrap: false,
                          style: GoogleFonts.robotoSlab(
                              // fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.018,
                              wordSpacing: 2.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(size.width * 0.6, 0,
                            size.height * 0.01, size.width * 0.04),
                        child: Text(
                          "– Gautam Buddha",
                          textAlign: TextAlign.end,
                          // textScaleFactor: 1.3,
                          // softWrap: false,
                          style: GoogleFonts.robotoSlab(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.019,
                              wordSpacing: 2.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(size.width * 0.04,
                    size.height * 0.12, size.width * 0.04, 0),
                child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(1000, 50),
                        backgroundColor: Colors.orange.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        shadowColor: Colors.black,
                        // overlayColor:
                        //     MaterialStateColor.resolveWith((states) => Colors.cyan),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(
                                prefs: prefs,
                              ),
                            ));
                        // if (_formkey.currentState!.validate()) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => homepage()));
                        // }
                      },
                      child: Text("Get Started",
                          style: GoogleFonts.robotoFlex(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
