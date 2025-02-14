import 'package:json_annotation/json_annotation.dart';

part 'complaint_vo.g.dart';

@JsonSerializable()
class ComplaintVO {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'complaint')
  final String? complaint;

  @JsonKey(name: 'photos')
  final List<String>? photos;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'tenant')
  final String? tenant;

  @JsonKey(name: 'business_unit')
  final String? businessUnit;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final int? version;

  ComplaintVO({
    this.id,
    this.complaint,
    this.status,
    this.photos,
    this.tenant,
    this.businessUnit,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory ComplaintVO.fromJson(Map<String, dynamic> json) =>
      _$ComplaintVOFromJson(json);

  Map<String, dynamic> toJson() => _$ComplaintVOToJson(this);
}
