import 'package:json_annotation/json_annotation.dart';

part 'household_vo.g.dart';

@JsonSerializable()
class HouseHoldVO {
  @JsonKey(name: "owner")
  final OwnerVO? owner;

  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "register_date")
  final DateTime? registerDate;

  @JsonKey(name: "move_in_date")
  final DateTime? moveInDate;

  @JsonKey(name: "emergency_contact_number")
  final String? emergencyContactNumber;

  @JsonKey(name: "resident")
  final List<ResidentVO>? resident;

  @JsonKey(name: "tenant")
  final String? tenant;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @JsonKey(name: "__v")
  final int? version;

  HouseHoldVO({
    this.owner,
    this.id,
    this.registerDate,
    this.moveInDate,
    this.emergencyContactNumber,
    this.resident,
    this.tenant,
    this.businessUnit,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory HouseHoldVO.fromJson(Map<String, dynamic> json) =>
      _$HouseHoldVOFromJson(json);

  Map<String, dynamic> toJson() => _$HouseHoldVOToJson(this);
}

@JsonSerializable()
class OwnerVO {
  @JsonKey(name: "owner_name")
  final String? ownerName;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "date_of_birth")
  final DateTime? dateOfBirth;

  @JsonKey(name: "race")
  final String? race;

  @JsonKey(name: "nationality")
  final String? nationality;

  @JsonKey(name: "nrc")
  final String? nrc;

  @JsonKey(name: "nrc_type")
  final int? nrcType;

  @JsonKey(name: "contact_number")
  final String? contactNumber;

  @JsonKey(name: "email")
  final String? email;

  OwnerVO({
    this.ownerName,
    this.gender,
    this.dateOfBirth,
    this.race,
    this.nrcType,
    this.nationality,
    this.nrc,
    this.contactNumber,
    this.email,
  });

  factory OwnerVO.fromJson(Map<String, dynamic> json) =>
      _$OwnerVOFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerVOToJson(this);
}

@JsonSerializable()
class ResidentVO {
  @JsonKey(name: "resident_name")
  final String? residentName;

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "date_of_birth")
  final DateTime? dateOfBirth;

  @JsonKey(name: "race")
  final String? race;

  @JsonKey(name: "nationality")
  final String? nationality;

  @JsonKey(name: "nrc")
  final String? nrc;

  @JsonKey(name: "nrc_type")
  final int? nrcType;

  @JsonKey(name: "contact_number")
  final String? contactNumber;

  @JsonKey(name: "related_to_owner")
  final String? relatedToOwner;

  @JsonKey(name: "_id")
  final String? id;

  ResidentVO({
    this.residentName,
    this.gender,
    this.dateOfBirth,
    this.race,
    this.nationality,
    this.nrc,
    this.nrcType,
    this.contactNumber,
    this.relatedToOwner,
    this.id,
  });

  factory ResidentVO.fromJson(Map<String, dynamic> json) =>
      _$ResidentVOFromJson(json);

  Map<String, dynamic> toJson() => _$ResidentVOToJson(this);
}
