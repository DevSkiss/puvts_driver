import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:puvts_driver/core/data/model/directions.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  factory MapState({
    @Default(false) isLoading,
    @Default(false) hasError,
    @Default(false) isSuccess,
    @Default(false) noDriverFound,
    Marker? driverPosition,
    Marker? myPosition,
    Set<Marker>? markers,
    Directions? info,
  }) = _MapState;
}
