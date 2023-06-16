import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

import '../../../core/controller/firestore_methods.dart';

class MapViewHotels extends StatefulWidget {
  const MapViewHotels({
    Key? key,
  }) : super(key: key);

  @override
  State<MapViewHotels> createState() => _MapViewHotelsState();
}

class _MapViewHotelsState extends State<MapViewHotels> {
  GoogleMapController? _mapController;
  final Location _location = Location();
  bool _myLocationButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _enableMyLocationButton();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreMethods firestoreMethods =
        Provider.of<FirestoreMethods>(context, listen: false);

    return FutureBuilder<List<DocumentSnapshot>>(
      future: firestoreMethods.getAllHotels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 400,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            height: 400,
            color: Colors.grey[200],
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData) {
          final hotels = snapshot.data!;
          return Stack(
            children: [
              SizedBox(
                height: 400,
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0), // Default initial position
                    zoom: 12,
                  ),
                  markers: _buildMarkers(hotels),
                  onMapCreated: (controller) {
                    _mapController = controller;
                    _getLocationAndMoveToCurrentPosition();
                  },
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer()))
                    ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer()))
                    ..add(Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer())),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: _myLocationButtonEnabled,
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: _getLocationAndMoveToCurrentPosition,
                  child: Icon(Icons.my_location),
                ),
              ),
            ],
          );
        } else {
          return Container(
            height: 400,
            color: Colors.grey[200],
          );
        }
      },
    );
  }

  Set<Marker> _buildMarkers(List<DocumentSnapshot> hotels) {
    return hotels.map((hotel) {
      final name = hotel['name'] ?? '';
      final location = hotel['location'] as GeoPoint?;
      final markerId = MarkerId(name);

      return Marker(
        markerId: markerId,
        position: LatLng(location?.latitude ?? 0, location?.longitude ?? 0),
        infoWindow: InfoWindow(
          title: name,
        ),
      );
    }).toSet();
  }

  Future<void> _getLocationAndMoveToCurrentPosition() async {
    LocationData? locationData;
    try {
      locationData = await _location.getLocation();
    } catch (e) {
      print('Error getting location: $e');
    }

    if (locationData != null) {
      final target = LatLng(locationData.latitude!, locationData.longitude!);
      final cameraPosition = CameraPosition(target: target, zoom: 15);
      _mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  void _enableMyLocationButton() {
    if (!kIsWeb) {
      setState(() {
        _myLocationButtonEnabled = true;
      });
    }
  }
}
