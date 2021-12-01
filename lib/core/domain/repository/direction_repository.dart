import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:puvts_driver/core/constants/http.dart';
import 'package:puvts_driver/core/data/model/directions.dart';

class DirectionsRepository {
  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  static const String _directionUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  Future<Directions> getDirection({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(_directionUrl, queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
      'destination': '${destination.latitude}, ${destination.longitude}',
      'key': googleApiKey,
    });

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    } else {
      throw UnimplementedError();
    }
  }
}
