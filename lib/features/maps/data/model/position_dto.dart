import 'package:json_annotation/json_annotation.dart';

part 'position_dto.g.dart';

@JsonSerializable()
class PositionDto {
  PositionDto(this.longitude, this.latitude);

  factory PositionDto.fromJson(Map<String, dynamic> json) =>
      _$PositionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PositionDtoToJson(this);

  @JsonKey(name: 'longitude')
  final double longitude;

  @JsonKey(name: 'latitude')
  final double latitude;
}
