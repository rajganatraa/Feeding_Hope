import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ScrollImages extends StatefulWidget {
  @override
  _ScrollImagesState createState() => _ScrollImagesState();
}

class _ScrollImagesState extends State<ScrollImages> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: 480,
        // aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        // onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: [
        Image.asset('images/share1.png'),
        Image.asset('images/share2_2.jpg'),
        Image.asset('images/share3_2.jpg'),
        Image.asset('images/share4.png'),
        Image.asset('images/share5.png'),
      ],
    );
  }
}
