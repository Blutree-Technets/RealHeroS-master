import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotify extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PushNotifyState();
  }
}

class _PushNotifyState extends State<PushNotify> {
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getMessage();
  }

  void getMessage() {
    // _firebaseMessaging.configure(
    //     onMessage: (Map<String, dynamic> message) async {
    //   print('on message $message');
    //   setState(() => _message = message["notification"]["title"]);
    // }, onResume: (Map<String, dynamic> message) async {
    //   print('on resume $message');
    //   setState(() => _message = message["notification"]["title"]);
    // }, onLaunch: (Map<String, dynamic> message) async {
    //   print('on launch $message');
    //   setState(() => _message = message["notification"]["title"]);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Message: $_message"),
            OutlinedButton(
              child: Text("Register My Device"),
              onPressed: () {
                _register();
              },
            ),
            // Text("Message: $message")
          ]),
        ),
      ),
    );
  }
}
