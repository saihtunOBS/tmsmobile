import 'package:json_annotation/json_annotation.dart';

part 'quotation_detail_vo.g.dart';
@JsonSerializable()
class QuotationDetailVO {
  final String? description;
  final int? qty;
  final int? price;
  final int? tax;
  @JsonKey(name: "tax_type")
  final String? taxType;
  final int? amount;
  final String? id;

  QuotationDetailVO(
      {this.description,
      this.qty,
      this.price,
      this.tax,
      this.taxType,
      this.amount,
      this.id});

  factory QuotationDetailVO.fromJson(Map<String, dynamic> json) =>
      _$QuotationDetailVOFromJson(json);

  Map<String, dynamic> toJson() => _$QuotationDetailVOToJson(this);
}