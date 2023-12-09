import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/Foods/foodlist.dart';
import '../screens/Foods/share.dart';

class ShareButtons extends StatelessWidget {
  final SharedPreferences prefs;

  const ShareButtons({Key? key, required this.prefs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Card(
        color: Colors.orange,
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              prefs.getString('type') == 'Helper'
                  ? 'Share Your Meal'
                  : prefs.getString('type') == 'Organisation'
                      ? 'Available Meals'
                      : 'Type of Meals',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      width: size.width * 0.44,
                      child: _CirButton(
                          prefs: prefs,
                          title: 'CookedFood',
                          imgurl: 'cooked3')),
                ),
                Expanded(
                  child: Container(
                      width: size.width * .44,
                      child: _CirButton(
                          prefs: prefs,
                          title: 'UncookedFood',
                          imgurl: 'uncooked2')),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      width: size.width * .44,
                      child: _CirButton(
                          prefs: prefs,
                          title: 'Fruits&Vegies',
                          imgurl: 'fruits1')),
                ),
                Expanded(
                  child: Container(
                      width: size.width * .44,
                      child: _CirButton(
                          prefs: prefs,
                          title: 'OtherThings',
                          imgurl: 'other_things')),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

class _CirButton extends StatelessWidget {
  final String title;
  final String imgurl;
  final SharedPreferences prefs;
  const _CirButton({
    Key? key,
    required this.title,
    required this.imgurl,
    required this.prefs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder(eccentricity: 0.2)),
            ),
            // radius: size.width * 0.12,
            onPressed: () {
              if (prefs.getString('type') == 'Helper') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SharePage(ftype: title, prefs: prefs)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FoodList(ftype: title, prefs: prefs)));
              }
            },
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/' + imgurl + '.png'),
                  radius: size.width * 0.12,
                ),
              ],
            )),
        SizedBox(
          height: size.height * 0.009,
        ),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.019,
              color: Colors.white),
        )
      ],
    );
  }
}
