import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:puvts_driver/app/locator_injection.dart';
import 'package:puvts_driver/core/services/cached_services.dart';
import 'package:puvts_driver/features/login_signup/data/model/passenger_model.dart';
import 'package:puvts_driver/features/login_signup/data/service/auth_service_api.dart';
import 'package:puvts_driver/features/maps/data/model/location_dto.dart';
import 'package:puvts_driver/features/maps/domain/bloc/map_state.dart';
import 'package:puvts_driver/features/maps/domain/repositories/map_repositories.dart';

class MapBloc extends Cubit<MapState> {
  MapBloc() : super(MapState()) {
    initialize();
  }
  final MapRepository _mapRepository = locator<MapRepository>();
  final CachedService _cachedService = locator<CachedService>();
  final AuthApiService _authApiService = locator<AuthApiService>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Location location = Location();
  Logger _logger = Logger();

  void initialize() async {
    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      noDriverFound: false,
      isSuccess: false,
    ));
    // get my location and save it as marker
    checkUserAndPermission();
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

  void logout() async {
    await _authApiService.logout();
  }

  void updateMyLocation(
      {required double longitude, required double latitude}) async {
    try {
      CollectionReference location =
          FirebaseFirestore.instance.collection('location');
      PassengerModel passenger = await _cachedService.getUser();

      var result = await firestore
          .collection('location')
          .where('user_id', isEqualTo: passenger.id)
          .where('user_type', isEqualTo: 'driver')
          .get();

      location
          .doc(result.docs[0].id)
          .update({
            'longitude': longitude.toString(),
            'latitude': latitude.toString(),
          })
          .then((value) => print("Location Updated"))
          .catchError((error) => print("Failed to update location: $error"));
    } catch (e) {
      _logger.e(e);
      throw UnimplementedError();
    }
  }

  void updateSeatAvailablility({required int seatAvailable}) async {
    try {
      CollectionReference location =
          FirebaseFirestore.instance.collection('location');
      PassengerModel passenger = await _cachedService.getUser();

      var result = await firestore
          .collection('location')
          .where('user_id', isEqualTo: passenger.id)
          .where('user_type', isEqualTo: 'driver')
          .get();

      location
          .doc(result.docs[0].id)
          .update({
            'seat_available': seatAvailable,
          })
          .then((value) => print("Update Seat Availability"))
          .catchError((error) => print("Failed to update location: $error"));
    } catch (e) {
      _logger.e(e);
      throw UnimplementedError();
    }
  }

  Future<void> getPassengerLocation() async {
    log("Get Passenger Location");
    emit(state.copyWith(isLoading: true));

    Set<Marker> markers = {};

    try {
      emit(state.copyWith(isLoading: true));

      var result = await firestore
          .collection('location')
          .where('user_type', isEqualTo: 'passenger')
          .where('active', isEqualTo: true)
          .get();

      // LocationDto driverLocation =
      //     LocationDto.fromJson(result.docs[0].data());

      print(result);

      for (int i = 0; i < result.docs.length; i++) {
        LocationDto _passengerLocation =
            LocationDto.fromJson(result.docs[i].data());

        log("${_passengerLocation.latitude} , ${_passengerLocation.longitude}");
        if (_passengerLocation.latitude != '' &&
            _passengerLocation.longitude != '') {
          markers.add(
            Marker(
              markerId: MarkerId('${_passengerLocation.userId}Position'),
              infoWindow: InfoWindow(title: 'Passenger'),
              position: LatLng(
                double.parse(_passengerLocation.latitude),
                double.parse(_passengerLocation.longitude),
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          );
        }
      }
      emit(
        state.copyWith(
          isLoading: false,
          markers: markers,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      throw UnimplementedError();
    }
  }

  void checkUserAndPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

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

    emit(state.copyWith(isLoading: false));
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
