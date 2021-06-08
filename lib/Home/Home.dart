import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:realheros_durga/Drawer/Bottom_Drawer.dart';

// ignore: camel_case_types
class wsd extends StatelessWidget {
  const wsd({
    Key key,
    this.title,
    this.uid,
    this.userId,
  }) : super(key: key);
  final String title;
  final String uid;
  final String userId;

  static Location location = new Location();
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Geoflutterfire geo = Geoflutterfire();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
    );
  }
}
