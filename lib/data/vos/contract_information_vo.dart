import 'package:json_annotation/json_annotation.dart';

import 'parking_vo.dart';

part 'contract_information_vo.g.dart';

@JsonSerializable()
class ContractInformationVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant")
  final ContractTenant? tenant;

  @JsonKey(name: "property_type")
  final String? propertyType;

  @JsonKey(name: "property_information")
  final List<PropertyInformation>? propertyInformation;

  ContractInformationVO({
    this.id,
    this.tenant,
    this.propertyType,
    this.propertyInformation,
  });

  factory ContractInformationVO.fromJson(Map<String, dynamic> json) =>
      _$ContractInformationVOFromJson(json);

  Map<String, dynamic> toJson() => _$ContractInformationVOToJson(this);
}

@JsonSerializable()
class ContractTenant {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant_name")
  final String? tenantName;

  @JsonKey(name: "tenant_category")
  final TenantCategory? tenantCategory;

  ContractTenant({
    this.id,
    this.tenantName,
    this.tenantCategory,
  });

  factory ContractTenant.fromJson(Map<String, dynamic> json) => _$ContractTenantFromJson(json);

  Map<String, dynamic> toJson() => _$ContractTenantToJson(this);
}

@JsonSerializable()
class TenantCategory {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant_category_name")
  final String? tenantCategoryName;

  TenantCategory({this.id, this.tenantCategoryName});

  factory TenantCategory.fromJson(Map<String, dynamic> json) =>
      _$TenantCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$TenantCategoryToJson(this);
}

@JsonSerializable()
class PropertyInformation {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "branch")
  final PropertyDetail? branch;

  @JsonKey(name: "building")
  final PropertyDetail? building;

  @JsonKey(name: "floor")
  final PropertyDetail? floor;

  @JsonKey(name: "zone")
  final PropertyDetail? zone;

  @JsonKey(name: "shop")
  final ContractShop? shop;

  @JsonKey(name: "room_type")
  final RoomType? roomType;

  @JsonKey(name: "total_area")
  final String? totalArea;

  @JsonKey(name: "price")
  final int? price;

  @JsonKey(name: "parking_information")
  final List<ParkingVO>? parkingInformation;

  PropertyInformation({
    this.id,
    this.branch,
    this.building,
    this.floor,
    this.zone,
    this.shop,
    this.roomType,
    this.totalArea,
    this.price,
    this.parkingInformation,
  });

  factory PropertyInformation.fromJson(Map<String, dynamic> json) =>
      _$PropertyInformationFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyInformationToJson(this);
}

@JsonSerializable()
class PropertyDetail {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  PropertyDetail({this.id, this.name});

  factory PropertyDetail.fromJson(Map<String, dynamic> json) =>
      _$PropertyDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDetailToJson(this);
}

@JsonSerializable()
class ContractShop {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "total_area")
  final int? totalArea;

  @JsonKey(name: 'parking_information')
  final List<ParkingVO>? parkingData;

  ContractShop({this.id, this.name, this.status, this.totalArea,this.parkingData});

  factory ContractShop.fromJson(Map<String, dynamic> json) => _$ContractShopFromJson(json);

  Map<String, dynamic> toJson() => _$ContractShopToJson(this);
}

@JsonSerializable()
class RoomType {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "room_type")
  final String? roomType;

  RoomType({this.id, this.roomType});

  factory RoomType.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RoomTypeToJson(this);
}
