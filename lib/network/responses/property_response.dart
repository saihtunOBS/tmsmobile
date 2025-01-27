import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/room_shop_vo.dart';

part 'property_response.g.dart';

@JsonSerializable()
class PropertyResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "messaage")
  final String? message;

  @JsonKey(name: "data")
  final List<RoomShopVO>? data;

  PropertyResponse({this.status, this.message, this.data});

  factory PropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyResponseToJson(this);
}
