import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  final int id;
  final int gender;
  final String name;

  @JsonKey(name: 'profile_path', disallowNullValue: false)
  final String? profilePath;

  @JsonKey(name: 'known_for_department')
  final String knownForDepartment;
  final num popularity;

  Person({
    required this.id,
    required this.gender,
    required this.name,
    required this.profilePath,
    required this.knownForDepartment,
    required this.popularity,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
