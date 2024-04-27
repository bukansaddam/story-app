import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app/screen/widgets/card_location.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({super.key});

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  final _initialLocation = const LatLng(-7.2773, 112.7900);
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};

  geo.Placemark? placemark;

  late LatLng locationData = const LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Location'),
        actions: [
          locationData != const LatLng(0, 0)
              ? IconButton(
                  onPressed: () {
                    context.pop(locationData);
                  },
                  icon: const Icon(Icons.done),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: _buildGoogleMap(),
    );
  }

  Widget _buildGoogleMap() {
    return Center(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialLocation,
            ),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            markers: markers,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            onLongPress: (LatLng latLng) async {
              try {
                final info = await geo.placemarkFromCoordinates(
                    latLng.latitude, latLng.longitude);

                if (info.isNotEmpty) {
                  setState(() {
                    placemark = info.first;
                    locationData = latLng;
                  });
                } else {
                  debugPrint('placemark: No placemark found');
                }
              } catch (e) {
                setState(() {
                  placemark = null;
                });
                debugPrint('Error fetching placemark: $e');
              }

              onLongPress(latLng);
            },
            onTap: (argument) {
              if (markers.isEmpty) {
                _snackBar('Long press to add marker');
              }

              setState(() {
                placemark = null;
                markers.clear();
                locationData = const LatLng(0, 0);
              });
            },
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'zoom-in',
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton.small(
                  heroTag: 'zoom-out',
                  onPressed: () {
                    mapController.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          if (placemark != null) CardLocation(placemark: placemark)
        ],
      ),
    );
  }

  void onLongPress(LatLng latLng) async {
    defineMarker(latLng);

    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(latLng, 14),
    );
  }

  void defineMarker(LatLng latLng) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  _snackBar(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
