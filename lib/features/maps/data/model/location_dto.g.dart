// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) {
  return LocationDto(
    json['is_active'] as bool,
    json['createdAt'] as String,
    json['_id'] as String,
    json['longitude'] as String,
    json['latitude'] as String,
    json['userId'] as String,
    json['user_type'] as String,
  );
}

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'is_active': instance.isActive,
      'createdAt': instance.createdAt,
      '_id': instance.id,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'userId': instance.userId,
      'user_type': instance.userType,
    };
