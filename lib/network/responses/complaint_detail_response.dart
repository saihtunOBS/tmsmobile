import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/complaint_vo.dart';


part 'complaint_detail_response.g.dart';

@JsonSerializable()
class ComplaintDetailResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final ComplaintVO? data;

  ComplaintDetailResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory ComplaintDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ComplaintDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComplaintDetailResponseToJson(this);
}
