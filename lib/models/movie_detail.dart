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
  });
}
