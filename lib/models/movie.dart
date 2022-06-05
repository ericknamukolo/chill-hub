import 'package:chill_hub/models/movie_detail.dart';

class Movie {
  int id;
  String title;
  int year;
  String coverImg;
  num rating;
  String trailer;
  List<Torrent> torrents;
  num runtime;
  List<dynamic> genres;
  String introDes;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.coverImg,
    required this.rating,
    required this.genres,
    required this.introDes,
    required this.runtime,
    required this.torrents,
    required this.trailer,
  });
}
