import 'package:json_annotation/json_annotation.dart';

part 'utility_vo.g.dart';

@JsonSerializable()
class UtilityVO {
  @JsonKey(name: "unit")
  final String? unit;

  @JsonKey(name: "qty")
  final int? qty;

  @JsonKey(name: "rate")
  final int? rate;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "rate_type")
  final String? rateType;

  @JsonKey(name: "this_month")
  final int? thisMonth;

  @JsonKey(name: "previous_month")
  final int? previousMonth;

  @JsonKey(name: "amount")
  final int? amount;

  @JsonKey(name: "_id")
  final String? id;

  UtilityVO({
    this.unit,
    this.qty,
    this.rate,
    this.title,
    this.rateType,
    this.thisMonth,
    this.previousMonth,
    this.amount,
    this.id,
  });

  factory UtilityVO.fromJson(Map<String, dynamic> json) => _$UtilityVOFromJson(json);

  Map<String, dynamic> toJson() => _$UtilityVOToJson(this);
}
