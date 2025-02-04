import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/maintenance_process_data_vo.dart';

part 'maintenance_process_response.g.dart';

@JsonSerializable()
class MaintenanceProcessResponse {
  @JsonKey(name: "success")
  final bool? success;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<MaintenanceProcessDataVO>? data;

  MaintenanceProcessResponse({this.success, this.message, this.data});

  factory MaintenanceProcessResponse.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceProcessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceProcessResponseToJson(this);
}


