import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/local/auth_repository.dart';
import 'package:story_app/data/responses/detail_story_response.dart';
import 'package:story_app/provider/detail_provider.dart';
import 'package:story_app/screen/widgets/card_location.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late GoogleMapController mapController;

  geo.Placemark? placemark;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailProvider(
        apiService: ApiService(),
        authRepository: AuthRepository(),
        id: widget.id,
      ),
      child: Consumer<DetailProvider>(
        builder: (context, detailProvider, child) {
          final state = detailProvider.detailState;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Detail'),
            ),
            body: state.map(
              initial: (_) => const SizedBox
                  .shrink(), // Tidak melakukan apa-apa saat initial state
              loading: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (value) {
                final detailStory = detailProvider.detailResponse;
                return _buildDetail(detailStory, context);
              }, // Tampilkan detail saat data telah dimuat
              error: (value) => Center(
                child: Text(
                  value.message,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetail(DetailResponse data, BuildContext context) {
    bool isNull = data.story.lat == null && data.story.lon == null;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.network(data.story.photoUrl,
                fit: BoxFit.cover, width: double.infinity, height: 300),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.story.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(data.story.description),
                const SizedBox(height: 16),
                isNull
                    ? const SizedBox.shrink()
                    : SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: _buildGoogleMap(data),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleMap(DetailResponse data) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(data.story.lat ?? 0, data.story.lon ?? 0),
            zoom: 10,
          ),
          markers: <Marker>{
            Marker(
              markerId: MarkerId(data.story.id.toString()),
              position: LatLng(data.story.lat ?? 0, data.story.lon ?? 0),
              onTap: () async {
                try {
                  final info = await geo.placemarkFromCoordinates(
                      data.story.lat!, data.story.lon!);

                  if (info.isNotEmpty) {
                    setState(() {
                      placemark = info.first;
                      mapController.animateCamera(
                        CameraUpdate.newLatLngZoom(
                            LatLng(data.story.lat!, data.story.lon!), 16),
                      );
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
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onTap: (argument) {
            setState(() {
              placemark = null;
            });
          },
        ),
        Positioned(
          top: 4,
          right: 4,
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
        placemark != null
            ? CardLocation(placemark: placemark)
            : const SizedBox.shrink(),
      ],
    );
  }
}
