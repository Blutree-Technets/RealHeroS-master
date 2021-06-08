import 'dart:async';
import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';
import 'package:realheros_durga/Others/ImageCarousel.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class dashboard extends StatefulWidget {
  // dashboard({Key key, this.title}) : super(key: key);
  // final String title;
  final String uid;
  dashboard({Key key, @required this.uid}) : super(key: key);
  @override
  _dashboardState createState() => _dashboardState(uid);
}

enum PlayerState { stopped, playing, paused }

// ignore: camel_case_types
class _dashboardState extends State<dashboard> {
  GoogleMapController mapController;
  final String uid;
  _dashboardState(this.uid);
  Location location = new Location();
  //static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Geoflutterfire geo = Geoflutterfire();
  String token = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  User currentUser;
  LocationData currentLocation;

  Future<void> getLoc() async {
    currentLocation = await location.getLocation();
  }

  Future getCurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null ? currentUser.uid : CircularProgressIndicator();
  }

  String mp3uri = '';
  String _userName;
  bool songplaying = false;
  void playSound() {
    AudioPlayer player = AudioPlayer();
    if (!songplaying) {
      player.play(mp3uri);
    } else {
      player.pause();
    }
    songplaying = !songplaying;
  }

  void _loadSound() async {
    final ByteData data = await rootBundle.load('assets/Police Siren.mp3');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/Police Siren.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    mp3uri = tempFile.uri.toString();
  }

  Future<void> _getUserName() async {
    FirebaseFirestore.instance.collection('DURGA').doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
      setState(() {
        _userName = value.data()['fullname'].toString();
      });
    });
  }

  @override
  void initState() {
    _getUserName();
    getCurrentUser();
    getToken();
    getLoc();
    loc();
    super.initState();
    _loadSound();
  }

  Future<void> loc() async {
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      upDate();
    });
  }

  Future<void> upDate() async {
    //var uid = currentUser.uid;
    var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    var now = DateTime.now().toString();
    return FirebaseDatabase.instance
        .reference()
        .child('$_userName')
        .update({'Latitude': point.latitude, 'Longitude': point.longitude, 'Time': now});
  }

  void getToken() async {
    token = await firebaseMessaging.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      drawer: AppDrawer(
        uid: this.uid,
      ),
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
              ListView(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  //list(),
                  //Maps(),
                  ImageCarousel(),
                  _emergency(),
                  _header(),
                  _police(),
                  _medical(),
                  _safetyHelpline(),

                  _textSection(),
                ],
              ),
              //),
              //)
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _fcmToken() async {

  //   return firestore
  //       .collection('DURGA')
  //       .doc((await FirebaseAuth.instance.currentUser()).uid)
  //       .set(
  //           {'token': '$token'});
  // }

  Future<void> _sendLocation() async {
    var uid = currentUser.uid;
    var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    var now = DateTime.now().toString();
    return FirebaseDatabase.instance
        .reference()
        .child('$_userName')
        .set({'Name': '$_userName', 'UID': uid, 'Latitude': point.latitude, 'Longitude': point.longitude, 'Time': now});
  }

  Widget _emergency() {
    return Container(
        margin: EdgeInsets.all(15.0),
        //fromLTRB(15, 0, 15, 10),
        padding: const EdgeInsets.all(20),
        // ignore: deprecated_member_use
        child: RaisedButton(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.orange[500],
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Emergency',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red[900]),
          ),
          onPressed: () {
            _sendLocation(); //fun1
            playSound(); //fun2
          },
        ));
  }

  Widget _textSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 10.0),
      Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(20),
        child: Text(
          'Sexual Harassment is any unsolicited stare, glare, whistle,'
          'touch or any act that makes a woman feel sexually violated.'
          'Every second there are 1000s and 10s of 1000s of women who'
          'experience various forms of sexual harassment. Going beyond'
          'the facts and figures, what pierces the conscience further '
          'is the constant insecurity that has seeped into women, the '
          'inherent bundle of fear. A woman’s fear reflects on the way '
          'she dresses, in the way she sits and the way she walks. '
          'But isn’t it every woman’s right to feel safe and trust her '
          'space? How has that come to be regarded as a luxury?',
          softWrap: true,
          style: TextStyle(
            color: Colors.red[900],
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      )
    ]);
  }

  Widget _header() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 0.0),
      Center(
        child: Container(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            padding: const EdgeInsets.fromLTRB(5, 5, 120, 10),
            child: Text(
              'Emergency Contacts',
              softWrap: true,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  // decoration: TextDecoration.underline,
                  decorationColor: Colors.red[900]),
            )),
      )
    ]);
  }

  Widget _police() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      SizedBox(height: 10.0),
      Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Card(
            color: Colors.white,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.perm_identity),
                    title: Text(
                      'Police',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              onTap: () => launch("tel:100"),
            ),
          ))
    ]);
  }

  Widget _medical() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 10.0),
      Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Card(
            color: Colors.white,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  const ListTile(
                      leading: Icon(Icons.local_hospital),
                      title: Text(
                        'Ambulance',
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              onTap: () => launch("tel:108"),
            ),
          ))
    ]);
  }

  // ignore: non_constant_identifier_names
  Widget _safetyHelpline() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 10.0),
      Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 40),
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Card(
            color: Colors.white,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.phone_in_talk),
                    title: Text('Women Safety Helpline', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              onTap: () => launch("tel:1091"),
            ),
          ))
    ]);
  }
}
