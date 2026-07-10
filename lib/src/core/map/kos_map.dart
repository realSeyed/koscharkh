import 'dart:math';
import 'dart:ui' as ui;

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
    this.userLocation,
    this.activeDestinationIndex,
    this.mapController,
    this.initialZoom,
    this.minZoom,
    this.maxZoom,
    this.enableRotation = false,
    this.showUserMarker = false,
    this.interactive = true,
    this.onPositionChanged,
    this.onMapEvent,
    this.onMapReady,
    this.onTap,
    this.onRecenter,
  });

  final List<LatLng> points;
  final List<DestinationDraft> destinations;
  final LocationSelection? selectedLocation;
  final Coordinates? userLocation;
  final int? activeDestinationIndex;
  final MapController? mapController;
  final double? initialZoom;
  final double? minZoom;
  final double? maxZoom;
  final bool enableRotation;
  final bool showUserMarker;
  final bool interactive;
  final PositionCallback? onPositionChanged;
  final MapEventCallback? onMapEvent;
  final VoidCallback? onMapReady;
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
      if (userLocation != null) userLocation!.toLatLng(),
    ];
    final center = _center(allPoints);
    final tileUrl = AppConfig.effectiveTileUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomPaint(painter: DarkMapBackdropPainter()),
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: center,
            initialZoom: initialZoom ?? (allPoints.length > 1 ? 15 : 13),
            minZoom: minZoom,
            maxZoom: maxZoom,
            interactionOptions: InteractionOptions(
              flags: interactive ? InteractiveFlag.all : InteractiveFlag.none,
              enableMultiFingerGestureRace: interactive && enableRotation,
              rotationThreshold: 8,
            ),
            onTap: onTap == null
                ? null
                : (_, point) => onTap!(
                    Coordinates(
                      latitude: point.latitude,
                      longitude: point.longitude,
                    ),
                  ),
            onPositionChanged: onPositionChanged,
            onMapEvent: onMapEvent,
            onMapReady: onMapReady,
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
            MarkerLayer(
              markers: _destinationAndSelectionMarkers(context),
              rotate: true,
            ),
            if (userLocation != null)
              AnimatedUserLocationMarkerLayer(location: userLocation!),
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

  List<Marker> _destinationAndSelectionMarkers(BuildContext context) {
    final markers = <Marker>[];
    for (var i = 0; i < destinations.length; i++) {
      final coordinate = destinations[i].coordinates;
      if (coordinate == null) {
        continue;
      }
      final isActive =
          activeDestinationIndex != null && i == activeDestinationIndex;
      final isReached =
          activeDestinationIndex != null && i < activeDestinationIndex!;
      final size = KosMapMarker.sizeFor(isActive: isActive, enable: true);
      markers.add(
        Marker(
          point: coordinate.toLatLng(),
          width: size,
          height: size,
          child: NumberMarker(
            number: i + 1,
            isActive: isActive,
            isReached: isReached,
          ),
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
    if (showUserMarker && userLocation == null) {
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

class KosMapMarker extends StatelessWidget {
  const KosMapMarker({
    super.key,
    required this.isActive,
    required this.enable,
    this.icon,
    this.iconAsset,
    this.text,
  }) : assert(
         (text == null ? 0 : 1) +
                 (icon == null ? 0 : 1) +
                 (iconAsset == null ? 0 : 1) ==
             1,
         'Exactly one of text, icon, or iconAsset must be provided.',
       );

  final bool isActive;
  final bool enable;
  final IconData? icon;
  final Widget? iconAsset;
  final String? text;

  static double sizeFor({required bool isActive, required bool enable}) {
    return enable && isActive ? 32 : 24;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveActive = enable && isActive;
    final size = sizeFor(isActive: isActive, enable: enable);
    final textSize = effectiveActive ? 18.0 : 14.0;
    final background = enable
        ? context.colors.green900
        : context.colors.primary;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.onSurface, width: 2),
      ),
      alignment: Alignment.center,
      child: text != null
          ? Text(
              text!,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: context.colors.onSurface,
                fontSize: textSize,
                height: 1,
              ),
            )
          : iconAsset != null
          ? SizedBox(width: 18, height: 18, child: FittedBox(child: iconAsset))
          : Icon(icon, color: context.colors.onSurface, size: 18),
    );
  }
}

class NumberMarker extends StatelessWidget {
  const NumberMarker({
    super.key,
    required this.number,
    this.isActive = false,
    this.isReached = false,
    this.enable = true,
  });

  final int number;
  final bool isActive;
  final bool isReached;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    if (isReached) {
      return Opacity(
        opacity: 0.62,
        child: KosMapMarker(isActive: false, enable: enable, icon: Icons.check),
      );
    }
    return KosMapMarker(isActive: isActive, enable: enable, text: '$number');
  }
}

class UserMarker extends StatelessWidget {
  const UserMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return KosMapMarker(
      isActive: true,
      enable: true,
      iconAsset: KosSvgIcon(
        KosAssets.emojiPeople,
        size: 18,
        color: context.colors.onSurface,
      ),
    );
  }
}

class AnimatedUserLocationMarkerLayer extends StatefulWidget {
  const AnimatedUserLocationMarkerLayer({super.key, required this.location});

  final Coordinates location;

  @override
  State<AnimatedUserLocationMarkerLayer> createState() =>
      _AnimatedUserLocationMarkerLayerState();
}

class _AnimatedUserLocationMarkerLayerState
    extends State<AnimatedUserLocationMarkerLayer> {
  late LatLng _begin;

  @override
  void initState() {
    super.initState();
    _begin = widget.location.toLatLng();
  }

  @override
  void didUpdateWidget(covariant AnimatedUserLocationMarkerLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      _begin = oldWidget.location.toLatLng();
    }
  }

  @override
  Widget build(BuildContext context) {
    final end = widget.location.toLatLng();
    return TweenAnimationBuilder<LatLng>(
      tween: _LatLngTween(begin: _begin, end: end),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (context, point, child) {
        return MarkerLayer(
          rotate: true,
          markers: [Marker(point: point, width: 32, height: 32, child: child!)],
        );
      },
      child: const UserMarker(),
    );
  }
}

class _LatLngTween extends Tween<LatLng> {
  _LatLngTween({required super.begin, required super.end});

  @override
  LatLng lerp(double t) {
    final start = begin!;
    final finish = end!;
    return LatLng(
      start.latitude + (finish.latitude - start.latitude) * t,
      start.longitude + (finish.longitude - start.longitude) * t,
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

class CenterLocationMarker extends StatelessWidget {
  const CenterLocationMarker({super.key});

  static const double width = 48;
  static const double height = 58;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _CenterLocationMarkerPainter(
          fill: context.colors.primary,
          stroke: context.colors.onSurface,
          shadow: context.colors.scrim,
        ),
      ),
    );
  }
}

class _CenterLocationMarkerPainter extends CustomPainter {
  const _CenterLocationMarkerPainter({
    required this.fill,
    required this.stroke,
    required this.shadow,
  });

  final Color fill;
  final Color stroke;
  final Color shadow;

  @override
  void paint(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = shadow.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(Offset(size.width / 2, size.height - 4), 8, shadowPaint);

    final path = ui.Path()
      ..moveTo(size.width / 2, size.height)
      ..cubicTo(
        size.width * 0.2,
        size.height * 0.62,
        4,
        size.height * 0.5,
        4,
        24,
      )
      ..cubicTo(4, 10, 14, 2, size.width / 2, 2)
      ..cubicTo(size.width - 14, 2, size.width - 4, 10, size.width - 4, 24)
      ..cubicTo(
        size.width - 4,
        size.height * 0.5,
        size.width * 0.8,
        size.height * 0.62,
        size.width / 2,
        size.height,
      )
      ..close();

    canvas
      ..drawPath(
        path,
        Paint()
          ..color = fill
          ..style = PaintingStyle.fill,
      )
      ..drawPath(
        path,
        Paint()
          ..color = stroke
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      )
      ..drawCircle(
        Offset(size.width / 2, 24),
        8,
        Paint()
          ..color = stroke
          ..style = PaintingStyle.fill,
      );
  }

  @override
  bool shouldRepaint(covariant _CenterLocationMarkerPainter oldDelegate) {
    return fill != oldDelegate.fill ||
        stroke != oldDelegate.stroke ||
        shadow != oldDelegate.shadow;
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
