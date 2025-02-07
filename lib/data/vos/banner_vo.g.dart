// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerVO _$BannerVOFromJson(Map<String, dynamic> json) => BannerVO(
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      link: json['link'] as String?,
    );

Map<String, dynamic> _$BannerVOToJson(BannerVO instance) => <String, dynamic>{
      'photos': instance.photos,
      'link': instance.link,
    };
