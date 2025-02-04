
import 'package:json_annotation/json_annotation.dart';

part 'pending_vo.g.dart';

@JsonSerializable()
class PendingVO {
  final int? status;
  final String? shop;
  final String? issue;
  final String? tenant;
  final List<String>? attach;
  final String? description;
  @JsonKey(name: "pending_date")
  final String? pendingDate;

  PendingVO(
      {this.status,
      this.shop,
      this.issue,
      this.tenant,
      this.attach,
      this.description,
      this.pendingDate});

  factory PendingVO.fromJson(Map<String, dynamic> json) =>
      _$PendingVOFromJson(json);

  Map<String, dynamic> toJson() => _$PendingVOToJson(this);
}