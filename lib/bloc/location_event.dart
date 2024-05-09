import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

abstract class LocationEvent {}

class InitialLoadLocationEvent extends LocationEvent {
  
}

class LoadLocationInBackgroundEvent extends LocationEvent {
}



class LoadedLocationEvent extends LocationEvent {
  LoadedLocationEvent({required this.position});
  final Position position;
}
