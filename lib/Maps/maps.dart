import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserMaps extends StatefulWidget {
  UserMaps({Key key}) : super(key: key);

  @override
  _UserMapsState createState() => _UserMapsState();
}

class _UserMapsState extends State<UserMaps> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  Location location = new Location();
  LatLng _center;
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
    _controller.complete(controller);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Emergency',
            style: TextStyle(color: Colors.red[900], fontSize: 20.0),
          ),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          alignment: Alignment.centerRight,
          children: [
            _center == null
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[900]),
                      backgroundColor: Colors.white,
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: screenHeight,
                    child: GoogleMap(
                      mapType: _currentMapType,
                      myLocationEnabled: true,
                      cameraTargetBounds: CameraTargetBounds.unbounded,
                      compassEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 15.0,
                      ),
                    ),
                  ),
            Positioned(
              bottom: 40,
              left: 10,
              //alignment: Alignment.centerLeft,
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
          ],
        ));
  }
}
