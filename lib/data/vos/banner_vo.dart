
import 'package:json_annotation/json_annotation.dart';
part 'banner_vo.g.dart';

@JsonSerializable()
class BannerVO {
  @JsonKey(name: "photos")
  final List<String>? photos;

  @JsonKey(name: "link")
  final String? link;

  BannerVO({this.photos, this.link});

  factory BannerVO.fromJson(Map<String, dynamic> json) => _$BannerVOFromJson(json);

  Map<String, dynamic> toJson() => _$BannerVOToJson(this);
}