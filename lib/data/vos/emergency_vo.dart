import 'package:json_annotation/json_annotation.dart';

part 'emergency_vo.g.dart';

@JsonSerializable()
class EmergencyVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "contract_name")
  final String? contractName;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "phone_1")
  final String? phone1;

  @JsonKey(name: "phone_2")
  final String? phone2;

  @JsonKey(name: "contract_ref")
  final String? contractRef;

  @JsonKey(name: "emergency_category")
  final EmergencyCategory? emergencyCategory;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @JsonKey(name: "__v")
  final int? version;

  EmergencyVO({
    this.id,
    this.contractName,
    this.address,
    this.phone1,
    this.phone2,
    this.contractRef,
    this.emergencyCategory,
    this.businessUnit,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory EmergencyVO.fromJson(Map<String, dynamic> json) =>
      _$EmergencyVOFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyVOToJson(this);
}

@JsonSerializable()
class EmergencyCategory {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  EmergencyCategory({this.id, this.name});

  factory EmergencyCategory.fromJson(Map<String, dynamic> json) =>
      _$EmergencyCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyCategoryToJson(this);
}
