import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Terms and conditions',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      // ignore: missing_required_param
      drawer: AppDrawer(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB71C1C),
                      Color(0xFFD50000),
                      Color(0xFFC62828),
                      Color(0xFFE65100),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 40.0,
                  //   vertical: 120.0,
                  // ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text(
                      //   'Apply As A SafeZone',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontFamily: 'OpenSans',
                      //     fontSize: 30.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(height: 10.0),
                      _titleSection(),
                      _textSection(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textSection() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
           Center(
              child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'IN USING THIS APPLICATION, YOU ARE DEEMED TO HAVE READ AND AGREED TO ALL THE FOLLOWING TERMS AND CONDITIONS.' 
'1. INTRODUCTION'
'Welcome to the RealHeroS mobile application or website, operated by BluTree Technology Networks in association with an all India NGO called Durga India whose aim is to deter sexual harassment.!'
'Durga India’s (“we”, “our”, or “us”) vision is to ensure safety for all against sexual harassment and a mission of orchestrating the role of all four players: men, women, communities and spaces in women’s safety. We believe that womanhood is to be loved, not feared. At Durga, we speak about everyday struggles that are silenced of dismissed and spell out what is silently conveyed.'
'Our mission is to build safe, inclusive public spaces by transforming the culture that perpetuates discrimination and violence. We intend on giving the power back to the citizens. We carry out this mission by building the power of people to create measurable and long-lasting impacts in the movement for public justice. The Services also permit users to learn about Durga India’s programs; view information about harassment, educational materials, videos, and news; and make donations.'
'•	PLEASE READ THESE TERMS OF USE CAREFULLY.'
'The Services permit users to (a) access information and other materials (“Content”) that we, our users, or third parties post to the Services or (b) submit Content to the Services. By accessing or using the Services in any way you are agreeing to comply with these Terms of Use, including any documents, policies, and guidelines incorporated by reference (“Terms”).'
'2. CHANGES TO THE TERMS OR SERVICES'
'We may change or modify the Terms from time-to-time without notice other than posting the amended Terms in our application. The amended Terms will automatically be effective when posted. Your continued use of the Services after any changes in these Terms shall constitute your consent to such changes. We reserve the right to change, modify or discontinue, temporarily or permanently, the Services (or any portion thereof), including any and all Content contained on the Services, at any time without notice. You agree that we and our related parties (including our affiliates, parents and subsidiaries) shall not be liable to you or to any third party for any modification, suspension or discontinuance of the Services (or any portion thereof).'
',',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      // decoration: TextDecoration.underline,
                      // decorationColor: Colors.red[900]),
                    ),
                  )))
        ]);
  }

  Widget _titleSection() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //  SizedBox(height: 10.0),
          Center(
              child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Terms and conditions for Users',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      // decoration: TextDecoration.underline,
                      // decorationColor: Colors.red[900]),
                    ),
                  )))
        ]);
  }

}
