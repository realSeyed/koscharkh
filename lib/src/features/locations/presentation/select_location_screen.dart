import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/map/kos_map.dart';
import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/components.dart';
import '../application/location_picker_cubit.dart';
import '../domain/coordinates.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  late final MapController _mapController;
  late final Coordinates _initialCenter;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initialCenter = context.read<LocationPickerCubit>().state.coordinates;
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationPickerCubit, LocationPickerState>(
      listenWhen: (previous, current) =>
          previous.cameraMoveId != current.cameraMoveId &&
          current.cameraTarget != null,
      listener: (context, state) {
        _mapController.move(state.cameraTarget!.toLatLng(), 15);
      },
      child: Scaffold(
        backgroundColor: context.colors.surface,
        body: BlocBuilder<LocationPickerCubit, LocationPickerState>(
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: [
                _CenterPickerMap(
                  controller: _mapController,
                  initialCenter: _initialCenter,
                ),
                const _FixedCenterMarker(),
                _BottomLocationOverlay(state: state),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CenterPickerMap extends StatelessWidget {
  const _CenterPickerMap({
    required this.controller,
    required this.initialCenter,
  });

  final MapController controller;
  final Coordinates initialCenter;

  @override
  Widget build(BuildContext context) {
    final tileUrl = AppConfig.effectiveTileUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomPaint(painter: DarkMapBackdropPainter()),
        FlutterMap(
          mapController: controller,
          options: MapOptions(
            initialCenter: initialCenter.toLatLng(),
            initialZoom: 15,
            backgroundColor: context.colors.surface,
            onPositionChanged: (camera, hasGesture) {
              context.read<LocationPickerCubit>().centerChanged(
                Coordinates(
                  latitude: camera.center.latitude,
                  longitude: camera.center.longitude,
                ),
              );
            },
          ),
          children: [
            if (tileUrl.isNotEmpty)
              TileLayer(
                urlTemplate: tileUrl,
                userAgentPackageName: 'com.example.koscharkh',
              ),
          ],
        ),
      ],
    );
  }
}

class _FixedCenterMarker extends StatelessWidget {
  const _FixedCenterMarker();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, -CenterLocationMarker.height / 2),
          child: const CenterLocationMarker(),
        ),
      ),
    );
  }
}

class _BottomLocationOverlay extends StatelessWidget {
  const _BottomLocationOverlay({required this.state});

  final LocationPickerState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24, bottom: 24),
            child: _CurrentLocationButton(state: state),
          ),
          _LocationDetailsBox(state: state),
        ],
      ),
    );
  }
}

class _CurrentLocationButton extends StatelessWidget {
  const _CurrentLocationButton({required this.state});

  final LocationPickerState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 51,
      height: 51,
      child: Material(
        color: state.isLocating
            ? context.colors.disabled
            : context.colors.primary,
        child: InkWell(
          onTap: state.isLocating
              ? null
              : context.read<LocationPickerCubit>().useCurrentLocation,
          child: Center(
            child: state.isLocating
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.colors.onDisabled,
                    ),
                  )
                : KosSvgIcon(
                    KosAssets.myLocation,
                    color: context.colors.onPrimary,
                  ),
          ),
        ),
      ),
    );
  }
}

class _LocationDetailsBox extends StatelessWidget {
  const _LocationDetailsBox({required this.state});

  final LocationPickerState state;

  @override
  Widget build(BuildContext context) {
    final statusMessage = state.currentLocationMessage ?? state.addressMessage;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Container(
      width: double.infinity,
      color: context.colors.surface,
      padding: EdgeInsets.fromLTRB(24, 16, 24, 18 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _addressText(state),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: state.addressStatus == AddressStatus.failure
                  ? context.colors.onSurfaceMuted
                  : context.colors.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            'Coordinates: ${state.coordinates.latitude.toStringAsFixed(12)}, ${state.coordinates.longitude.toStringAsFixed(8)}',
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (statusMessage != null && statusMessage.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              statusMessage,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: context.colors.error),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 12),
          KosButton(
            text: 'Select',
            onPressed: () => context.pop(state.selection),
          ),
        ],
      ),
    );
  }
}

String _addressText(LocationPickerState state) {
  return switch (state.addressStatus) {
    AddressStatus.loading => 'Resolving address...',
    AddressStatus.resolved => state.address ?? 'Selected location',
    AddressStatus.failure => 'Address unavailable',
    AddressStatus.idle => state.address ?? 'Selected location',
  };
}
