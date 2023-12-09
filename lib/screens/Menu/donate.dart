import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:velocity_x/velocity_x.dart';

class DonatePage extends StatelessWidget {
  final String message =
      '''Thank you for your generous gift to Feeding Hope. We are thrilled to have your support. Through your donation we have been able to accomplish our goal and continue working towards feeding the needy people. You truly make the difference for us, and we are extremely grateful!''';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Donate Money \$',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size.width * 0.1),
                    bottomRight: Radius.circular(size.width * 0.1))),
            child: ListView(
              children: [
                Column(
                  children: [
                    Image.asset('images/donate_icon.png',
                        width: size.width, height: size.height * 0.33),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: size.width * 0.01)),
                      child: SizedBox(
                          height: size.height * 0.22,
                          // width: size.width * 0.,
                          child: Image.asset('images/QR_donate_crop.jpg')),
                    ),
                    SizedBox(
                      height: size.height * 0.009,
                    ),
                    Text(
                      'Scan the above QR to donate the money.',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
                  child: Container(
                    color: Colors.orange,
                    child: Text(message,
                        style: const TextStyle(
                            fontSize: 16.5,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400)),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
