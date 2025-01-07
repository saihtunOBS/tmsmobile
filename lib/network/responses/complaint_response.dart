import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/complaint_vo.dart';


part 'complaint_response.g.dart';

@JsonSerializable()
class ComplaintResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<ComplaintVO>? data;

  ComplaintResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory ComplaintResponse.fromJson(Map<String, dynamic> json) =>
      _$ComplaintResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComplaintResponseToJson(this);
}
