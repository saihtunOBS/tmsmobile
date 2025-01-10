import 'package:json_annotation/json_annotation.dart';

part 'household_resident_request.g.dart';

@JsonSerializable()
class HouseholdResidentRequest {
  @JsonKey(name: "type")
  final int? type;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "gender")
  final String? gender; // Male or Female

  @JsonKey(name: "date_of_birth")
  final String? dateOfBirth;

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

  HouseholdResidentRequest({
    this.type,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.race,
    this.nationality,
    this.nrc,
    this.nrcType,
    this.contactNumber,
    this.relatedToOwner,
  });

  factory HouseholdResidentRequest.fromJson(Map<String, dynamic> json) => _$HouseholdResidentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HouseholdResidentRequestToJson(this);
}
