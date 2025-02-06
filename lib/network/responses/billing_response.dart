import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/billing_vo.dart';

part 'billing_response.g.dart';

@JsonSerializable()
class BillingResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<BillingVO>? data;

  BillingResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory BillingResponse.fromJson(Map<String, dynamic> json) =>
      _$BillingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BillingResponseToJson(this);
}
