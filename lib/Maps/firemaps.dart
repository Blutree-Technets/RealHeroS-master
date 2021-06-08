import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:realheros_durga/Maps/maps.dart';
import 'package:rxdart/rxdart.dart';

class Maps extends StatefulWidget {
  Maps({Key key, this.title, this.uid}) : super(key: key);
  final title;
  final uid;
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController mapController;
  User currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  BehaviorSubject<double> radius = BehaviorSubject.seeded(100.0);
  Stream<dynamic> query;
  StreamSubscription subscription;
  StreamSubscription subscription1;
  MapType _currentMapType = MapType.normal;
  Location location = new Location();
  LatLng _center;
  Position currentLocation;

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  getUserLocation() async {
    var currentLocation = await location.getLocation();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      //_startnewQuery();
      //_newQuery();
      mapController = controller;
    });
  }

  @override
  dispose() {
    subscription.cancel();
    subscription1.cancel();
    mapController.dispose();
    super.dispose();
  }

  // ignore: unused_element
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  // _newQuery() async {
  //   var pos = await location.getLocation();
  //   double lat = pos.latitude;
  //   double lng = pos.longitude;

  //   var ref = firestore.collection('SafeZoneLocation');
  //   GeoFirePoint center = geo.point(latitude: lat, longitude: lng);

  //   subscription1 = radius.switchMap((rad) {
  //     return geo.collection(collectionRef: ref).within(
  //         center: center, radius: rad, field: 'position', strictMode: true);
  //   }).listen(_updateMarkers2);
  // }

  // void _updateMarkers2(List<DocumentSnapshot> documentList) {
  //   documentList.forEach((DocumentSnapshot doc) {
  //     var data = doc.data['name'];
  //     GeoPoint pos = doc.data['position']['geopoint'];
  //     double distance = doc.data['distance'];
  //     var marker = MarkerOptions(
  //       position: LatLng(pos.latitude, pos.longitude),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //       infoWindowText:
  //           InfoWindowText(data, '$distance kilometers from query center'),
  //     );

  //     mapController.addMarker(marker);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        child: InkWell(
      child: new Container(
          padding: EdgeInsets.all(15.0),
          height: screenHeight / 3,
          width: 200.0,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            color: Colors.white,
            elevation: 10.0,
            child: Stack(
              children: [
                _center == null // If user location has not been found
                    ? Center(
                        // Display Progress Indicator
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[900]),
                          backgroundColor: Colors.white,
                        ),
                      )
                    : GoogleMap(
                        //markers: Set<Marker>.of(markers.values),
                        mapType: _currentMapType,
                        myLocationEnabled: true,
                        //myLocationEnabled: true,
                        compassEnabled: true,
                        //trackCameraposition: true,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 15.0,
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          onPressed: _onMapTypeButtonPressed,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.map,
                            color: Colors.red[900],
                            size: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 0.0,
                  child: Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.red[800],
                    min: 100,
                    max: 500,
                    divisions: 4,
                    value: radius.value,
                    label: 'Radius ${radius.value}km',
                    onChanged: _updateQuery,
                  ),
                ),
              ],
            ),
          )),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new UserMaps()),
      ),
    ));
    //  ),
    //   ),
    // );
  }

  void _updateQuery(value) {
    // final zoomMap = {
    //   100.0: 12.0,
    //   200.0: 10.0,
    //   300.0: 7.0,
    //   400.0: 6.0,
    //   500.0: 5.0,
    // };
    // final zoom = zoomMap[value];
    //mapController.moveCamera(CameraUpdate.zoomTo(zoom));

    setState(() {
      radius.add(value);
    });
  }
}
