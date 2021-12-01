// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_base_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationBaseDto _$LocationBaseDtoFromJson(Map<String, dynamic> json) {
  return LocationBaseDto(
    (json['listLocation'] as List<dynamic>)
        .map((e) => LocationDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LocationBaseDtoToJson(LocationBaseDto instance) =>
    <String, dynamic>{
      'listLocation': instance.listLocation,
    };
