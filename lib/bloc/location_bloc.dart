import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracking/bloc/location_event.dart';
import 'package:location_tracking/bloc/location_state.dart';
import 'package:location_tracking/location_service.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  Stream<Position>? positionStream;
  final LocationService _locationService;
  LocationBloc({required LocationService locationService})
      : _locationService = locationService,
        super(LocationInital()) {
    on<InitialLoadLocationEvent>(initialLocation);
    on<LoadedLocationEvent>(listenLocation);
  }

  Future<void> initialLocation(
      InitialLoadLocationEvent event, Emitter<LocationState> emit) async {
    try {
      final currentLocation = await _locationService.getCurrentPosition();
      if (currentLocation == null) {
        emit(LocationLoadFailure(
            message: 'Vào setting mở quyền sử dụng location'));
      } else {
        emit(LocationLoadSuccess(position: currentLocation));
      }
      // _positionSubscription?.cancel();

      positionStream = await _locationService.signUpListenLating();
      if (positionStream == null) {
        emit(LocationLoadFailure(message: 'Khôg thể khởi tạo luồng'));
      } else {
        positionStream!.listen((event) {
          print(
              'positionStream location: ${event.latitude} vs ${event.longitude}');
          // LoadedLocationEvent(position: event);
          add(LoadedLocationEvent(position: event));
          //  emit((state as LocationLoadSuccess).copyWith(position: event));
        });
      }
      // positionStream.
    } catch (err) {
      emit(LocationLoadFailure(message: err.toString()));
    }
  }

  Future<void> listenLocation(
      LoadedLocationEvent event, Emitter<LocationState> emit) async {
    try {
      if (state is LocationLoadSuccess) {
        state as LocationLoadSuccess;
        emit((state as LocationLoadSuccess).copyWith(position: event.position));
      }
    } catch (err) {
      emit(LocationLoadFailure(message: err.toString()));
    }
  }
}
