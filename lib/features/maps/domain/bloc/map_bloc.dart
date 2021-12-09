import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/services/cached_services.dart';
import 'package:puvts_driver/features/maps/data/model/location_dto.dart';
import 'package:puvts_driver/features/maps/domain/bloc/map_state.dart';
import 'package:puvts_driver/features/maps/domain/repositories/map_repositories.dart';

class MapBloc extends Cubit<MapState> {
  MapBloc() : super(MapState()) {
    initialize();
  }
  final MapRepository _mapRepository = locator<MapRepository>();
  final CachedService _cachedService = locator<CachedService>();

  void initialize() async {
    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      noDriverFound: false,
      isSuccess: false,
    ));
    // get my location and save it as marker
    locationPermission();
  }

  void resetState() {
    emit(state.copyWith(
      isLoading: false,
      hasError: false,
      noDriverFound: false,
      isSuccess: false,
      driverPosition: null,
      info: null,
    ));
  }

  LatLng defaultLatLong = LatLng(11.242034, 124.999902);

  Future<void> getPassengerLocation() async {
    log("Get Passenger Location");
    emit(state.copyWith(isLoading: true));

    Set<Marker> markers = {};

    List<LocationDto> passenger = await _mapRepository.getPassengerLocation();
    log(passenger[0].createdAt);
    for (int i = 0; i < passenger.length; i++) {
      log(passenger[i].longitude);
      markers.add(
        Marker(
          markerId: MarkerId('${passenger[i].id}Position'),
          infoWindow: InfoWindow(title: '${passenger[i].userType}'),
          position: LatLng(
            double.parse(passenger[i].latitude),
            double.parse(passenger[i].longitude),
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
    emit(
      state.copyWith(
        isLoading: false,
        markers: markers,
      ),
    );
  }

  // void getDirectionDriver() async {
  //   await getDriverLocation();

  //   Directions newDirection = await _mapRepository.getDirection(
  //     origin: state.myPosition?.position ?? defaultLatLong,
  //     destination: state.driverPosition?.position ?? defaultLatLong,
  //   );

  //   emit(state.copyWith(info: newDirection));
  // }

  void locationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      log('${currentLocation.latitude}');
      emit(
        state.copyWith(
          isLoading: false,
          myPosition: Marker(
            markerId: MarkerId('myposition'),
            position: LatLng(
              currentLocation.latitude ?? 0,
              currentLocation.longitude ?? 0,
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        ),
      );
    });

    //_locationData = await location.getLocation();
  }

  void activateMyLocation() async {
    final passenger = await _cachedService.getUser();
    await _mapRepository.updateLocation(
      lat: state.myPosition?.position.latitude.toString() ?? '',
      lng: state.myPosition?.position.longitude.toString() ?? '',
      userId: passenger.id,
    );
  }
}
