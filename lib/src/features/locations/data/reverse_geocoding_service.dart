import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/config/app_config.dart';
import '../domain/coordinates.dart';

class ReverseGeocodingException implements Exception {
  const ReverseGeocodingException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ReverseGeocodingService {
  ReverseGeocodingService({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  Future<String?> resolveAddress(Coordinates coordinates) async {
    if (!AppConfig.hasMapboxToken) {
      throw const ReverseGeocodingException(
        'Mapbox access token is not configured.',
      );
    }

    final uri =
        Uri.parse(
          '${AppConfig.mapboxGeocodingBaseUrl}/'
          '${coordinates.longitude},${coordinates.latitude}.json',
        ).replace(
          queryParameters: {
            'access_token': AppConfig.mapboxAccessToken,
            'limit': '1',
          },
        );

    final response = await _client.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ReverseGeocodingException(
        'Address request failed: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final features = json['features'] as List<dynamic>?;
    if (features == null || features.isEmpty) {
      return null;
    }

    final feature = features.first as Map<String, dynamic>;
    final placeName = feature['place_name'] as String?;
    if (placeName != null && placeName.trim().isNotEmpty) {
      return placeName.trim();
    }

    final text = feature['text'] as String?;
    if (text != null && text.trim().isNotEmpty) {
      return text.trim();
    }
    return null;
  }
}
