import 'package:json_annotation/json_annotation.dart';

part 'service_request_vo.g.dart';

@JsonSerializable()
class ServiceRequestVo {
  @JsonKey(name: "_id")
  final String? id;

  final Tenant? tenant;
  final Shop? shop;

  final List<String>? photos;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @JsonKey(name: "__v")
  final int? version;

  ServiceRequestVo({
    this.id,
    this.tenant,
    this.shop,
    this.photos,
    this.businessUnit,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory ServiceRequestVo.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestVoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestVoToJson(this);
}

@JsonSerializable()
class Tenant {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant_name")
  final String? tenantName;

  Tenant({this.id, this.tenantName});

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

  Map<String, dynamic> toJson() => _$TenantToJson(this);
}

@JsonSerializable()
class Shop {
  @JsonKey(name: "_id")
  final String? id;

  final String? name;

  Shop({this.id, this.name});

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
