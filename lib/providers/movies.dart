import 'dart:io';

import 'package:chill_hub/models/movie.dart';
import 'package:chill_hub/models/movie_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Movies with ChangeNotifier {
  List<Movie> _latestMovies = [];
  List<Movie> get latestMovies => _latestMovies;
  MovieDetail? movieDetail;
//Caregories Movies
  List<Movie> _catMovies = [];
  List<Movie> get catMovies => _catMovies;
  //Related Movies
  List<Movie> _relatedMovies = [];
  List<Movie> get relatedMovies => _relatedMovies;
  //Searched Movies
  List<Movie> _searchedMovies = [];
  List<Movie> get searchedMovies => _searchedMovies;

  Future<void> fetchLatestMovies() async {
    String url =
        'https://yts.torrentbay.to/api/v2/list_movies.json?sort_by=year';
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
            coverImg: movie['medium_cover_image'],
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

  Future<void> fetchCatMovies(int pageNumber, String genre) async {
    String url;
    if (genre == 'All') {
      url =
          'https://yts.torrentbay.to/api/v2/list_movies.json?page=$pageNumber&limit=50';
    } else {
      url =
          'https://yts.torrentbay.to/api/v2/list_movies.json?page=$pageNumber&limit=50&genre=$genre';
    }

    var response = await http.get(Uri.parse(url));

    var data = json.decode(response.body);

    if (data['status'] == 'ok') {
      data['data']['movies'].forEach((movie) {
        _catMovies.add(
          Movie(
            id: movie['id'],
            title: movie['title'],
            year: movie['year'],
            coverImg: movie['medium_cover_image'],
            rating: movie['rating'],
          ),
        );
      });
      // _catMovies = _loadedMovies;
    } else {
      throw Exception('error');
    }
    notifyListeners();
  }

  void clearCatMovies() {
    _catMovies.clear();
    notifyListeners();
  }

  Future<void> fetchMovieDetails(int id) async {
    try {
      String url =
          'https://yts.torrentbay.to/api/v2/movie_details.json?movie_id=$id';

      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);
      if (data['status'] == 'ok') {
        var mov = data['data']['movie'];
        List<Torrent> _loadedTorrents = [];

        mov['torrents'].forEach((tor) {
          _loadedTorrents.add(
            Torrent(
              hash: tor['hash'],
              quality: tor['quality'],
              url: tor['url'],
              size: tor['size'],
              type: tor['type'],
              title: mov['title'],
            ),
          );
        });

        movieDetail = MovieDetail(
          bgImg: mov['background_image_original'],
          trailer: mov['yt_trailer_code'],
          title: mov['title'],
          rating: mov['rating'],
          runtime: mov['runtime'],
          img: mov['large_cover_image'],
          introDes: mov['description_intro'],
          fullDes: mov['description_full'],
          year: mov['year'],
          genres: mov['genres'],
          torrents: [..._loadedTorrents],
        );
        _loadedTorrents.clear();
      }
    } on FormatException {
      throw Exception('Server Error');
    } on SocketException {
      throw Exception('No Internet');
    }

    notifyListeners();
  }

  Future<void> fetchRelatedMovies(int id) async {
    String url =
        'https://yts.torrentbay.to/api/v2/movie_suggestions.json?movie_id=$id';
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
            coverImg: movie['medium_cover_image'],
            rating: movie['rating'],
          ),
        );
      });
      _relatedMovies = _loadedMovies;
    } else {
      throw Exception('error');
    }
    notifyListeners();
  }

  Future<void> searchMovie(String query) async {
    String url =
        'https://yts.torrentbay.to/api/v2/list_movies.json?query_term=$query&limit=50';
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
            coverImg: movie['medium_cover_image'],
            rating: movie['rating'],
          ),
        );
      });
      _searchedMovies = _loadedMovies;
    } else {
      throw Exception('error');
    }
    notifyListeners();
  }

  Future<void> clearRelatedMovies() async {
    _relatedMovies.clear();
    notifyListeners();
  }

  void clearMovieObj() {
    movieDetail = null;
    notifyListeners();
  }
}
