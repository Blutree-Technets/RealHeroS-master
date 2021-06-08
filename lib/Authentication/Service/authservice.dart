import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:realheros_durga/Authentication/Views/login_page.dart';
import 'package:realheros_durga/Home/Home.dart';
import 'package:realheros_durga/Others/ProgressDailog.dart';

class AuthService {
  //Determine if the user is authenticated.
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return wsd();
          } else
            return LoginPage();
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign In
  Future<void> signIn(String email, String password, context) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((authResult) => Firestore.instance
                .collection('DURGA')
                .document(authResult.user.uid)
                .get()
                .then((val) {
              print('signed in');
              //Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) =>
                      ProgressDialog('Logging you In'));
            }).catchError((e) {
              Navigator.pop(context);
              PlatformException thisEx = e;
              SnackBar(content: Text(thisEx.message));
            }));
  }

  //Signup a new user
  signUp(String email, String password, String fullName, String age,
      String token, context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((authResult) => Firestore.instance
                .collection("DURGA")
                .document(authResult.user.uid)
                .setData({
              "uid": authResult.user.uid,
              "email": email,
              "password": password,
              "fullname": fullName,
              "Age": age,
              "FCM-token": '$token',
            }))
        .then((val) {
      SnackBar(
        content: Text('Congrats, Registered Successfully!!'),
      );
      print('signed in');
    }).catchError((e) {
      PlatformException thisEx = e;
      SnackBar(content: Text(thisEx.message));
    });
  }

  //Reset Password
  resetPasswordLink(String email, password) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
