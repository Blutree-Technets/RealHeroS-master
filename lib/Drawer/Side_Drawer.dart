import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realheros_durga/Authentication/Service/authservice.dart';
import 'package:realheros_durga/Chat/Chat.dart';
import 'package:realheros_durga/Home/Home.dart';
import 'package:realheros_durga/Maps/maps.dart';
import 'package:realheros_durga/Maps/safezone.dart';
import 'package:realheros_durga/Others/About_Us.dart';
import 'package:realheros_durga/Others/Durga_Info.dart';
import 'package:realheros_durga/Profile/My_Profile.dart';

class AppDrawer extends StatefulWidget {
  final String uid;
  final String documentId;
  AppDrawer({Key key, this.uid, this.documentId}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _userName;
  String _userEmail;
  User user;

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    FirebaseFirestore.instance.collection('DURGA').doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
      setState(() {
        _userName = value.data()['fullname'].toString();
        _userEmail = value.data()['email'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE65100),
            Color(0xFFC62828),
            Color(0xFFD50000),
            Color(0xFFB71C1C),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
      //color: Colors.blue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.push(
                    context,
                    // ignore: missing_required_param
                    MaterialPageRoute(builder: (context) => new wsd()),
                  )),
          _createDrawerItem(
              icon: Icons.info_outline,
              text: 'My Profile',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactInfooId()),
                  )),
          _createDrawerItem(
              icon: Icons.map,
              text: 'Maps',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new UserMaps()),
                  )),
          _createDrawerItem(
              icon: Icons.feedback,
              text: 'Chat',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new Chats()),
                  )),
          _createDrawerItem(
              icon: Icons.perm_device_information,
              text: 'Apply As SafeZone',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new safezone()),
                  )),
          _createDrawerItem(
              icon: Icons.info_outline,
              text: 'About us',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new AboutPage()),
                  )),
          _createDrawerItem(
              icon: Icons.people,
              text: 'Durga India',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new Durga()),
                  )),
          // _createDrawerItem(
          //     icon: Icons.bluetooth,
          //     text: 'iBeacon',
          //     onTap: () => Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => new ibeacon()),
          //           //FlutterBlueApp()),
          //         )),
          Divider(
            thickness: 2.0,
            color: Colors.black,
          ),
          // new Container(
          //   child: ListTile(
          //       title: new Text(
          //         'Policies and Agreements',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       leading: Icon(
          //         Icons.format_list_numbered_rtl,
          //         color: Colors.black,
          //       ),
          //       onTap: () => Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => new FlutterBlueApp()),
          //           )
          //           ),
          // ),
          Positioned(
            bottom: 200.0,
            left: 10.0,
            child: ListTile(
                title: new Text(
                  'Log out',
                  style: TextStyle(color: Colors.amber),
                ),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                onTap: () {
                  AuthService().signOut();
                }),
          ),
        ],
      ),
    ));
  }

  Widget _createHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/durgadrawer.jpg'),
        ),
        color: Colors.red[900],
      ),
      accountName: _userName == null // If user location has not been found
          ? Center(
              // Display Progress Indicator
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              'Hello,$_userName',
              //"Name : " + user.userName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
              ),
            ),
      accountEmail: _userEmail == null // If user location has not been found
          ? Center(
              // Display Progress Indicator
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.white,
                // Animation<Color>: Colors.red[900],
              ),
            )
          : Text(
              '$_userEmail',
              //"Email : " + user.email,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
    );
  }

  Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 14.0),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
