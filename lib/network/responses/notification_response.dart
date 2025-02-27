import 'package:json_annotation/json_annotation.dart';
import 'package:tmsmobile/data/vos/notification_vo.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  @JsonKey(name: "success")
  final bool? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<NotificationVO>? data;

  NotificationResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
