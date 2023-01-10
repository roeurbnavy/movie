// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as int,
      gender: json['gender'] as int,
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
      knownForDepartment: json['known_for_department'] as String,
      popularity: json['popularity'] as num,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'known_for_department': instance.knownForDepartment,
      'popularity': instance.popularity,
    };
