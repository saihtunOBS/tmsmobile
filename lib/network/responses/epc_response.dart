import 'package:json_annotation/json_annotation.dart';

part 'epc_response.g.dart';

@JsonSerializable()
class EpcResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<EpcData>? data;

  EpcResponse({
    this.status,
    this.message,
    this.data,
  });

  factory EpcResponse.fromJson(Map<String, dynamic> json) => _$EpcResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EpcResponseToJson(this);
}

@JsonSerializable()
class EpcData {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "switch")
  final int? switchState;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "__v")
  final int? version;

  EpcData({
    this.id,
    this.switchState,
    this.businessUnit,
    this.version,
  });

  factory EpcData.fromJson(Map<String, dynamic> json) => _$EpcDataFromJson(json);

  Map<String, dynamic> toJson() => _$EpcDataToJson(this);
}
