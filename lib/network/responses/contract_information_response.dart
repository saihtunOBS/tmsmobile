import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/contract_information_vo.dart';

part 'contract_information_response.g.dart';

@JsonSerializable()
class ContractInformationResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final ContractInformationVO? data;

  ContractInformationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ContractInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$ContractInformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContractInformationResponseToJson(this);
}
