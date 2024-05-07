import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  Stream<Position>? _positionStream;

  void startListening() async {
    bool checkPermisson = await checkPermission();
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (checkPermisson) {
      _positionStream = _geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 2,
        ),
      );
      StreamSubscription<Position> posStream = _positionStream!.listen((event) {
        print('Stream: ${event.latitude} - ${event.longitude}');
      });
    } else {
      print('into here');
    }
  }

  void stopListening() {}

  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }

  void onInitSuccess() {}

  void onError() {}

  void onChange() {}

  Stream<Position>? get positionStream => _positionStream;
}
