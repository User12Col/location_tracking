import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_tracking/bloc/location_bloc.dart';
import 'package:location_tracking/location_service.dart';
import 'package:location_tracking/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
            create: (context) =>
                LocationBloc(locationService: LocationService())),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: ResultPage(),
      ),
    );
  }
}
