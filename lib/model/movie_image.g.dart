// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieImage _$MovieImageFromJson(Map<String, dynamic> json) => MovieImage(
      backdrops: (json['backdrops'] as List<dynamic>)
          .map((e) => ScreenShort.fromJson(e as Map<String, dynamic>))
          .toList(),
      posters: (json['posters'] as List<dynamic>)
          .map((e) => ScreenShort.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieImageToJson(MovieImage instance) =>
    <String, dynamic>{
      'backdrops': instance.backdrops,
      'posters': instance.posters,
    };
