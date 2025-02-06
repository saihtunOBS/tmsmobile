import 'package:json_annotation/json_annotation.dart';

part 'maintenance_status_request.g.dart';

@JsonSerializable()
class MaintenanceStatusRequest {
  @JsonKey(name: "status")
  int? status;

  MaintenanceStatusRequest(
    this.status,
  );

  factory MaintenanceStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceStatusRequestToJson(this);
}
