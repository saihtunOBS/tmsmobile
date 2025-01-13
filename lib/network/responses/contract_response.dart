import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/contract_vo.dart';

part 'contract_response.g.dart';

@JsonSerializable()
class ContractResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<ContractVo>? data;

  ContractResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ContractResponse.fromJson(Map<String, dynamic> json) =>
      _$ContractResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContractResponseToJson(this);
}
