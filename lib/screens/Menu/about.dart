import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _message =
        '''Feeding hopes to integrate food donation into sustainable living practices and responsible consumption habits. Feeding Hope can use to help hunger by earning some reward.Here user can upload there extra meal so that other hungery needy people can get it and that user will win some reward too.
 ''';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              Text("Our Purpose",
                  style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 2,
              ),
              Text("Empowering people to end global hunger",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 11, 15),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  color: Colors.orange.shade700,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Text(
                      _message,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/hungppl.png',
                  width: size.width * 0.8,
                ),
              ),
              SizedBox(height: 20),
              Text("Our Values",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              Text("A few important things we live by",
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.9,
                height: 155,
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.06),
                          Icon(CupertinoIcons.heart_fill,
                              color: Colors.red, size: 60),
                          SizedBox(width: size.width * 0.01),
                          Text("Open and honest",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          "We want you to know how your donation is used and the impact you’re having around the world.",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.9,
                height: 158,
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.06),
                          Icon(CupertinoIcons.hand_thumbsup_fill,
                              color: Colors.blueAccent, size: 60),
                          SizedBox(width: size.width * 0.01),
                          Text("We’re in it together",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Text(
                          "We want fighting hunger to be inclusive so that anyone, anywhere, can share the meal.",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Our Team",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("We are Developers from Depstar CE, CHARUSAT.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17)),
              ),
              SizedBox(height: 20),
              _TeamImages()
            ],
          )
        ],
      )),
    );
  }
}

class _TeamImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child:
                              Image.asset('images/maleAvtar.png', width: 200),
                        ),
                        Text(
                          "Moksh Ajmera",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child:
                              Image.asset('images/maleAvtar.png', width: 200),
                        ),
                        Text(
                          "Sanket Bhimani",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child:
                              Image.asset('images/maleAvtar.png', width: 200),
                        ),
                        Text(
                          "Raj Ganatra",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
