import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/model/movie_detail.dart';
import 'package:movies/model/person.dart';
import 'package:movies/services/movies_services.dart';

class MovieProvider with ChangeNotifier {
  final MovieServices _service = MovieServices();

  bool _isLoading = false;
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _movies = [];
  MovieDetail? _movieDetail;
  List<Genre> _genres = [];
  List<Person> _trendingPersons = [];

  // Get
  List<Movie> get movies => _movies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Genre> get genres => _genres;
  List<Person> get trendingPerson => _trendingPersons;
  MovieDetail? get movieDetail => _movieDetail;
  bool get isLoading => _isLoading;

// Method
  Future<void> getNowPlayingMovie() async {
    _isLoading = true;
    notifyListeners();

    final response = await _service.getNowPlayingMovie();
    // print('response $response');
    _nowPlayingMovies = response;
    _isLoading = false;
    notifyListeners();
  }

  Future<List<Genre>> getGenreList() async {
    final response = await _service.getGenreList();

    _genres = response;
    return _genres;
  }

  Future<List<Movie>> getMovieByGenre(int genreId) async {
    // _isLoading = true;
    // notifyListeners();

    final response = await _service.getMovieByGenre(genreId);
    // print('response $response');
    _movies = response;
    // _isLoading = false;
    notifyListeners();
    return _movies;
  }

  Future<List<Person>> getTrendingPerson() async {
    final response = await _service.getTrendingPersons();
    // print('response $response');

    _trendingPersons = response;
    notifyListeners();
    return _trendingPersons;
  }

  Future<MovieDetail?> getMovieDetail(int movieId) async {
    final response = await _service.getMovieDetail(movieId);

    _movieDetail = response;
    notifyListeners();
    return _movieDetail;
  }
}
