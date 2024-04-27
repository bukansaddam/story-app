import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ButtonZoom extends StatelessWidget {
  const ButtonZoom({
    super.key,
    required this.mapController,
  });

  final GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
