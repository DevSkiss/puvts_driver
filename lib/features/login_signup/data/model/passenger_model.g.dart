// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassengerModel _$PassengerModelFromJson(Map<String, dynamic> json) {
  return PassengerModel(
    json['firstname'] as String?,
    json['lastname'] as String?,
    json['email'] as String?,
    json['user_id'] as String,
    json['user_type'] as String,
  );
}

Map<String, dynamic> _$PassengerModelToJson(PassengerModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'user_id': instance.id,
      'user_type': instance.userType,
    };
