
import 'package:json_annotation/json_annotation.dart';

import '../../network/requests/household_registration_request.dart';

part 'household_vo.g.dart';

@JsonSerializable()
class HouseHoldVO {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "register_date")
  final DateTime registerDate;

  @JsonKey(name: "move_in_date")
  final DateTime moveInDate;

  @JsonKey(name: "emergency_contact_number")
  final String emergencyContactNumber;

  @JsonKey(name: "information")
  final List<HouseHoldInformation> information;

  final String tenant;

  @JsonKey(name: "business_unit")
  final String businessUnit;

  final DateTime createdAt;
  final DateTime updatedAt;

  @JsonKey(name: "__v")
  final int version;

  HouseHoldVO({
    required this.id,
    required this.registerDate,
    required this.moveInDate,
    required this.emergencyContactNumber,
    required this.information,
    required this.tenant,
    required this.businessUnit,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory HouseHoldVO.fromJson(Map<String, dynamic> json) => _$HouseHoldVOFromJson(json);

  Map<String, dynamic> toJson() => _$HouseHoldVOToJson(this);
}