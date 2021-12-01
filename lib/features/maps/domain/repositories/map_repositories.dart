import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/data/model/directions.dart';
import 'package:puvts_driver/core/domain/repository/direction_repository.dart';
import 'package:puvts_driver/core/errors_exception/exceptions.dart';
import 'package:puvts_driver/features/maps/data/model/location_base_dto.dart';
import 'package:puvts_driver/features/maps/data/model/location_dto.dart';
import 'package:puvts_driver/features/maps/data/services/map_api_service.dart';

abstract class MapRepository {
  Future<List<LocationDto>> getPassengerLocation();
  Future<Directions> getDirection(
      {required LatLng origin, required LatLng destination});

  Future<LocationDto> updateLocation(
      {required String lat, required String lng, required String userId});
}

class MapRepostioryImpl implements MapRepository {
  final MapApiService _mapApiService = locator<MapApiService>();
  final DirectionsRepository _directionApiService =
      locator<DirectionsRepository>();

  @override
  Future<List<LocationDto>> getPassengerLocation() async {
    LocationBaseDto drivers = await _mapApiService.getDriverLocation();
    if (drivers.listLocation.isNotEmpty) {
      return drivers.listLocation;
    } else if (drivers.listLocation.isEmpty) {
      throw PassengerNotFoundException();
    } else {
      throw ServerException();
    }
  }

  Future<Directions> getDirection(
      {required LatLng origin, required LatLng destination}) async {
    return await _directionApiService.getDirection(
        origin: origin, destination: destination);
  }

  @override
  Future<LocationDto> updateLocation({
    required String lat,
    required String lng,
    required String userId,
  }) async {
    return await _mapApiService.updateLocation(
        lat: lat, lng: lng, userId: userId);
  }
}
