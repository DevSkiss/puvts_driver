import 'package:json_annotation/json_annotation.dart';
import 'package:puvts_driver/features/maps/data/model/location_dto.dart';

part 'location_base_dto.g.dart';

@JsonSerializable()
class LocationBaseDto {
  LocationBaseDto(this.listLocation);

  factory LocationBaseDto.fromJson(Map<String, dynamic> json) =>
      _$LocationBaseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationBaseDtoToJson(this);

  @JsonKey(name: 'listLocation')
  final List<LocationDto> listLocation;
}
