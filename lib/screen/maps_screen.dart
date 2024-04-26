import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app/screen/widgets/card_location.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final initialLocation = const LatLng(-7.2773, 112.7560);

  late GoogleMapController mapController;

  geo.Placemark? placemark;

  late final Set<Marker> markers;

  @override
  void initState() {
    super.initState();
    addManyMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Location'),
      ),
      body: _buildGoogleMap(),
    );
  }

  void addManyMarker() {
    markers = context
        .read<StoryProvider>()
        .stories
        .map(
          (story) => Marker(
            markerId: MarkerId(story.id),
            position: LatLng(story.lat ?? 0.0, story.lon ?? 0.0),
            infoWindow: InfoWindow(
              title: story.name,
              snippet: story.description,
            ),
            onTap: () async {
              mapController.animateCamera(
                CameraUpdate.newLatLngZoom(
                    LatLng(story.lat ?? 0.0, story.lon ?? 0.0), 18),
              );
              try {
                final info =
                    await geo.placemarkFromCoordinates(story.lat!, story.lon!);

                if (info.isNotEmpty) {
                  setState(() {
                    placemark = info.first;
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
            },
          ),
        )
        .toSet();
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  Widget _buildGoogleMap() {
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, child) {
        final state = storyProvider.storyState;

        return state.map(
            initial: (_) => const SizedBox.shrink(),
            loading: (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
            loaded: (_) => Center(
                  child: Stack(
                    children: [
                      GoogleMap(
                        onTap: (argument) {
                          setState(
                            () {
                              placemark = null;
                            },
                          );
                        },
                        markers: markers,
                        initialCameraPosition:
                            CameraPosition(target: initialLocation, zoom: 18),
                        onMapCreated: (controller) {
                          setState(() {
                            mapController = controller;
                          });

                          final bound = boundsFromLatLngList([
                            initialLocation,
                            ...storyProvider.stories.map((story) =>
                                LatLng(story.lat ?? 0.0, story.lon ?? 0.0))
                          ]);
                          mapController.animateCamera(
                            CameraUpdate.newLatLngBounds(bound, 50),
                          );
                        },
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
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
                      if (placemark != null)
                        CardLocation(placemark: placemark)
                    ],
                  ),
                ),
            error: (error) => Center(
                  child: Text(error.message),
                ));
      },
    );
  }
}
