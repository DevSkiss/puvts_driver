import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  LocationDto(
    this.isActive,
    this.userType,
    this.firstname,
    this.lastname,
    this.userId,
    this.latitude,
    this.longitude,
  );

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);

  @JsonKey(name: 'active')
  final bool isActive;

  @JsonKey(name: 'firstname')
  final String firstname;

  @JsonKey(name: 'latitude')
  final String latitude;

  @JsonKey(name: 'longitude')
  final String longitude;

  @JsonKey(name: 'lastname')
  final String lastname;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'user_type')
  final String userType;
}
