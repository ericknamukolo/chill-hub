class MovieCategory {
  String category;
  String imgUrl;
  bool isSelected;
  MovieCategory({
    required this.category,
    required this.imgUrl,
    this.isSelected = false,
  });
}
