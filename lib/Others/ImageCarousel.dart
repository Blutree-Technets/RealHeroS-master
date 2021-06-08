import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ImageCarousel extends StatefulWidget {
  _ImageCarouselState createState() => new _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    Widget carousel = new Carousel(
      boxFit: BoxFit.contain,
      images: [
        new AssetImage('assets/2.jpeg'),
        new AssetImage('assets/1.jpeg'),
        new AssetImage('assets/3.jpeg'),
        new AssetImage('assets/4.jpeg'),
      ],
      animationCurve: Curves.fastLinearToSlowEaseIn,
      animationDuration: Duration(seconds: 1),
    );
    return new Container(
      padding: const EdgeInsets.all(20.0),
      height: screenHeight / 3,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: new Stack(
          children: [
            carousel,
          ],
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
