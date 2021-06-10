import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';

class General_emer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'General Emergencies',
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
          
                      SizedBox(height: 10.0),
                      _titleSection(),
                      _covidSection(),
                      _medicalSection(),
                      _roadSection(),
                      _mealSection(),
                      _missingSection(),
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
                  child: Row(
          children: [Text(
                    'GENERAL EMERGENCIES',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      // decoration: TextDecoration.underline,
                      // decorationColor: Colors.red[900]),
                    ),
                  ),
                  ],
                  )
                  ))
        ]);
  }

   Widget _covidSection() {
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
                  child:  Column(
          children: [Text(
                    'COVID RELIEF',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      // decoration: TextDecoration.underline,
                      // decorationColor: Colors.red[900]),
                    ),
                  ),
                  Text(
                    'Request- oxygen/beds/ambulance',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      // decoration: TextDecoration.underline,
                      // decorationColor: Colors.red[900]),
                    ),
                  )],)))   
        ]);
  }
    Widget _medicalSection() {
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
                    'General Medical Emergency',
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
    Widget _roadSection() {
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
                    'ROADSIDE ASSISTANCE',
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
    Widget _mealSection() {
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
                    'REQUEST A MEAL',
                    //https://soodcharityfoundation.org/
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
    Widget _missingSection() {
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
                    'MISSING CHILDREN/ pets/ items',
                   // https://trackthemissingchild.gov.in/trackchild/index.php
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

}
