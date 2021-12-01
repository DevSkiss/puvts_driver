// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionDto _$PositionDtoFromJson(Map<String, dynamic> json) {
  return PositionDto(
    (json['longitude'] as num).toDouble(),
    (json['latitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$PositionDtoToJson(PositionDto instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
