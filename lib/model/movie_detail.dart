import 'package:json_annotation/json_annotation.dart';
import 'package:movies/model/cast.dart';
import 'package:movies/model/movie_image.dart';
part 'movie_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetail {
  final int id;
  final String title;
  @JsonKey(name: "backdrop_path", disallowNullValue: true, defaultValue: null)
  final String? backdropPath;
  final int budget;
  @JsonKey(name: 'home_page', disallowNullValue: false)
  final String? homePage;
  @JsonKey(name: "original_title")
  final String originalTitle;
  @JsonKey(disallowNullValue: true, defaultValue: null)
  final String? overview;
  @JsonKey(name: "release_date")
  final String releaseDate;
  @JsonKey(disallowNullValue: true, defaultValue: null)
  final int? runtime;
  @JsonKey(name: "vote_average")
  final num voteAverage;
  @JsonKey(name: "vote_count")
  final int voteCount;

  @JsonKey(disallowNullValue: true, defaultValue: null)
  late String? trailerId;
  @JsonKey(disallowNullValue: true, defaultValue: null)
  late MovieImage? movieImage;
  @JsonKey(disallowNullValue: true, defaultValue: null)
  late List<Cast>? castList;

  MovieDetail({
    required this.id,
    required this.title,
    this.backdropPath,
    required this.budget,
    required this.homePage,
    required this.originalTitle,
    this.overview,
    required this.releaseDate,
    this.runtime,
    required this.voteAverage,
    required this.voteCount,
    // required this.trailerId,
    // required this.movieImage,
    // required this.castList,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}
