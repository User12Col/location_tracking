import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracking/bloc/location_bloc.dart';
import 'package:location_tracking/bloc/location_event.dart';
import 'package:location_tracking/bloc/location_state.dart';
import 'package:location_tracking/location_service.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with WidgetsBindingObserver {
  // late LocationBloc _locationBloc;
  // late StreamSubscription<Position>? _positionSubscription;
  late Position currentPosition;
  late LocationService locationSerivce;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    locationSerivce = LocationService();

    // _locationService.signUpListenLating();
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
        // _locationService.listening();
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
      body: SafeArea(child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationInital) {
            context.read<LocationBloc>().add(InitialLoadLocationEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LocationLoadSuccess) {
            return Center(
              child: Text(
                  'Your location: ${state.position.latitude} - ${state.position.longitude}'),
            );
          }

          return const Center(
            child: Text('Something went wrong:))'),
          );
        },
      )),
    );
  }
}
