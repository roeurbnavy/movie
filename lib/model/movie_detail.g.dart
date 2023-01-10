// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      'backdrop_path',
      'overview',
      'runtime',
      'trailerId',
      'movieImage',
      'castList'
    ],
  );
  return MovieDetail(
    id: json['id'] as int,
    title: json['title'] as String,
    backdropPath: json['backdrop_path'] as String?,
    budget: json['budget'] as int,
    homePage: json['home_page'] as String?,
    originalTitle: json['original_title'] as String,
    overview: json['overview'] as String?,
    releaseDate: json['release_date'] as String,
    runtime: json['runtime'] as int?,
    voteAverage: json['vote_average'] as num,
    voteCount: json['vote_count'] as int,
  )
    ..trailerId = json['trailerId'] as String?
    ..movieImage = json['movieImage'] == null
        ? null
        : MovieImage.fromJson(json['movieImage'] as Map<String, dynamic>)
    ..castList = (json['castList'] as List<dynamic>?)
        ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MovieDetailToJson(MovieDetail instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('backdrop_path', instance.backdropPath);
  val['budget'] = instance.budget;
  val['home_page'] = instance.homePage;
  val['original_title'] = instance.originalTitle;
  writeNotNull('overview', instance.overview);
  val['release_date'] = instance.releaseDate;
  writeNotNull('runtime', instance.runtime);
  val['vote_average'] = instance.voteAverage;
  val['vote_count'] = instance.voteCount;
  writeNotNull('trailerId', instance.trailerId);
  writeNotNull('movieImage', instance.movieImage?.toJson());
  writeNotNull('castList', instance.castList?.map((e) => e.toJson()).toList());
  return val;
}
