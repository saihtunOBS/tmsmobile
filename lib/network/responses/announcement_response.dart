import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/announcement_vo.dart';

part 'announcement_response.g.dart';

@JsonSerializable()
class AnnouncementResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<AnnouncementVO>? data;

  AnnouncementResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementResponseToJson(this);
}
