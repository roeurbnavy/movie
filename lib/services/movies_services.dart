import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/cast.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/model/movie_detail.dart';
import 'package:movies/model/movie_image.dart';
import 'package:movies/model/person.dart';

// https://api.themoviedb.org/3//movie/popular?api_key=112a7a0e39199e2c2d3acb362b908fb6

class MovieServices {
  //
  String url = 'https://api.themoviedb.org/3';
  String apiKey = 'api_key=112a7a0e39199e2c2d3acb362b908fb6';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final uri = Uri.parse("$url/movie/now_playing?$apiKey");
      final response = await http.get(uri);
      List<Movie> data = [];
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final results = json['results'] as List;
        data = results.map((e) => Movie.fromJson(e)).toList();
      }
      return data;

      // return [];
    } catch (e, stacktrace) {
      throw Exception("Exception accrued $e with stacktrace $stacktrace");
    }
  }

  Future<List<Movie>> getMovieByGenre(int genreId) async {
    try {
      final uri = Uri.parse("$url/discover/movie?with_genres=$genreId&$apiKey");
      final response = await http.get(uri);
      List<Movie> data = [];
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final results = json['results'] as List;
        // print("results $results");
        if (results.isNotEmpty) {
          data = results.map((e) => Movie.fromJson(e)).toList();
        }
      }
      return data;

      // return [];
    } catch (e, stacktrace) {
      throw Exception("Exception accrued $e with stacktrace $stacktrace");
    }
  }

  Future<List<Genre>> getGenreList() async {
    try {
      final uri = Uri.parse("$url/genre/movie/list?$apiKey");
      final response = await http.get(uri);
      // print("response ${response.statusCode} ${response.body}");
      List<Genre> data = [];
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final results = json['genres'] as List;
        data = results.map((e) => Genre.fromJson(e)).toList();
      }
      return data;
    } catch (e, stacktrace) {
      throw Exception("Exception accrued $e with stacktrace $stacktrace");
    }
  }

  Future<List<Person>> getTrendingPersons() async {
    try {
      final uri = Uri.parse("$url/trending/person/week?$apiKey");

      final response = await http.get(uri);
      // print("response ${response.statusCode} ${response.body}");
      List<Person> data = [];
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final results = json['results'] as List;
        // print("results $results");
        data = results.map((e) => Person.fromJson(e)).toList();
      }
      return data;
    } catch (e, stacktrace) {
      throw Exception("Exception accrued $e with stacktrace $stacktrace");
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final uri = Uri.parse("$url/movie/$movieId?$apiKey");

      final response = await http.get(uri);
      // print("response ${response.statusCode} ${response.body}");
      late MovieDetail data;
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as dynamic;
        // json['trailerId'] = await getYoutubeId(movieId);
        // json['movieImage'] =
        //     await getMovieImage(movieId);
        // json['castList'] = await getCastList(movieId);

        data = MovieDetail.fromJson(json);
        data.movieImage = await getMovieImage(movieId);
        data.castList = await getCastList(movieId);
        data.trailerId = await getYoutubeId(movieId);
      }
      return data;
    } catch (e, stacktrace) {
      throw Exception("Exception accrued $e with stacktrace $stacktrace");
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final uri = Uri.parse("$url/movie/$id/videos?$apiKey");

      final response = await http.get(uri);
      // print("response ${response.statusCode} ${response.body}");
      String youtubeId = '';
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // print('youtubeId $json');
        youtubeId = json['results'][0]['key'];
      }
      return youtubeId;
    } catch (e, stacktrace) {
      throw Exception("Exception accrued $e with stacktrace $stacktrace");
    }
  }

  Future<MovieImage> getMovieImage(int id) async {
    try {
      final uri = Uri.parse("$url/movie/$id/images?$apiKey");

      final response = await http.get(uri);
      late MovieImage data;
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // print('get image $json');
        data = MovieImage.fromJson(json);
      }
      return data;
    } catch (e, stacktrace) {
      throw Exception("Exception accrued $e with stacktrace $stacktrace");
    }
  }

  Future<List<Cast>> getCastList(int id) async {
    try {
      final uri = Uri.parse("$url/movie/$id/credits?$apiKey");

      final response = await http.get(uri);
      List<Cast> data = [];
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final results = json['cast'] as List;
        data = results.map((e) => Cast.fromJson(e)).toList();
      }
      return data;
    } catch (e, stacktrace) {
      throw Exception("Exception accrued $e with stacktrace $stacktrace");
    }
  }
}
