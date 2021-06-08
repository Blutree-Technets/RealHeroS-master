import 'package:firebase_database/firebase_database.dart';

class Track {
  String key;
  String title;
  double latitude;
  double longitude;

  Track(this.title, this.latitude, this.longitude);

  Track.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value['title'],
        latitude = snapshot.value['latitude'],
        longitude = snapshot.value['longitude'];

  toJson() {
    return {'title': title, 'latitude': latitude, 'longitude': longitude};
  }
}
