import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';
import 'package:realheros_durga/Others/Constants.dart';
import 'package:realheros_durga/Others/Custom_Card.dart';

class ContactInfooId extends StatefulWidget {
  ContactInfooId({
    Key key,
    this.title,
    this.uid,
  }) : super(key: key);

  final String title;
  final String uid;
  @override
  _ContactInfooIdState createState() => _ContactInfooIdState();
}

class _ContactInfooIdState extends State<ContactInfooId> {
  TextEditingController taskNameInputController;
  TextEditingController taskNumberInputController;
  TextEditingController taskAddressInputController;

  User currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String userName;
  String userEmail;
  int index;

  @override
  initState() {
    taskNameInputController = new TextEditingController();
    taskNumberInputController = new TextEditingController();
    taskAddressInputController = new TextEditingController();
    getCurrentUser();
    _getUserName1();
    //getEMC();
    super.initState();
  }

  Future getCurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null ? currentUser.uid : CircularProgressIndicator();
  }

  Future<void> _getUserName1() async {
    FirebaseFirestore.instance.collection('DURGA').doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
      setState(() {
        userName = value.data()['fullname'].toString();
        userEmail = value.data()['email'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      _dispDetails(),
                      _header(),
                      _addcontacts(),
                      _mycontacts(),
                      _displayEMC(),
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

  Widget _dispDetails() {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.all(5),
          // height: 80,
          // width: 80,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/durga-india.jpg'),
            radius: 40,
          ),
        ),
        // SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              userName == null // If user location has not been found
                  ? Center(
                      // Display Progress Indicator
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red[900],
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[900]),
                      ),
                    )
                  : Text(
                      'RealHero: $userName',
                      //"Name : " + user.userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
              SizedBox(height: 0.0),
              userEmail == null // If user location has not been found
                  ? Center(
                      // Display Progress Indicator
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[900]),
                        backgroundColor: Colors.red[900],
                        // Animation<Color>: Colors.red[900],
                      ),
                    )
                  : Text(
                      '$userEmail',
                      //"Email : " + user.email,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _displayEMC() {
    return Center(
      child: Container(
          height: 500.0,
          //color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('DURGA')
                  .doc(currentUser.uid)
                  .collection('Emergency Contacts')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.docs.map((DocumentSnapshot doc) {
                        if (snapshot.hasData)
                          //_showNotificationWithDefaultSound();

                          return Column(children: <Widget>[
                            new CustomCard(
                              Name: doc['Name'],
                              Number: doc['Number'],
                              Address: doc['Address'],
                            ),
                            ButtonBar(
                              children: <Widget>[
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.amber[700],
                                    child: const Text(
                                      'Call',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () async {
                                      FlutterPhoneDirectCaller.callNumber(doc['Number']);
                                    }),
                              ],
                            )
                          ]);
                      }).toList(),
                    );
                }
              })),
    );
  }

  Widget _header() {
    return Center(
      child: Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          padding: const EdgeInsets.fromLTRB(5, 30, 70, 10),
          child: Text(
            'Add Emergency Contacts',
            softWrap: true,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                // decoration: TextDecoration.underline,
                decorationColor: Colors.red[900]),
          )),
    );
  }

  Widget _mycontacts() {
    return Center(
      child: Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          padding: const EdgeInsets.fromLTRB(5, 5, 80, 10),
          child: Text(
            'My Emergency Contacts',
            softWrap: true,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                // decoration: TextDecoration.underline,
                decorationColor: Colors.red[900]),
          )),
    );
  }

  Widget _addcontacts() {
    // key: _registerFormKey,
    return Container(
      margin: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.red[900],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
          // key: _registerFormKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Name',
              style: kLabelStyle,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextFormField(
                  autofocus: false,
                  controller: taskNameInputController,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    // labelText: 'Name',
                    hintText: "Enter Name",
                    hintStyle: kHintTextStyle,
                  ),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.length < 3) {
                      return "Please enter a valid name.";
                    }
                  }),
            ),
            SizedBox(height: 20.0),
            Text(
              'Number',
              style: kLabelStyle,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextFormField(
                  autofocus: false,
                  controller: taskNumberInputController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    // labelText: 'First Name',
                    hintText: "Enter Contact Number",
                    hintStyle: kHintTextStyle,
                  ),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.length < 10) {
                      return "Please enter a valid number.";
                    }
                  }),
            ),
            SizedBox(height: 20.0),
            Text(
              'Address',
              style: kLabelStyle,
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextFormField(
                autofocus: false,
                controller: taskAddressInputController,
                keyboardType: TextInputType.streetAddress,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  // labelText: 'First Name',
                  hintText: "Enter Address",
                  hintStyle: kHintTextStyle,
                ),
                // controller: lastNameInputController,
                // ignore: missing_return
                validator: (value) {
                  if (value.length < 10) {
                    return "Please enter a valid Adress.";
                  }
                },
              ),
            ),
            SizedBox(height: 20.0),
            Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.amber[700],
                  padding: const EdgeInsets.all(20),
                  child: Text('Cancel'),
                  onPressed: () {
                    taskNameInputController.clear();
                    taskNumberInputController.clear();
                    taskAddressInputController.clear();
                    Navigator.pop(context);
                  }),
              SizedBox(width: 80.0),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.amber[700],
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Save',
                    //style: TextStyle(color: Colors.red[900]),
                  ),
                  onPressed: () async {
                    if (taskNameInputController.text.isNotEmpty &&
                        (taskNumberInputController.text.isNotEmpty) &&
                        (taskAddressInputController.text.isNotEmpty)) {
                      FirebaseFirestore.instance
                          .collection("DURGA")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection("Emergency Contacts")
                          .doc()
                          .set({
                            "Name": taskNameInputController.text,
                            "Number": taskNumberInputController.text,
                            "Address": taskAddressInputController.text,
                          })
                          .whenComplete(() => {
                                //  Navigator.pop(context),
                                taskNameInputController.clear(),
                                taskNumberInputController.clear(),
                                taskAddressInputController.clear(),
                              })
                          .catchError((err) => print(err));
                    }
                  })
            ]),
          ]),
    );
  }
}
