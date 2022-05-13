import 'package:chill_hub/models/movie.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Movies with ChangeNotifier {
  List<Movie> _latestMovies = [];
  List<Movie> get latestMovies => _latestMovies;
//Caregories Movies
  List<Movie> _catMovies = [];
  List<Movie> get catMovies => _catMovies;

  Future<void> fetchLatestMovies() async {
    String url = 'https://yts.mx/api/v2/list_movies.json?sort_by=year';
    var response = await http.get(Uri.parse(url), headers: {
      'Bearer': 'Token 73ccc363e9074a98b0411dc1a6565531',
      'Content-type': 'application/json',
    });

    var data = json.decode(response.body);

    if (data['status'] == 'ok') {
      List<Movie> _loadedMovies = [];

      data['data']['movies'].forEach((movie) {
        _loadedMovies.add(
          Movie(
            id: movie['id'],
            title: movie['title'],
            year: movie['year'],
            coverImg: movie['large_cover_image'],
            rating: movie['rating'],
          ),
        );
      });
      _latestMovies = _loadedMovies;
    } else {
      throw Exception('error');
    }
    notifyListeners();
  }

  Future<void> fetchCatMovies(int pageNumber) async {
    String url = 'https://yts.mx/api/v2/list_movies.json?page=$pageNumber';
    var response = await http.get(Uri.parse(url), headers: {
      'Bearer': 'Token 73ccc363e9074a98b0411dc1a6565531',
    });

    var data = json.decode(response.body);

    if (data['status'] == 'ok') {
      List<Movie> _loadedMovies = [];

      data['data']['movies'].forEach((movie) {
        _loadedMovies.add(
          Movie(
            id: movie['id'],
            title: movie['title'],
            year: movie['year'],
            coverImg: movie['large_cover_image'],
            rating: movie['rating'],
          ),
        );
      });
      _catMovies = _loadedMovies;
    } else {
      throw Exception('error');
    }
    notifyListeners();
  }
}
