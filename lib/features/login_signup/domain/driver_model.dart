import 'package:json_annotation/json_annotation.dart';

part 'driver_model.g.dart';

@JsonSerializable()
class DriverModel {
  DriverModel(
    this.firstname,
    this.lastname,
    this.username,
    this.password,
    this.id,
    this.active,
    this.createdAt,
    this.plateNo,
    this.licenseNo,
    this.mobileNo,
    this.address,
  );

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);
  Map<String, dynamic> toJson() => _$DriverModelToJson(this);

  @JsonKey(name: 'firstname')
  final String? firstname;

  @JsonKey(name: 'lastname')
  final String? lastname;

  @JsonKey(name: 'username')
  final String? username;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'active')
  final bool active;

  @JsonKey(name: 'plate_no')
  final String plateNo;

  @JsonKey(name: 'license_no')
  final String licenseNo;

  @JsonKey(name: 'mobile_no')
  final String mobileNo;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'createdAt')
  final String createdAt;
}
