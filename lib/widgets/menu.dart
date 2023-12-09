import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';

import '../screens/Menu/about.dart';
import '../screens/Menu/contact.dart';
import '../screens/Menu/donate.dart';
import '../screens/Menu/profile.dart';

class MenuButton extends StatelessWidget {
  final SharedPreferences prefs;

  MenuButton({Key? key, required this.prefs}) : super(key: key);
  final GlobalKey<FabCircularMenuPlusState> fabKey = GlobalKey();

  Icon _chooseIcon(int i) {
    Icon icon = i == 0
        ? const Icon(
            CupertinoIcons.profile_circled,
            size: 35,
            color: Colors.white,
          )
        : i == 1
            ? const Icon(
                CupertinoIcons.profile_circled,
                size: 35,
                color: Colors.white,
              )
            : i == 2
                ? const Icon(
                    CupertinoIcons.money_dollar_circle,
                    size: 35,
                    color: Colors.white,
                  )
                : i == 3
                    ? const Icon(CupertinoIcons.chat_bubble_text_fill,
                        size: 35, color: Colors.white)
                    : const Icon(CupertinoIcons.info,
                        size: 35, color: Colors.white);

    return icon;
  }

  Color _chooseColor(int i) {
    Color color = i == 0
        ? Colors.red
        : i == 1
            ? Colors.blue
            : i == 2
                ? Colors.green
                : i == 3
                    ? Colors.pink
                    : Colors.deepOrange;
    return color;
  }

  choosePage(int i, BuildContext context) {
    // ignore: unnecessary_statements
    return i == 0
        ? () {}
        : i == 1
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(prefs: prefs)),
                );
              }
            : i == 2
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DonatePage()),
                    );
                  }
                : i == 3
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactPage(prefs: prefs)),
                        );
                      }
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutPage()),
                        );
                      };
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(
      builder: (context) => FabCircularMenuPlus(
        key: fabKey,
        alignment: Alignment.bottomRight,
        ringColor: Colors.grey.withAlpha(170),
        ringDiameter: size.width * 0.85,
        ringWidth: size.width * 0.19,
        fabSize: size.width * 0.15,
        fabElevation: 8.0,
        fabIconBorder: const CircleBorder(),
        fabColor: Colors.orange,
        fabOpenIcon: Icon(
          Icons.add,
          color: Colors.white,
          size: size.width * 0.08,
        ),
        fabCloseIcon: Icon(
          Icons.cancel_rounded,
          color: Colors.white,
          size: size.width * 0.08,
        ),
        fabMargin: const EdgeInsets.fromLTRB(1.0, 2, 1, 0),
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOutCirc,
        children: <Widget>[
          for (int i = 1; i < 5; i++)
            _CirCularButton(
              // width: size.width * 0.2,
              // height: size.height * 0.1,
              color: _chooseColor(i),
              icon: _chooseIcon(i),
              onClick: choosePage(i, context),
            )
        ],
      ),
    );
  }
}

class _CirCularButton extends StatelessWidget {
  // final double width;
  // final double height;
  final Color color;
  final Icon icon;
  final VoidCallback onClick;
  const _CirCularButton({
    Key? key,
    // required this.width,
    // required this.height,
    required this.color,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: IconButton(
          icon: icon,
          enableFeedback: true,
          onPressed: onClick,
        ),
      ),
    );
  }
}
