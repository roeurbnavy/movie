// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenShort _$ScreenShortFromJson(Map<String, dynamic> json) => ScreenShort(
      aspectRatio: json['aspect_ratio'] as num,
      imagePath: json['file_path'] as String,
      height: json['height'] as int,
      width: json['width'] as int,
      countryCode: json['iso_639_1'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );

Map<String, dynamic> _$ScreenShortToJson(ScreenShort instance) =>
    <String, dynamic>{
      'aspect_ratio': instance.aspectRatio,
      'file_path': instance.imagePath,
      'height': instance.height,
      'width': instance.width,
      'iso_639_1': instance.countryCode,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
