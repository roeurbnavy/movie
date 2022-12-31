import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/movie.dart';

// https://api.themoviedb.org/3//movie/popular?api_key=112a7a0e39199e2c2d3acb362b908fb6

class MovieServices {
  Future<dynamic> getPopular() async {
    String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=112a7a0e39199e2c2d3acb362b908fb6';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    List<Movie> data = [];
    print("response ${response.toString()}");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final results = json['results'] as List;
      data = results.map(
        (e) {
          return Movie(
            title: e['title'],
            id: e['id'],
            posterPath: e['poster_path'],
            releaseDate: e['release_date'],
            voteAverage: e['vote_average'].toDouble(),
            overview: e['overview'],
            voteCount: e['vote_count'],
            videoPath: '',
          );
        },
      ).toList();
    }
    return {'res': response, 'data': data};

    // return [];
  }

  Future<String> getVideo(int movieId) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=112a7a0e39199e2c2d3acb362b908fb6';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final results = json['results'] as List;
      print("getVideo $results");
      // final data = results.map((e) {
      //   return Movie(
      //       title: e['title'],
      //       id: e['id'],
      //       posterPath: e['poster_path'],
      //       releaseDate: e['release_date'],
      //       // voteAverage: e['vote_average'],
      //       overview: e['overview'],
      //       voteCount: e['vote_count'],
      //       videoPath: ''
      //       );
      // }).toList();

      return "https://www.youtube.com/embed/${results[0]['key']}";
    }

    return '';
  }
}
