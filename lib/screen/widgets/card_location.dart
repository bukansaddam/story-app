import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;

class CardLocation extends StatelessWidget {
  const CardLocation({
    super.key,
    required this.placemark,
  });

  final geo.Placemark? placemark;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 700),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 20,
              offset: Offset.zero,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(placemark?.street ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                      '${placemark?.subLocality}, ${placemark?.locality}, ${placemark?.postalCode}, ${placemark?.country}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
