class AppConfig {
  const AppConfig._();

  static const mapboxTileUrlTemplate = String.fromEnvironment(
    'MAPBOX_TILE_URL_TEMPLATE',
  );
  static const mapboxAccessToken = String.fromEnvironment(
    'MAPBOX_ACCESS_TOKEN',
  );
  static const mapboxDirectionsBaseUrl = String.fromEnvironment(
    'MAPBOX_DIRECTIONS_BASE_URL',
    defaultValue: 'https://api.mapbox.com/directions/v5/mapbox',
  );
  static const mapboxDirectionsProfile = String.fromEnvironment(
    'MAPBOX_DIRECTIONS_PROFILE',
    defaultValue: 'walking',
  );

  static String get effectiveTileUrl {
    if (mapboxTileUrlTemplate.isEmpty) {
      return '';
    }
    return mapboxTileUrlTemplate
        .replaceAll('{accessToken}', mapboxAccessToken)
        .replaceAll('{token}', mapboxAccessToken);
  }

  static bool get hasDirectionsToken => mapboxAccessToken.isNotEmpty;
}
