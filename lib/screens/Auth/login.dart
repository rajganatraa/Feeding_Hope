import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../admin/home.dart';
import '../Home/home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  final SharedPreferences prefs;

  const LoginPage({Key? key, required this.prefs}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNo = " ";
  String smsOTP = '';
  String verificationId = '';
  String errorMessage = '';
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  initState() {
    super.initState();
  }

  Future<void> showLoading(BuildContext context, Size size) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              size: 70,
              color: Colors.orange,
            ),
          );
        });
  }

  Future<void> verifyPhone() async {
    if (_formKey.currentState!.validate()) {
      showLoading(context, Size.zero);
      try {
        final PhoneCodeSent smsOTPSent =
            (String verificationId, int? forceResendingToken) {
          this.verificationId = verificationId;
          smsOTPDialog(context).then((value) {});
        };
        await auth.verifyPhoneNumber(
            phoneNumber: this.phoneNo,
            codeAutoRetrievalTimeout: (String verId) {
              this.verificationId = verId;
            },
            codeSent: smsOTPSent,
            timeout: const Duration(seconds: 60),
            verificationCompleted:
                (PhoneAuthCredential phoneAuthCredential) async {},
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {}
            });
      } catch (e) {
        print('error');
        print(e);
        handleError(e);
      }
    } else {
      setState(() {});
    }
  }

  Future<void> smsOTPDialog(BuildContext context) async {
    Navigator.of(context).pop();
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter OTP '),
            icon: Icon(
              Icons.security,
              color: Colors.orange,
            ),
            content: Container(
              height: 60,
              width: 50,
              child: Column(children: [
                TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      this.smsOTP = value;
                    }),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  await auth
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: this.verificationId,
                          smsCode: this.smsOTP))
                      .catchError((onError) => handleError(onError))
                      .then((user) {
                    signIn();
                  });
                  showLoading(context, size);
                },
                child: Text('Verify'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  // side: BorderSide(style: BorderStyle.s/olid),
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      Navigator.of(context).pop();
      DocumentReference<Map<String, dynamic>> mobileRef = db
          .collection("mobiles")
          .doc(phoneNo.replaceAll(new RegExp(r'[^\w\s]+'), ''));
      await mobileRef.get().then((documentReference) {
        if (!documentReference.exists) {
          try {
            widget.prefs.setString('uid', documentReference.id);
            mobileRef.set({'uid': documentReference.id}).then(
                (documentReference) async {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(
                        prefs: widget.prefs, phoneNo: this.phoneNo),
                  ),
                  (route) => false);
            }).catchError((e) {});
          } catch (e) {}
        } else if (documentReference["uid"] == 'admin') {
          widget.prefs.setString('uid', documentReference["uid"]);
          widget.prefs.setBool('is_verified', true);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminPage(prefs: widget.prefs)),
              (route) => false);
        } else {
          widget.prefs.setString('uid', documentReference["uid"]);
          db
              .collection('users')
              .doc(documentReference['uid'])
              .get()
              .then((value) async {
            if (!value.exists) {
              try {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(
                          prefs: widget.prefs, phoneNo: this.phoneNo),
                    ),
                    (route) => false);
              } catch (e) {}
            } else {
              await getData(db, widget.prefs);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(prefs: widget.prefs),
                  ),
                  (route) => false);
            }
          });
        }
      }).catchError((e) {});
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> getData(dynamic db, SharedPreferences prefs) async {
    DocumentSnapshot data =
        await db.collection('users').doc(prefs.getString('uid')).get();
    if (data.exists) {
      Map<String, dynamic> userData = data.data() as Map<String, dynamic>;
      setState(() {
        prefs.setString('name', userData['name']);
        prefs.setString('gender', userData['gender']);
        prefs.setString('type', userData['type']);
        prefs.setString('address', userData['address']);
        prefs.setString('profImg', userData['profileImg']);
        prefs.setString('phone', userData['phone']);
        prefs.setInt('gift', userData['gift']);
        prefs.setBool('is_verified', true);
      });
    }
  }

  handleError(Object error) {
    switch (error) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {});
        break;
      default:
        setState(() {
          errorMessage = errorMessage;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _Banner(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, size.height * 0.06, 0, 0),
                    child: Text(
                      "Welcome back!",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.5,
                      style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, size.height * 0.03, size.width * 0.26, 0),
                    child: Text(
                      "Verify your phone number!",
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, size.height * 0.01, size.width * 0.15, 0),
                    child: Text(
                        "We will send you an OTP for mobile number verification.",
                        textAlign: TextAlign.start,
                        style: context.bodyMedium),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.04,
                        size.height * 0.028,
                        size.width * 0.04,
                        size.height * 0.04),
                    child: SizedBox(
                      child: TextFormField(
                        style: TextStyle(fontSize: size.width * 0.04),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Enter Valid Phone Number";
                          } else if (value.length < 10)
                            return "Enter Valid Phone Number";
                          return null;
                        }),
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: "+91 ",
                          // labelText: "Username",
                          labelStyle: TextStyle(color: Colors.orange),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: Colors.orange,
                          ),
                          hintText: " Enter your mobile number here ",
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        onChanged: (value) {
                          this.phoneNo = '+91$value';
                        },
                      ),
                    ),
                  ),
                  (errorMessage != ''
                      ? Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        )
                      : Container()),
                  // SizedBox(
                  //   height: 15.0,
                  //   width: 30.0,
                  // ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.03,
                        size.height * 0.2,
                        size.width * 0.03,
                        size.height * 0.05),
                    child: ElevatedButton(
                      onPressed: () async {
                        await verifyPhone();
                      },
                      child: Text(
                        "Get OTP",
                        style: TextStyle(
                          fontSize: size.height * 0.031,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(1000, 50),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        shadowColor: Colors.black,
                        // overlayColor:
                        //     MaterialStateColor.resolveWith((states) => Colors.cyan),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          "images/plate1_final1.png",
          // width: size.width,
          // height: size.height * 0.5,
        )
      ],
    );
  }
}
