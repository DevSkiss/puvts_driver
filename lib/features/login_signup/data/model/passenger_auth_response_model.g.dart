// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger_auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassengerAuthResponseModel _$PassengerAuthResponseModelFromJson(
    Map<String, dynamic> json) {
  return PassengerAuthResponseModel(
    json['access'] as String,
    json['user'] == null
        ? null
        : DriverModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PassengerAuthResponseModelToJson(
        PassengerAuthResponseModel instance) =>
    <String, dynamic>{
      'access': instance.access,
      'user': instance.passenger,
    };
