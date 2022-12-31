import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/services/movies_services.dart';

class MovieProvider with ChangeNotifier {
  final MovieServices _service = MovieServices();

  bool _isLoading = false;
  dynamic _response;
  String _videoPath = '';
  List<Movie> _movies = [];

  final List<Movie> _favoriteList = [];

  // Get
  List<Movie> get movies => _movies;
  List<Movie> get favoriteList => _favoriteList;
  String get videoPath => _videoPath;
  bool get isLoading => _isLoading;
  dynamic get response => _response;

// Method
  Future<void> getPopular() async {
    _isLoading = true;
    notifyListeners();

    final response = await _service.getPopular();
    // print('response $response');
    _response = response['res'];
    _movies = response['data'];
    _isLoading = false;
    notifyListeners();
  }

  // Method
  Future<String> getVideo(int movieId) async {
    _isLoading = true;
    notifyListeners();

    final response = await _service.getVideo(movieId);

    _videoPath = response;
    _isLoading = false;
    notifyListeners();

    return _videoPath;
  }

  void addToList(Movie movie) {
    _favoriteList.add(movie);
    notifyListeners();
  }

  void removeFromList(Movie movie) {
    _favoriteList.remove(movie);
    notifyListeners();
  }
}
