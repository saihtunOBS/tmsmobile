import 'package:json_annotation/json_annotation.dart';

part 'household_registration_request.g.dart';

@JsonSerializable()
class HouseholdRegistrationRequest {
  @JsonKey(name: "register_date")
  final String? registerDate;

  @JsonKey(name: "move_in_date")
  final String? moveInDate;

  @JsonKey(name: "emergency_contact_number")
  final String? emergencyContactNumber;

  @JsonKey(name: "information")
  final List<HouseHoldInformation> information;

  HouseholdRegistrationRequest(this.registerDate, this.moveInDate,
      this.emergencyContactNumber, this.information);

  factory HouseholdRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$HouseholdRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HouseholdRegistrationRequestToJson(this);
}

@JsonSerializable()
class HouseHoldInformation {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: "type")
  final int? type;

  @JsonKey(name: "name")
  final String? name;

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

  @JsonKey(name: "email", includeIfNull: false)
  final String? email;

  @JsonKey(name: "related_to_owner", includeIfNull: false)
  final String? relatedToOwner;

  HouseHoldInformation({
    this.id,
    this.type,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.race,
    this.nationality,
    this.nrc,
    this.nrcType,
    this.contactNumber,
    this.email,
    this.relatedToOwner,
  });

  factory HouseHoldInformation.fromJson(Map<String, dynamic> json) =>
      _$HouseHoldInformationFromJson(json);

  Map<String, dynamic> toJson() => _$HouseHoldInformationToJson(this);
}
