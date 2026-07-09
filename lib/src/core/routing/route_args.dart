import '../../features/destinations/domain/destination.dart';
import '../../features/locations/domain/location_selection.dart';

class RoutePreviewArgs {
  const RoutePreviewArgs({
    required this.title,
    required this.destinations,
    required this.timeMinutes,
    this.charkhStableId,
  });

  final String title;
  final List<DestinationDraft> destinations;
  final int timeMinutes;
  final String? charkhStableId;
}

class DestinationFormArgs {
  const DestinationFormArgs({this.draft, this.canSaveToLibrary = false});

  final DestinationDraft? draft;
  final bool canSaveToLibrary;
}

class SelectLocationArgs {
  const SelectLocationArgs({this.initial});

  final LocationSelection? initial;
}
