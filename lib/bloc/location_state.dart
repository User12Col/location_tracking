import 'package:geolocator/geolocator.dart';

class LocationState {}

class LocationInital extends LocationState {
  LocationInital();
}

class LocationLoadSuccess extends LocationState {
  Position position;
  LocationLoadSuccess({required this.position});

  LocationLoadSuccess copyWith({Position? position}) {
    return LocationLoadSuccess(position: position ?? this.position);
  }
}

class LocationLoadFailure extends LocationState {
  final String message;
  LocationLoadFailure({required this.message});
}
