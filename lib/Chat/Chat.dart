import 'package:flutter/material.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      // ignore: missing_required_param
      drawer: AppDrawer(),
      body: Center(
        child: Text('Chats'),
      ),
    );
  }
}
