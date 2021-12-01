// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) {
  return DriverModel(
    json['firstname'] as String?,
    json['lastname'] as String?,
    json['username'] as String?,
    json['password'] as String?,
    json['_id'] as String,
    json['active'] as bool,
    json['createdAt'] as String,
    json['plate_no'] as String,
    json['license_no'] as String,
    json['mobile_no'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$DriverModelToJson(DriverModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'username': instance.username,
      'password': instance.password,
      '_id': instance.id,
      'active': instance.active,
      'plate_no': instance.plateNo,
      'license_no': instance.licenseNo,
      'mobile_no': instance.mobileNo,
      'address': instance.address,
      'createdAt': instance.createdAt,
    };
