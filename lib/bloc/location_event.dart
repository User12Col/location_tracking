import 'package:geolocator/geolocator.dart';

abstract class LocationEvent {}

class InitialLoadLocationEvent extends LocationEvent {
  
}

class LoadedLocationEvent extends LocationEvent {
  LoadedLocationEvent({required this.position});
  final Position position;
}
