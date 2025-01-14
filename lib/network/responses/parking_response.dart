import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';

part 'parking_response.g.dart';

@JsonSerializable()
class ParkingResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<PropertyInformation>? data;

  ParkingResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ParkingResponse.fromJson(Map<String, dynamic> json) =>
      _$ParkingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingResponseToJson(this);
}
