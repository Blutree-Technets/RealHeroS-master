import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realheros_durga/Authentication/Service/authservice.dart';
import 'package:realheros_durga/Authentication/Views/signup.dart';
import 'package:realheros_durga/Others/Constants.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = new GlobalKey<FormState>();

  String email, password;

  Color greenColor = Color(0xFF00AF19);

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
            child: Form(key: formKey, child: _buildResetForm())));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Alert',
              style: TextStyle(
                fontFamily: 'Trueno',
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                    'Please check your '
                    'E-Mail for the Reset Link',
                    style: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 20.0,
                      color: Colors.black,
                      //fontWeight: FontWeight.w200,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text("Thank You",
                    style: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 20.0,
                      color: Colors.black,
                      //fontWeight: FontWeight.w300,
                    )),
              ),
              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: Row(children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Okay'))
                  ]))
            ],
          ),
        );
      },
    );
  }

  _buildResetForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 180.0,
              width: 250.0,
              child: Stack(
                children: [
                  Container(
                    // margin: EdgeInsets.fromLTRB(125, 100, 110, 580),
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            // color: Colors.grey[100],
                            blurRadius: 20.0)
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: AssetImage('assets/durga-india.png'),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 105.0,
                      child: Text('Reset Password',
                          style: TextStyle(
                            fontFamily: 'Trueno',
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))),
                  Positioned(
                      top: 135.0,
                      left: 290.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black)))
                ],
              )),
          SizedBox(height: 20.0),
          Text(
            'Email',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Trueno',
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            decoration: kBoxDecorationStyle,
            child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  hintText: 'Enter your Email',
                  hintStyle: kHintTextStyle,
                ),
                onChanged: (value) {
                  this.email = value;
                },
                validator: (value) =>
                    value.isEmpty ? 'Email is required' : validateEmail(value)),
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields())
                AuthService().resetPasswordLink(email, password);
              _showMyDialog();
              //Navigator.of(context).pop();
            },
            child: Container(
              height: 50.0,
              child: Material(
                  elevation: 5.0,
                  //padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'RESET',
                      style: TextStyle(
                        // color: Color(0xFF000000),
                        color: Color(0xFF527DAA),
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(height: 20.0),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('< Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ))),
            SizedBox(height: 250.0),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text('| Terms & Conditions |',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )))
          ])
        ]));
  }
}
