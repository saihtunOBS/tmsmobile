import 'package:json_annotation/json_annotation.dart';

import 'service_request_vo.dart';

part 'contract_vo.g.dart';

@JsonSerializable()
class ContractVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant")
  final Tenant? tenant;

  @JsonKey(name: "property_type")
  final String? propertyType;

  ContractVO({this.id, this.tenant, this.propertyType});

  factory ContractVO.fromJson(Map<String, dynamic> json) =>
      _$ContractVOFromJson(json);

  Map<String, dynamic> toJson() => _$ContractVOToJson(this);
}
