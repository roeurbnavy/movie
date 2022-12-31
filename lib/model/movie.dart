class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final String posterPath;
  final String overview;
  final String videoPath;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
    required this.overview,
    required this.videoPath,
  });
}
