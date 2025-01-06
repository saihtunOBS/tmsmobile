import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/household_vo.dart';

part 'household_registration_request.g.dart';

@JsonSerializable()
class HouseholdRegistrationRequest {
  @JsonKey(name: "register_date")
  final String? registerDate;

  @JsonKey(name: "move_in_date")
  final String? moveInDate;

  @JsonKey(name: "emergency_contact_number")
  final String? emergencyContactNumber;

  @JsonKey(name: "owner")
  final OwnerVO? owner;

  @JsonKey(name: "resident")
  final List<ResidentVO>? resident;
  HouseholdRegistrationRequest(this.registerDate, this.moveInDate,
      this.emergencyContactNumber, this.owner, this.resident);

  factory HouseholdRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$HouseholdRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HouseholdRegistrationRequestToJson(this);
}
