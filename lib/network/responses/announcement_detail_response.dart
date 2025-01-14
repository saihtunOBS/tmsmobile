import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';

part 'announcement_detail_response.g.dart';

@JsonSerializable()
class AnnouncementDetailResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final AnnouncementVO? data;

  AnnouncementDetailResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory AnnouncementDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementDetailResponseToJson(this);
}
