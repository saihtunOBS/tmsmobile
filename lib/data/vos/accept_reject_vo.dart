import 'package:json_annotation/json_annotation.dart';
part 'accept_reject_vo.g.dart';

@JsonSerializable()
class AcceptRejectVO {
  final int? status;
  @JsonKey(name: "accept_reject_date")
  final String? acceptRejectDate;

  AcceptRejectVO({this.status, this.acceptRejectDate});

  factory AcceptRejectVO.fromJson(Map<String, dynamic> json) =>
      _$AcceptRejectVOFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptRejectVOToJson(this);
}