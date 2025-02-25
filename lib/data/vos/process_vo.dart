import 'package:json_annotation/json_annotation.dart';

part 'process_vo.g.dart';

@JsonSerializable()
class ProcessVO {
  final int? status;
  final List<DetailVO>? details;
  @JsonKey(name: "sub_total")
  final int? subTotal;
  @JsonKey(name: "grand_total")
  final int? grandTotal;
  @JsonKey(name: "_id")
  final String? id;

  ProcessVO({this.status, this.details, this.subTotal, this.grandTotal, this.id});

  factory ProcessVO.fromJson(Map<String, dynamic> json) => _$ProcessVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessVOToJson(this);
}

@JsonSerializable()
class DetailVO {
  final String? description;
  final int? qty;
  final int? price;
  final int? tax;
  @JsonKey(name: "tax_type")
  final String? taxType;
  final int? amount;
  @JsonKey(name: "_id")
  final String? id;

  DetailVO({this.description, this.qty, this.price, this.tax, this.taxType, this.amount, this.id});

  factory DetailVO.fromJson(Map<String, dynamic> json) => _$DetailVOFromJson(json);

  Map<String, dynamic> toJson() => _$DetailVOToJson(this);
}
