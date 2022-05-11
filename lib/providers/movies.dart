import 'package:chill_hub/models/movie.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Movies with ChangeNotifier {
  List<Movie> _latestMovies = [];
  List<Movie> get latestMovies => _latestMovies;

  Future<void> fetchLatestMovies() async {
    String url = 'https://yts.mx/api/v2/list_movies.json?sort_by=rating';
    var response = await http.get(Uri.parse(url));
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
          ),
        );
      });
      _latestMovies = _loadedMovies;
    } else {
      throw Exception('error');
    }
    notifyListeners();
  }
}
