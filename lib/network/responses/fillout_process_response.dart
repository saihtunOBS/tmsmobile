import 'package:json_annotation/json_annotation.dart';

part 'fillout_process_response.g.dart';

@JsonSerializable()
class FilloutProcessResponse {
  @JsonKey(name: "success")
  final bool? success;

  @JsonKey(name: "data")
  final List<FilloutProcessData>? data;

  @JsonKey(name: "message")
  final String? message;

  FilloutProcessResponse({this.success, this.data, this.message});

  factory FilloutProcessResponse.fromJson(Map<String, dynamic> json) => _$FilloutProcessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilloutProcessResponseToJson(this);
}

@JsonSerializable()
class FilloutProcessData {
  @JsonKey(name: "status_name")
  final String? statusName;

  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "photos")
  final List<String>? photos;

  @JsonKey(name: "pending_date")
  final DateTime? pendingDate;

  @JsonKey(name: "service_date")
  final String? serviceDate;

  @JsonKey(name: "amount")
  final int? amount;

  @JsonKey(name: "deposit_amount")
  final int? depositAmount;

  FilloutProcessData({
    this.statusName,
    this.status,
    this.photos,
    this.pendingDate,
    this.serviceDate,
    this.amount,
    this.depositAmount,
  });

  factory FilloutProcessData.fromJson(Map<String, dynamic> json) => _$FilloutProcessDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilloutProcessDataToJson(this);
}
