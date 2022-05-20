class MovieDetail {
  String title;
  num year;
  num rating;
  num runtime;
  List<dynamic> genres;
  String introDes;
  String fullDes;
  String bgImg;
  String img;
  String trailer;
  List<Torrent> torrents;

  MovieDetail({
    required this.bgImg,
    required this.trailer,
    required this.title,
    required this.rating,
    required this.runtime,
    required this.img,
    required this.introDes,
    required this.fullDes,
    required this.year,
    required this.genres,
    required this.torrents,
  });
}

class Torrent {
  String hash;
  String url;
  String quality;
  String type;
  String size;
  String title;
  int seeds;
  int peers;

  Torrent({
    required this.hash,
    required this.quality,
    required this.url,
    required this.size,
    required this.type,
    required this.title,
    required this.seeds,
    required this.peers,
  });
}
