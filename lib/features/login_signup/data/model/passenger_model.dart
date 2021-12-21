import 'package:json_annotation/json_annotation.dart';

part 'passenger_model.g.dart';

@JsonSerializable()
class PassengerModel {
  PassengerModel(
    this.firstname,
    this.lastname,
    this.email,
    this.id,
    this.userType,
  );

  factory PassengerModel.fromJson(Map<String, dynamic> json) =>
      _$PassengerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PassengerModelToJson(this);

  @JsonKey(name: 'firstname')
  final String? firstname;

  @JsonKey(name: 'lastname')
  final String? lastname;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'user_id')
  final String id;

  @JsonKey(name: 'user_type')
  final String userType;
}
