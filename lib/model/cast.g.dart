// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
      character: json['character'] as String,
    );

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'name': instance.name,
      'profile_path': instance.profilePath,
      'character': instance.character,
    };

CastList _$CastListFromJson(Map<String, dynamic> json) => CastList(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CastListToJson(CastList instance) => <String, dynamic>{
      'cast': instance.cast,
    };
