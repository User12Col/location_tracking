import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracking/bloc/location_bloc.dart';
import 'package:location_tracking/bloc/location_event.dart';
import 'package:location_tracking/bloc/location_state.dart';
import 'package:location_tracking/location_manager.dart';
import 'package:location_tracking/location_service.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with WidgetsBindingObserver{
  late LocationService _locationService;
  // late LocationBloc _locationBloc;
  // late StreamSubscription<Position>? _positionSubscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _locationService = LocationService();
    _locationService.startListening();
    // _locationBloc = BlocProvider.of<LocationBloc>(context);
    // _locationBloc.add(EventLoadLocation());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print("Inactive");
        break;
      case AppLifecycleState.paused:
        print("Paused");
        _locationService.startListening();
        break;
      case AppLifecycleState.resumed:
        print("Resumed");
        break;
      case AppLifecycleState.hidden:
        print("Suspending");
        break;
      case AppLifecycleState.detached:
        print("Suspending");
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //     child: BlocBuilder<LocationBloc, LocationState>(
    //       builder: (context, state) {
    //         return Center(
    //           child: Text('${state.lat} - ${state.lng}'),
    //         );
    //       },
    //     ),
    //   ),
    // );
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: _locationService.positionStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              print('${snapshot.data!.latitude} - ${snapshot.data!.longitude}');
              return Center(
                child: Text(
                  '${snapshot.data!.latitude} - ${snapshot.data!.longitude}',
                ),
              );
            } else {
              return const Center(
                child: Text('No permission 1'),
              );
            }
          },
        ),
      ),
    );
  }
}
