import 'package:json_annotation/json_annotation.dart';

part 'announcement_vo.g.dart';

@JsonSerializable()
class AnnouncementVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "sendTo")
  final int? sendTo;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "photos")
  final List<String>? photos;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @JsonKey(name: "__v")
  final int? version;

  AnnouncementVO({
    this.id,
    this.sendTo,
    this.title,
    this.description,
    this.photos,
    this.businessUnit,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory AnnouncementVO.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementVOFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementVOToJson(this);
}
