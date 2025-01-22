import 'package:json_annotation/json_annotation.dart';

part 'type_of_issue_vo.g.dart';

@JsonSerializable()
class TypeOfIssueVO {
  @JsonKey(name: "_id")
  final String? id;

  final String? name;

  final String? description;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @JsonKey(name: "__v")
  final int? version;

  TypeOfIssueVO({
    this.id,
    this.name,
    this.description,
    this.businessUnit,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory TypeOfIssueVO.fromJson(Map<String, dynamic> json) =>
      _$TypeOfIssueVOFromJson(json);

  Map<String, dynamic> toJson() => _$TypeOfIssueVOToJson(this);
}
