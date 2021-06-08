import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:realheros_durga/Authentication/Service/authservice.dart';

class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AnimatedSplash(
      duration: 2000,
      imagePath: 'assets/durga-india.png',
      home: AuthService().handleAuth(),
    ));
  }
}
