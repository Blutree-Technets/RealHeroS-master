import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';
import 'package:realheros_durga/Others/ImageCarousel.dart';

class Durga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Durga India',
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
                      ImageCarousel(),
                      _titleSection(),
                      _buttonSection(),
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
          Container(
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(20),
            child: Text(
              'Durga is a simple everyday set of deterrence and awareness '
              'skill that every woman and girl can use to understand behaviour '
              'and stay away from sexual harassment. ABCD is online modules on '
              'women safety with simple lectures, videos and assignments so'
              'that really Anybody can be a Durga! The course is designed '
              'to be simple and interesting for you to understand and practice. '
              'Go ahead, take a course and stay hooked to Durga!',
              softWrap: true,
              style: TextStyle(
                color: Colors.red[900],
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ]);
  }

  Widget _titleSection() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //  SizedBox(height: 10.0),
          Center(
              child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 165, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Online Courses',
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

  Widget _buttonSection() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
              child: new Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL1,
                      child: new Text(
                        'Introduction',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL2,
                      child: new Text(
                        'Sexual Harassment in Public Space',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL3,
                      child: new Text(
                        'Sexual Harassment in Colleges',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL4,
                      child: new Text(
                        'Sexual Harassment at Workspace',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL5,
                      child: new Text(
                        'Child Sexual Abuse',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL6,
                      child: new Text(
                        'Role of Bystander',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL7,
                      child: new Text(
                        'Physical Self-Defence',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL8,
                      child: new Text(
                        'Durga Habits, Oath and Promises',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL9,
                      child: new Text(
                        'Legal Provisions',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 15.0,
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      onPressed: _launchURL10,
                      child: new Text(
                        'How to Start a Durga Chapter',
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ])))
        ]);
  }

  _launchURL1() async {
    const url = 'http://www.beadurga.com/course/introduction/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL2() async {
    const url =
        'http://www.beadurga.com/course/sexual-harassment-in-public-space/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL3() async {
    const url = 'http://www.beadurga.com/course/sexual-harassment-in-colleges/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL4() async {
    const url =
        'http://www.beadurga.com/course/sexual-harassment-at-workspace/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL5() async {
    const url = 'http://www.beadurga.com/course/child-sexual-abuse/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL6() async {
    const url = 'http://www.beadurga.com/course/role-of-the-bystander/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL7() async {
    const url = 'http://www.beadurga.com/course/physical-self-defence/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL8() async {
    const url =
        'http://www.beadurga.com/course/durga-habits-the-oath-and-promises/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL9() async {
    const url = 'http://www.beadurga.com/course/legal-provisions/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL10() async {
    const url = 'http://www.beadurga.com/course/how-to-start-a-durga-chapter/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
