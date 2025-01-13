import 'package:json_annotation/json_annotation.dart';

import 'service_request_vo.dart';

part 'maintenance_vo.g.dart';

@JsonSerializable()
class MaintenanceVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant")
  final Tenant? tenant;

  @JsonKey(name: "issue")
  final String? issue;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "shop")
  final Shop? shop;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "attach")
  final List<String>? attach;

  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "__v")
  final int? version;

  MaintenanceVO({
    this.id,
    this.tenant,
    this.issue,
    this.description,
    this.shop,
    this.businessUnit,
    this.attach,
    this.status,
    this.version,
  });

  factory MaintenanceVO.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceVOFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceVOToJson(this);
}
