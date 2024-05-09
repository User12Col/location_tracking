import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  late Stream<Position> _positionStream;
  Stream<Position>? get positionStream => _positionStream;
  Future<Stream<Position>?> signUpListenLating() async {
    bool checkPermisson = await checkPermission();
    if (checkPermisson) {
      _positionStream = _geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1,
        ),
      );
      return _positionStream;
    } else {
      if (checkPermisson) {
        _positionStream = _geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 1,
          ),
        );
        return _positionStream;
      }
    }
    return null;
  }

  Future<Position?> getCurrentPosition() async {
    bool isAllowd = await checkPermission();
    if (isAllowd) {
      return await Geolocator.getCurrentPosition();
    }
    return null;
  }

  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("Go heree? checkPermission");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Go here? LocationPermission.denied");
        return false;
      }
    }
    return true;
  }
}
