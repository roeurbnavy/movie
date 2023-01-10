import 'package:json_annotation/json_annotation.dart';

part 'screen_short.g.dart';

@JsonSerializable()
class ScreenShort {
  @JsonKey(name: 'aspect_ratio')
  final num aspectRatio;
  @JsonKey(name: 'file_path')
  final String imagePath;
  final int height;
  final int width;
  @JsonKey(name: 'iso_639_1', disallowNullValue: false)
  final String? countryCode;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  ScreenShort({
    required this.aspectRatio,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.countryCode,
    required this.voteAverage,
    required this.voteCount,
  });

  factory ScreenShort.fromJson(Map<String, dynamic> json) =>
      _$ScreenShortFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenShortToJson(this);
}
