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
    }
    return null;
  }
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }
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
}
