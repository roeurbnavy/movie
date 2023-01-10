import 'package:json_annotation/json_annotation.dart';

part 'cast.g.dart';

@JsonSerializable()
class Cast {
  final String name;
  @JsonKey(name: 'profile_path', disallowNullValue: false)
  final String? profilePath;
  final String character;

  Cast(
      {required this.name, required this.profilePath, required this.character});

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable()
class CastList {
  final List<Cast> cast;

  CastList({required this.cast});

  factory CastList.fromJson(Map<String, dynamic> json) =>
      _$CastListFromJson(json);
  Map<String, dynamic> toJson() => _$CastListToJson(this);
}
