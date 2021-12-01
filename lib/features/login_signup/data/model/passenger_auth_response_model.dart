import 'package:json_annotation/json_annotation.dart';
import 'package:puvts_driver/features/login_signup/domain/driver_model.dart';

part 'passenger_auth_response_model.g.dart';

@JsonSerializable()
class PassengerAuthResponseModel {
  PassengerAuthResponseModel(this.access, this.passenger);

  factory PassengerAuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PassengerAuthResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$PassengerAuthResponseModelToJson(this);

  @JsonKey(name: 'access')
  final String access;

  @JsonKey(name: 'user')
  final DriverModel? passenger;
}
