import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/household_vo.dart';

part 'household_response.g.dart';

@JsonSerializable()
class HouseholdResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<HouseHoldVO>?  data;

  HouseholdResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory HouseholdResponse.fromJson(Map<String, dynamic> json) =>
      _$HouseholdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HouseholdResponseToJson(this);
}
