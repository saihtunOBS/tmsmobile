import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/emergency_vo.dart';

part 'emergency_response.g.dart';

@JsonSerializable()
class EmergencyResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<EmergencyVO>? data;

  EmergencyResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory EmergencyResponse.fromJson(Map<String, dynamic> json) =>
      _$EmergencyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyResponseToJson(this);
}
