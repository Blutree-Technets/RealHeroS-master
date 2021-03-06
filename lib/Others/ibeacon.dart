// // Copyright (c) 2020 Objectivity. All rights reserved.
// // Use of this source code is governed by The MIT License (MIT) that can be
// // found in the LICENSE file.

// import 'dart:async';
// import 'dart:io' show Directory, File, Platform;

// import 'package:audioplayer/audioplayer.dart';
// import 'package:beacon_monitoring/beacon_monitoring.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:wsd/dashboard.dart';

// class ibeacon extends StatefulWidget {
//   @override
//   _ibeaconState createState() => _ibeaconState();
// }

// /// This method will be called outside this flutter engine, so we cannot change the state of [_ibeaconState] in it.
// void backgroundMonitoringCallback(MonitoringResult result) {
//   print('Background monitoring received: $result');
// }

// class _ibeaconState extends State<ibeacon> {
//   var _bluetoothEnabled = 'UNKNOWN';
//   var _locationEnabled = 'UNKNOWN';
//   var _locationPermission = 'UNKNOWN';
//   var _debug = false;

//   StreamSubscription _monitoringStreamSubscription;
//   StreamSubscription _rangingStreamSubscription;

//   String mp3uri = '';
//   bool songplaying = false;
//   void playSound() {
//     AudioPlayer player = AudioPlayer();
//     if (!songplaying) {
//       player.play(mp3uri);
//     } else {
//       player.pause();
//     }
//     songplaying = !songplaying;
//   }

//   void _loadSound() async {
//     final ByteData data =
//         await rootBundle.load('assets/Indian Police siren.mp3');
//     Directory tempDir = await getTemporaryDirectory();
//     File tempFile = File('${tempDir.path}/Indian Police siren.mp3');
//     await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
//     mp3uri = tempFile.uri.toString();
//   }

//   @override
//   void initState() {
//     super.initState();
//       _loadSound();

//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     var locationPermission = await checkLocationPermission();
//     var bluetoothEnabled = await isBluetoothEnabled();
//     var locationEnabled = await isLocationEnabled();

//     setDebug(_debug);

//     if (locationPermission != LocationPermission.always) {
//       await requestLocationPermission();
//     }

//     if (Platform.isAndroid) {
//       if (!bluetoothEnabled) openBluetoothSettings();
//       if (!locationEnabled) openLocationSettings();
//     } else if (Platform.isIOS) {
//       if (!bluetoothEnabled || !locationEnabled) openApplicationSettings();
//     }

//     await registerAllRegions([_virtualBeacon()]);

//     locationPermission = await checkLocationPermission();
//     bluetoothEnabled = await isBluetoothEnabled();
//     locationEnabled = await isLocationEnabled();

//     setState(() {
//       _locationPermission = describeEnum(locationPermission);
//       _bluetoothEnabled = bluetoothEnabled ? 'ENABLED' : 'DISABLED';
//       _locationEnabled = locationEnabled ? 'ENABLED' : 'DISABLED';
//     });

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//   }

//   void _turnDebugOn() {
//     setDebug(true);
//     setState(() {
//       _debug = true;
//     });
//   }

//   void _turnDebugOff() {
//     setDebug(false);
//     setState(() {
//       _debug = false;
//     });
//   }

//   void _startBackgroundMonitoring() {
//     startBackgroundMonitoring(backgroundMonitoringCallback).catchError(
//       (e) => debugPrint(
//         'startBackgroundMonitoring catchError: $e',
//       ),
//     );
//   }

//   void _stopBackgroundMonitoring() {
//     stopBackgroundMonitoring();
//   }

//   bool _isListeningMonitoringStream() {
//     return _monitoringStreamSubscription != null;
//   }

//   void _startListeningMonitoringStream() {
//     if (!_isListeningMonitoringStream()) {
//       setState(() {
//         _monitoringStreamSubscription = monitoring().listen(
//           (event) {
//            // print("Monitoring stream received: $event");
//              //print("Monitoring stream received: $event");
//            playSound();
//           },
//           onError: (e) => debugPrint(
//             '_startListeningMonitoringStream catchError: $e',
//           ),
//         );
//       });
//     }
//   }

//   void _stopListeningMonitoringStream() {
//     if (_isListeningMonitoringStream()) {
//       _monitoringStreamSubscription.cancel();
//       setState(() {
//         _monitoringStreamSubscription = null;
//       });
//     }
//   }

//   bool _isListeningRangingStream() {
//     return _rangingStreamSubscription != null;
//   }

//   void _startListeningRangingStream() {
//     if (!_isListeningRangingStream()) {
//       setState(() {
//         _rangingStreamSubscription = ranging().listen(
//           (event) {
//             print("Ranging stream received: $event");
//           },
//           onError: (e) => debugPrint(
//             '_startListeningRangingStream catchError: $e',
//           ),
//         );
//       });
//     }
//   }

//   void _stopListeningRangingStream() {
//     if (_isListeningRangingStream()) {
//       _rangingStreamSubscription.cancel();
//       setState(() {
//         _rangingStreamSubscription = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('iBeacon'),
//         ),
//         body: Center(
//           child: ListView(
//             children: [
//               Text('Bluetooth enabled: $_bluetoothEnabled'),
//               Text('Location enabled: $_locationEnabled'),
//               Text('Location permission: $_locationPermission'),
//               _createDebugButton(),
//               _createBackgroundMonitoringButtons(),
//               _createListeningMonitoringStreamButton(),
//               _createListeningRangingStreamButton(),
//               _createGenericButton(
//                 'IS BLUETOOTH ENABLED',
//                 isBluetoothEnabled,
//               ),
//               _createGenericButton(
//                 'OPEN BLUETOOTH SETTINGS',
//                 openBluetoothSettings,
//               ),
//               _createGenericButton(
//                 'IS LOCATION ENABLED',
//                 isLocationEnabled,
//               ),
//               _createGenericButton(
//                 'CHECK LOCATION PERMISSION',
//                 checkLocationPermission,
//               ),
//               _createGenericButton(
//                 'REQUEST LOCATION PERMISSION',
//                 requestLocationPermission,
//               ),
//               _createGenericButton(
//                 'OPEN LOCATION SETTINGS',
//                 openLocationSettings,
//               ),
//               _createGenericButton(
//                 'REGISTER REGION',
//                 _registerVirtualBeaconRegion,
//               ),
//               _createGenericButton(
//                 'REGISTER ALL REGIONS',
//                 _registerVirtualBeaconsRegions,
//               ),
//               _createGenericButton(
//                 'REMOVE REGION',
//                 _removeVirtualBeaconRegion,
//               ),
//               _createGenericButton(
//                 'REMOVE ALL REGIONS',
//                 _removeVirtualBeaconsRegions,
//               ),
//               _createGenericButton(
//                 'IS MONITORING STARTED',
//                 isMonitoringStarted,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _createDebugButton() {
//     if (_debug) {
//       return RaisedButton(
//         onPressed: () => _turnDebugOff(),
//         child: Text("Turn debug off"),
//       );
//     } else {
//       return RaisedButton(
//         onPressed: () => _turnDebugOn(),
//         child: Text("Turn debug on"),
//       );
//     }
//   }

//   Widget _createBackgroundMonitoringButtons() {
//     return Row(
//       children: [
//         Flexible(
//           child: RaisedButton(
//             onPressed: () => _startBackgroundMonitoring(),
//             child: Text(
//               "Start background monitoring",
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         Flexible(
//           child: RaisedButton(
//             onPressed: () => playSound(),
//             //_stopBackgroundMonitoring(),
//             child: Text(
//               "Stop background monitoring",
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _createListeningMonitoringStreamButton() {
//     if (!_isListeningMonitoringStream()) {
//       return RaisedButton(
//         onPressed: () => _startListeningMonitoringStream(),
//         child: Text("Start listening on monitoring stream"),
//       );
//     } else {
//       return RaisedButton(
//         onPressed: () => _stopListeningMonitoringStream(),
//         child: Text("Stop listening on monitoring stream"),
//       );
//     }
//   }

//   Widget _createListeningRangingStreamButton() {
//     if (!_isListeningRangingStream()) {
//       return RaisedButton(
//         onPressed: () => _startListeningRangingStream(),
//         child: Text("Start listening on ranging stream"),
//       );
//     } else {
//       return RaisedButton(
//         onPressed: () => _stopListeningRangingStream(),
//         child: Text("Stop listening on ranging stream"),
//       );
//     }
//   }

//   Widget _createGenericButton(String text, Function onPressed) {
//     return RaisedButton(
//       onPressed: onPressed,
//       child: Text(text),
//     );
//   }

//   void _registerVirtualBeaconRegion() {
//     registerRegion(_virtualBeacon());
//   }

//   void _registerVirtualBeaconsRegions() {
//     registerAllRegions([_virtualBeacon()]);
//   }

//   void _removeVirtualBeaconRegion() {
//     removeRegion(_virtualBeacon());
//   }

//   void _removeVirtualBeaconsRegions() {
//     removeAllRegions([_virtualBeacon()]);
//   }

//   // https://community.estimote.com/hc/en-us/articles/200908836-How-to-turn-my-iPhone-into-a-Virtual-Beacon-
//   RegionIBeacon _virtualBeacon() => RegionIBeacon(
//         identifier: 'Virtual Beacon',
//         proximityUUID:
//         //"8ec76ea3-6668-48da-9866-75be8bc86f4d",
//         //"8ec76ea3-6668-48da-9866-75be8bc86f4d",
//         //'8492E75F-4FD6-469D-B132-043FE94921D8',
//         "0000ffe1-0000-1000-8000-00805f9b34fb"
//        // 'BEB5483E-36E1-4688-B7F5-EA07361B26A8',
//        // '0201041AFF4C000215A8261B3607EAF5B78846E1363E48B5BE00000005',
//       );
// }
