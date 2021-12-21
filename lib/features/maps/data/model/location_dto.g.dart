// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) {
  return LocationDto(
    json['active'] as bool,
    json['user_type'] as String,
    json['firstname'] as String,
    json['lastname'] as String,
    json['user_id'] as String,
    json['latitude'] as String,
    json['longitude'] as String,
  );
}

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'active': instance.isActive,
      'firstname': instance.firstname,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'lastname': instance.lastname,
      'user_id': instance.userId,
      'user_type': instance.userType,
    };
