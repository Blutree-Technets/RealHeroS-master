import 'dart:async';
import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';

// ignore: camel_case_types
class notify extends StatefulWidget {
  @override
  _notifyState createState() => new _notifyState();
}

// ignore: camel_case_types
class _notifyState extends State<notify> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String mp3uri = '';
  bool songplaying = false;
  String notName;

  playSound() {
    AudioPlayer player = AudioPlayer();
    if (!songplaying) {
      player.play(mp3uri);
    } else {
      player.pause();
    }
    songplaying = !songplaying;
  }

  void _loadSound() async {
    final ByteData data = await rootBundle.load('assets/Siren.mp3');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/Siren.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    mp3uri = tempFile.uri.toString();
  }

  Future<void> _notifyName() async {
    FirebaseFirestore.instance.collection('locations').doc().get().then((doc) {
      setState(() {
        notName = doc['name'];
      });
    });
  }

  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings =
        new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
    _loadSound();
    _notifyName();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Notifications",
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

                  Center(
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('locations').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return new Text('Loading...');
                                default:
                                  return new ListView(
                                    children: snapshot.data.docs.map((DocumentSnapshot doc) {
                                      if (snapshot.hasData) {
                                        return Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            shadowColor: Colors.white,
                                            color: Colors.white,
                                            child: Container(
                                                height: 120.0,
                                                width: 400.0,
                                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      doc['name'],
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    Text(
                                                      'has requested your HELP!!!',
                                                      style: TextStyle(fontSize: 18),
                                                    ),
                                                    // Text('$name'),
                                                    ButtonBar(
                                                      children: <Widget>[
                                                        FlatButton(child: const Text('Maps'), onPressed: () {}
                                                            //   Navigator.push(
                                                            // context,
                                                            // MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             new direction()),
                                                            ),
                                                        RaisedButton(
                                                          child: const Text('Accept'),
                                                          onPressed: _showNotificationWithDefaultSound,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )));
                                      }
                                    }).toList(),
                                  );
                              }
                            })),
                  ),
                  //     ],
                  //   ),
                  // ),
                  //)
                ],
              ),
            ),
          ),
        ));
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("BluTree Technets"),
          content: Text("Welcome"),
        );
      },
    );
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('siren.mp3'),
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '$notName, has requested for your HELP!!!',
      'Please accept the request',
      platformChannelSpecifics,
    );
  }
}
