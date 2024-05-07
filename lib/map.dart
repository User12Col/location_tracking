import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng srcLocation = LatLng(10.759284, 106.585716);
  final LatLng desLocation = LatLng(10.759284, 106.635716);

  List<LatLng> latLngs = [];
  LocationData? currLocation;

  void getCurrLocation() {
    Location location = Location();
    location.getLocation().then((value){
      currLocation = value;
    });
  }

  void getLine() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyD7P-UD8NIwlm87O8H2go_qUJqt_lFqG8o',
      PointLatLng(srcLocation.latitude, srcLocation.longitude),
      PointLatLng(desLocation.latitude, desLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng pointLatLng) => latLngs.add(
          LatLng(pointLatLng.latitude, pointLatLng.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrLocation();
    super.initState();
    getLine();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currLocation == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currLocation!.latitude!, currLocation!.longitude!),
                    zoom: 14.5),
                markers: {
                  Marker(markerId: MarkerId('desID'), position:srcLocation),
                  Marker(
                    markerId: MarkerId('id'),
                    position: LatLng(
                        currLocation!.latitude!, currLocation!.longitude!),
                  ),
                  Marker(markerId: MarkerId('desID'), position: desLocation),
                },
                polylines: {
                  Polyline(
                      polylineId: PolylineId('lineID'),
                      points: latLngs,
                      color: Colors.blue,
                      width: 6)
                },
              ),
      ),
    );
  }
}
