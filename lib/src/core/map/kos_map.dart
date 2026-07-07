import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../features/destinations/domain/destination.dart';
import '../../features/locations/domain/coordinates.dart';
import '../../features/locations/domain/location_selection.dart';
import '../config/app_config.dart';
import '../theme/koscharkh_theme.dart';
import '../widgets/components.dart';

class KosMap extends StatelessWidget {
  const KosMap({
    super.key,
    required this.points,
    this.destinations = const [],
    this.selectedLocation,
    this.showUserMarker = false,
    this.interactive = true,
    this.onTap,
    this.onRecenter,
  });

  final List<LatLng> points;
  final List<DestinationDraft> destinations;
  final LocationSelection? selectedLocation;
  final bool showUserMarker;
  final bool interactive;
  final ValueChanged<Coordinates>? onTap;
  final VoidCallback? onRecenter;

  @override
  Widget build(BuildContext context) {
    final allPoints = <LatLng>[
      ...points,
      for (final destination in destinations)
        if (destination.coordinates != null)
          destination.coordinates!.toLatLng(),
      if (selectedLocation != null) selectedLocation!.coordinates.toLatLng(),
    ];
    final center = _center(allPoints);
    final tileUrl = AppConfig.effectiveTileUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomPaint(painter: DarkMapBackdropPainter()),
        FlutterMap(
          options: MapOptions(
            initialCenter: center,
            initialZoom: allPoints.length > 1 ? 15 : 13,
            interactionOptions: InteractionOptions(
              flags: interactive ? InteractiveFlag.all : InteractiveFlag.none,
            ),
            onTap: onTap == null
                ? null
                : (_, point) => onTap!(
                    Coordinates(
                      latitude: point.latitude,
                      longitude: point.longitude,
                    ),
                  ),
          ),
          children: [
            if (tileUrl.isNotEmpty)
              TileLayer(
                urlTemplate: tileUrl,
                userAgentPackageName: 'com.example.koscharkh',
              ),
            if (points.length > 1)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    color: context.colors.green500.withValues(alpha: 0.92),
                    strokeWidth: 7,
                  ),
                ],
              ),
            MarkerLayer(markers: _markers(context)),
          ],
        ),
        if (onRecenter != null)
          Positioned(
            right: 24,
            bottom: 160,
            child: IconSquareButton(
              asset: KosAssets.myLocation,
              onPressed: onRecenter,
              iconColor: context.colors.onPrimary,
            ),
          ),
      ],
    );
  }

  List<Marker> _markers(BuildContext context) {
    final markers = <Marker>[];
    for (var i = 0; i < destinations.length; i++) {
      final coordinate = destinations[i].coordinates;
      if (coordinate == null) {
        continue;
      }
      markers.add(
        Marker(
          point: coordinate.toLatLng(),
          width: 34,
          height: 34,
          child: NumberMarker(number: i + 1),
        ),
      );
    }
    if (selectedLocation != null) {
      markers.add(
        Marker(
          point: selectedLocation!.coordinates.toLatLng(),
          width: 42,
          height: 42,
          child: const SelectedLocationMarker(),
        ),
      );
    }
    if (showUserMarker) {
      final userPoint = _userPoint(points, selectedLocation);
      markers.add(
        Marker(
          point: userPoint,
          width: 44,
          height: 44,
          child: const UserMarker(),
        ),
      );
    }
    return markers;
  }
}

class NumberMarker extends StatelessWidget {
  const NumberMarker({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.onSurface, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        '$number',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: context.colors.onSurface,
          fontSize: 15,
        ),
      ),
    );
  }
}

class UserMarker extends StatelessWidget {
  const UserMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.onSurface, width: 2),
      ),
      alignment: Alignment.center,
      child: KosSvgIcon(KosAssets.emojiPeople, color: context.colors.onSurface),
    );
  }
}

class SelectedLocationMarker extends StatelessWidget {
  const SelectedLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return KosSvgIcon(
      KosAssets.locationOn,
      size: 42,
      color: context.colors.primary,
    );
  }
}

class DarkMapBackdropPainter extends CustomPainter {
  const DarkMapBackdropPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFF101318);
    canvas.drawRect(Offset.zero & size, background);

    final major = Paint()
      ..color = const Color(0xFF2A3038)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final minor = Paint()
      ..color = const Color(0xFF20262E)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (var x = -size.width; x < size.width * 1.7; x += 82) {
      canvas.drawLine(
        Offset(x.toDouble(), size.height),
        Offset(x + size.height, 0),
        major,
      );
    }
    for (var x = -size.width; x < size.width * 1.8; x += 44) {
      canvas.drawLine(
        Offset(x.toDouble(), size.height),
        Offset(x + size.height, 0),
        minor,
      );
    }
    for (var y = -size.height; y < size.height * 1.8; y += 78) {
      canvas.drawLine(
        Offset(0, y.toDouble()),
        Offset(size.width, y + size.width),
        minor,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

LatLng _center(List<LatLng> points) {
  if (points.isEmpty) {
    return const LatLng(40.728, -73.998);
  }
  var minLat = points.first.latitude;
  var maxLat = points.first.latitude;
  var minLng = points.first.longitude;
  var maxLng = points.first.longitude;
  for (final point in points) {
    minLat = min(minLat, point.latitude);
    maxLat = max(maxLat, point.latitude);
    minLng = min(minLng, point.longitude);
    maxLng = max(maxLng, point.longitude);
  }
  return LatLng((minLat + maxLat) / 2, (minLng + maxLng) / 2);
}

LatLng _userPoint(List<LatLng> points, LocationSelection? selectedLocation) {
  if (points.length > 1) {
    return points[1];
  }
  if (points.isNotEmpty) {
    return points.first;
  }
  final selected = selectedLocation?.coordinates;
  if (selected != null) {
    return LatLng(selected.latitude - 0.004, selected.longitude);
  }
  return const LatLng(40.727, -73.9995);
}
