import 'package:flutter/material.dart';
//import '../task.dart';

class CustomCard extends StatelessWidget {
  // ignore: non_constant_identifier_names
  CustomCard({@required this.Name, this.Number, this.Address});

  // ignore: non_constant_identifier_names
  final Name;
  // ignore: non_constant_identifier_names
  final Number;
  // ignore: non_constant_identifier_names
  final Address;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.white,
        color: Colors.white,
        child: Container(
            height: 100.0,
            width: 400.0,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              //
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  Name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                Text(Number),
                Text(Address),
              ],
            )));
  }
}
