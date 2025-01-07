import 'package:json_annotation/json_annotation.dart';

part 'complaint_request.g.dart';

@JsonSerializable()
class ComplaintRequest {
  @JsonKey(name: "complaint")
  String? complaint;

  ComplaintRequest(
    this.complaint,
  );

  factory ComplaintRequest.fromJson(Map<String, dynamic> json) =>
      _$ComplaintRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ComplaintRequestToJson(this);
}
