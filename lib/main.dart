import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:realheros_durga/Authentication/StartUp.dart';
import 'package:realheros_durga/Home/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'db2',
      options: const FirebaseOptions(
          googleAppID: '1:517676880304:android:1517e6dc3ecc2e773bc675',
          apiKey: 'AIzaSyAZp_tCNZIB6DR97NByBoLcwgNnw0TEEqE',
          databaseURL: 'https://wsd-c9257.firebaseio.com'));
  runApp(MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //await Firebase.initializeApp();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new StartUp(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => wsd(title: 'Home'),
        });
  }
}
