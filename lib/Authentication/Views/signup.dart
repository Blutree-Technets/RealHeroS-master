import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:realheros_durga/Authentication/Service/authservice.dart';
import 'package:realheros_durga/Authentication/Views/login_page.dart';
import 'package:realheros_durga/Home/Home.dart';
import 'package:realheros_durga/Others/Constants.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = new GlobalKey<FormState>();

  String email, password, fullName, age;

  String token = '';

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

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

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  void getToken() async {
    token = await firebaseMessaging.getToken();
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

  String validatePswd(String value) {
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    } else {
      return null;
    }
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
            child: Form(key: formKey, child: _buildSignupForm())));
  }

  _buildSignupForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 50.0),
          Container(
              height: 160.0,
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
                      child: Text('Sign-Up',
                          style: TextStyle(
                            fontFamily: 'Trueno',
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))),
                  Positioned(
                      top: 135.0,
                      left: 145.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black)))
                ],
              )),
          SizedBox(height: 20.0),
          Text(
            'Full Name',
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
                  Icons.edit,
                  color: Colors.black,
                ),
                hintText: 'Enter your Full Name',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (value) {
                this.fullName = value;
              },
              // validator: (value) => value.isEmpty
              //     ? 'Full Name is required'
              //     : value.length < 20, cursorColor: Colors.white,
            ),
          ),
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
          SizedBox(height: 20.0),
          Text(
            'Age',
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
                  Icons.edit,
                  color: Colors.black,
                ),
                hintText: 'Enter your Age',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (value) {
                this.age = value;
              },
              // validator: (value) =>
              //     value.isEmpty ? 'Age is required' : value.length < 3
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Password',
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
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: 'Enter your Password',
                    hintStyle: kHintTextStyle,
                    suffixIcon: new InkWell(
                        onTap: _toggle,
                        child: _obscureText
                            ? Icon(
                                Icons.visibility,
                                color: Colors.orange,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.orange,
                              )
                        //new Text(_obscureText ? "Show" : "Hide")
                        )),
                obscureText: _obscureText,
                onChanged: (value) {
                  this.password = value;
                },
                validator: (value) => value.isEmpty
                    ? 'Password is required'
                    : validatePswd(value)),
          ),
          SizedBox(height: 20.0),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('By Registering, you accept all the ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(height: 5.0),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => wsd()));
                },
                child: Text(
                  '| Terms and Conditions |',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(height: 25.0),
            GestureDetector(
                onTap: () async {
                  var connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult != ConnectivityResult.mobile &&
                      connectivityResult != ConnectivityResult.wifi) {
                    SnackBar(content: Text("no internet connectivity"));
                    return;
                  }
                  if (checkFields())
                    AuthService()
                        .signUp(email, password, fullName, age, token, context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => wsd()));
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
                          'REGISTER',
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
                )),
            SizedBox(height: 20.0),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text('< Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ))),
          ])
        ]));
  }
}
