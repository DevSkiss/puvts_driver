import 'dart:convert';

import 'package:puvts_driver/core/errors_exception/exceptions.dart';
import 'package:puvts_driver/features/maps/data/model/location_base_dto.dart';
import 'package:http/http.dart' as http;
import 'package:puvts_driver/core/constants/http.dart';
import 'package:puvts_driver/features/maps/data/model/location_dto.dart';

abstract class MapApiService {
  Future<LocationBaseDto> getDriverLocation();
  Future<LocationDto> updateLocation(
      {required String lat, required String lng, required String userId});
}

class MapApiServiceImpl implements MapApiService {
  var client = http.Client();

  @override
  Future<LocationBaseDto> getDriverLocation() async {
    String requestBody = jsonEncode(<String, dynamic>{
      'user_type': 'passenger',
    });
    String result = await _postUserToUrl(
      Uri.parse(BASE_URL + '/api/location/user-type'),
      body: requestBody,
    );
    return LocationBaseDto.fromJson(json.decode(result));
  }

  @override
  Future<LocationDto> updateLocation(
      {required String lat,
      required String lng,
      required String userId}) async {
    String requestBody = jsonEncode(<String, dynamic>{
      'latitude': lat,
      'longitude': lng,
      'userId': userId,
      'isActive': true,
    });

    String result = await _putToUrl(
      Uri.parse(BASE_URL + '/api/location'),
      body: requestBody,
    );
    return LocationDto.fromJson(json.decode(result));
  }

  Future<String> _postUserToUrl(Uri url, {Object? body}) async {
    final response = await client.post(
      url,
      headers: {
        HTTP_CONTENT_TYPE: HTTP_APPLICATION_JSON,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }

  Future<String> _putToUrl(Uri url, {Object? body}) async {
    final response = await client.put(
      url,
      headers: {
        HTTP_CONTENT_TYPE: HTTP_APPLICATION_JSON,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }
}
