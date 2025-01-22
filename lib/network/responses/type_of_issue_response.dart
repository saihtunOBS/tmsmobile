import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/type_of_issue_vo.dart';

part 'type_of_issue_response.g.dart';

@JsonSerializable()
class TypeOfIssueResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "messaage")
  final String? message;

  @JsonKey(name: "data")
  final List<TypeOfIssueVO>? data;

  TypeOfIssueResponse({
    this.status,
    this.message,
    this.data
  });

  factory TypeOfIssueResponse.fromJson(Map<String, dynamic> json) =>
      _$TypeOfIssueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TypeOfIssueResponseToJson(this);
}
