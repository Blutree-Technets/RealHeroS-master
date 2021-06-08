import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:realheros_durga/Drawer/Side_Drawer.dart';
import 'package:realheros_durga/Others/Constants.dart';
import 'package:realheros_durga/Others/Custom_Card.dart';

// ignore: camel_case_types
class safezone extends StatefulWidget {
  safezone({Key key, this.title, this.uid, this.userId}) : super(key: key);
  final String title;
  final String uid;
  final String userId;

  @override
  _safezoneState createState() => _safezoneState();
}

// ignore: camel_case_types
class _safezoneState extends State<safezone> {
  static Location location = new Location();
  // ignore: unused_field
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Geoflutterfire geo = Geoflutterfire();
  bool isScrollingDown = true;

  TextEditingController taskNameInputController;
  TextEditingController taskVolNameInputController;
  TextEditingController taskNumberInputController;
  TextEditingController taskAgeInputController;
  TextEditingController taskGenderInputController;
  TextEditingController taskAddressInputController;
  User currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  initState() {
    taskNameInputController = new TextEditingController();
    taskVolNameInputController = new TextEditingController();
    taskNumberInputController = new TextEditingController();
    taskAgeInputController = new TextEditingController();
    taskGenderInputController = new TextEditingController();
    taskAddressInputController = new TextEditingController();
    _sendLocation();
    getCurrentUser();
    super.initState();
  }

  Future<dynamic> getCurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
  }

  // ignore: missing_return
  Future<DocumentReference> _sendLocation() async {
    var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    FirebaseFirestore.instance.collection('SafeZoneLocation').doc(currentUser.uid)
        // .collection("Location")
        // .doc(currentUser.uid)
        .set({'position': point.data, 'name': 'SafeZone'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Apply as a SafeZone",
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
                  // padding: EdgeInsets.symmetric(
                  // ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      _volName(),
                      _fullName(),
                      _askNum(),
                      _askAge(),
                      _askGender(),
                      _askAddress(),
                      _buildCancel(),
                      SizedBox(height: 20.0),
                      _buildSave(),
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

  Widget _volName() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      //SizedBox(height: 10.0),
      Text(
        'Volunteer\'s Name',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        width: 330,
        child: TextFormField(
            autofocus: true,
            controller: taskVolNameInputController,
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
              hintText: "Enter Volunteer's Name",
              hintStyle: kHintTextStyle,
            ),
            // ignore: missing_return
            validator: (value) {
              if (value.length < 3) {
                return "Please enter a valid name.";
              }
            }),
      ),
    ]);
  }

  // ignore: missing_return
  Widget _fullName() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 10.0),
      Text(
        'Name',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        width: 330,
        child: TextFormField(
            autofocus: true,
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
    ]);
  }

  // ignore: missing_return
  Widget _askNum() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 10.0),
      Text(
        'Number',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          width: 330,
          child: TextFormField(
              autofocus: true,
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
              })),
    ]);
  }

  Widget _askAge() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 10.0),
      Text(
        'Age',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        width: 330,
        child: TextFormField(
            autofocus: true,
            controller: taskAgeInputController,
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
              hintText: "Enter Age",
              hintStyle: kHintTextStyle,
            ),
            // ignore: missing_return
            validator: (value) {
              if (value.length < 10) {
                return "Please enter the correct Age.";
              }
            }),
      ),
    ]);
  }

  Widget _askGender() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 10.0),
      Text(
        'Gender',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        width: 330,
        child: TextFormField(
            autofocus: true,
            controller: taskGenderInputController,
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
              hintText: "Enter Gender",
              hintStyle: kHintTextStyle,
            ),
            // ignore: missing_return
            validator: (value) {
              if (value.length < 3) {
                return "Please enter a correct Gender.";
              }
            }),
      )
    ]);
  }

  Widget _askAddress() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 10.0),
      Text(
        'Address',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        width: 330,
        child: TextFormField(
          autofocus: true,
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
            if (value.length < 30) {
              return "Please enter a valid Adress.";
            }
          },
        ),
      )
    ]);
  }

  // ignore: missing_return
  Widget _buildCancel() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(height: 35.0),
      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.grey[300],
            padding: EdgeInsets.fromLTRB(45, 15, 45, 15),
            child: Text('Cancel'),
            onPressed: () {
              taskVolNameInputController.clear();
              taskNameInputController.clear();
              taskNumberInputController.clear();
              taskAgeInputController.clear();
              taskGenderInputController.clear();
              taskAddressInputController.clear();
              Navigator.pop(context);
            })
      ])
    ]);
  }

  // ignore: missing_return
  Widget _buildSave() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      SizedBox(width: 40.0),
      RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.grey[300],
          padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
          child: Text('Save'),
          onPressed: () {
            if (taskNameInputController.text.isNotEmpty &&
                (taskNumberInputController.text.isNotEmpty) &&
                (taskAddressInputController.text.isNotEmpty)) {
              FirebaseFirestore.instance
                  .collection("SafeZone")
                  .doc(currentUser.uid)
                  .collection('Contact Details')
                  .doc(currentUser.uid)
                  .set({
                    "Volunteer's Name": taskVolNameInputController.text,
                    "Name": taskNameInputController.text,
                    "Number": taskNumberInputController.text,
                    "Age": taskAgeInputController.text,
                    "Gender": taskGenderInputController.text,
                    "Address": taskAddressInputController.text,
                  })
                  .whenComplete(() => {
                        Navigator.pop(context),
                        taskVolNameInputController.clear(),
                        taskNameInputController.clear(),
                        taskNumberInputController.clear(),
                        taskAgeInputController.clear(),
                        taskGenderInputController.clear(),
                        taskAddressInputController.clear(),
                      })
                  .catchError((err) => print(err));
            }
          })
    ]);
  }
}

//   Widget _save = Container(
// margin: EdgeInsets.all(15.0),
// padding: const EdgeInsets.all(20),
// child: MaterialButton(
//   elevation: 10.0,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(30.0),
//   ),
//   color: Colors.red[900],
//   padding: EdgeInsets.all(20.0),
//   child: Text(
//     'Save',
//     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white),
//   ),
//  onPressed: _sendLocation,
//    ));

// ignore: unused_element
Widget _mysafezone() {
  return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.black,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
          // key: _registerFormKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children: snapshot.data.docs.map((DocumentSnapshot doc) {
                            return new CustomCard(
                              Name: doc['Name'],
                              Number: doc['Number'],
                            );
                          }).toList(),
                        );
                    }
                  },
                ))
          ]));
//           Text(
//             'Safe Zone 1',
//             style: kLabelStyle,
//           ),
//            StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance.collection('tasks')
//               .snapshots(),
//             builder: (BuildContext context,
//               AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError)
//                   return new Text('Error: ${snapshot.error}');
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     return new Text('Loading...');
//                   default:
//                     return new ListView(
//                       children: snapshot.data.docs
//                         .map((DocumentSnapshot doc) {
//                           return new CustomCard(
//                             Name: doc['Name'],
//                             Number: doc['Number'],
//                             Address: doc['Address'],
//                           );
//                       }).toList(),
//                     );
//           // Container(
//           //   alignment: Alignment.centerLeft,
//           //   decoration: kBoxDecorationStyle,
//           //   height: 60.0,
//           //   child: StreamBuilder<QuerySnapshot>(
//           //   stream: FirebaseFirestore.instance.collection('safe_zones')
//           //     .snapshots(),
//           //   builder: (BuildContext context,
//           //     AsyncSnapshot<QuerySnapshot> snapshot) {
//           //       if (snapshot.hasError)
//           //         return new Text('Error: ${snapshot.error}');
//           //       switch (snapshot.connectionState) {
//           //         case ConnectionState.waiting:
//           //           return new Text('Loading...');
//           //         default:
//           //           return new ListView(
//           //             children: snapshot.data.docs
//           //               .map((DocumentSnapshot doc) {
//           //             return new CustomCard(
//           //               Name: doc['Name'],
//           //               Number: doc['Number'],
//           //               Address: doc['Address'],
//           //             );
//           //             }).toList(),
//           //           );
//           //       }
//           //     },
//           //   ),

//           // ),
//           // SizedBox(height: 20.0),
//           // Text(
//           //   'Safe Zone 2',
//           //   style: kLabelStyle,
//           // ),

//           // Container(
//           //   alignment: Alignment.centerLeft,
//           //   decoration: kBoxDecorationStyle,
//           //   height: 60.0,

//           //   ),
//           //   SizedBox(height: 20.0),
//           // Text(
//           //   'Safe Zone 3',
//           //   style: kLabelStyle,
//           // ),

//           // Container(
//           //   alignment: Alignment.centerLeft,
//           //   decoration: kBoxDecorationStyle,
//           //   height: 60.0,

//           //   ),
//                  }} )
//         ]
//         ),
//     );
//       }
// }
}
