import 'package:json_annotation/json_annotation.dart';
part 'processing_vo.g.dart';
@JsonSerializable()
class ProcessingVO {
  final int? status;
  @JsonKey(name: "processing_date")
  final String? processingDate;
  @JsonKey(name: "processing_description")
  final String? processingDescription;

  ProcessingVO({this.status, this.processingDate, this.processingDescription});

  factory ProcessingVO.fromJson(Map<String, dynamic> json) =>
      _$ProcessingVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessingVOToJson(this);
}