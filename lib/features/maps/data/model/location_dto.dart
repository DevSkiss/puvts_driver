import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  LocationDto(this.isActive, this.createdAt, this.id, this.longitude,
      this.latitude, this.userId, this.userType);

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'longitude')
  final String longitude;

  @JsonKey(name: 'latitude')
  final String latitude;

  @JsonKey(name: 'userId')
  final String userId;

  @JsonKey(name: 'user_type')
  final String userType;
}
