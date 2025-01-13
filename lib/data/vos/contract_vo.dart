import 'package:json_annotation/json_annotation.dart';

import 'service_request_vo.dart';

part 'contract_vo.g.dart';

@JsonSerializable()
class ContractVo {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant")
  final Tenant? tenant;

  @JsonKey(name: "property_type")
  final String? propertyType;

  ContractVo({this.id, this.tenant, this.propertyType});

  factory ContractVo.fromJson(Map<String, dynamic> json) =>
      _$ContractVoFromJson(json);

  Map<String, dynamic> toJson() => _$ContractVoToJson(this);
}
