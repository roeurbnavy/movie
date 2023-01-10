import 'package:json_annotation/json_annotation.dart';
import 'package:movies/model/screen_short.dart';

part 'movie_image.g.dart';

@JsonSerializable()
class MovieImage {
  final List<ScreenShort> backdrops;
  final List<ScreenShort> posters;

  MovieImage({
    required this.backdrops,
    required this.posters,
  });

  factory MovieImage.fromJson(Map<String, dynamic> json) =>
      _$MovieImageFromJson(json);

  Map<String, dynamic> toJson() => _$MovieImageToJson(this);
}
