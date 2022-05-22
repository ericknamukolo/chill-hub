import '../models/movie_category.dart';
import '../providers/movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieCategories with ChangeNotifier {
  List<MovieCategory> categories = [
    MovieCategory(
      category: 'All',
      isSelected: true,
      imgUrl: 'assets/hd1.jpg',
    ),
    MovieCategory(
      category: 'Action',
      imgUrl: 'assets/action.jpg',
    ),
    MovieCategory(
      category: 'Adventure',
      imgUrl: 'assets/adventure.jpg',
    ),
    MovieCategory(
      category: 'Animation',
      imgUrl: 'assets/animation.jpg',
    ),
    MovieCategory(
      category: 'Drama',
      imgUrl: 'assets/drama.jpg',
    ),
    MovieCategory(
      category: 'Comedy',
      imgUrl: 'assets/comedy.jpg',
    ),
    MovieCategory(
      category: 'Romance',
      imgUrl: 'assets/romance.jpg',
    ),
    MovieCategory(
      category: 'Sci-Fi',
      imgUrl: 'assets/scifi.jpg',
    ),
    MovieCategory(
      category: 'Horror',
      imgUrl: 'assets/horror.jpg',
    ),
    MovieCategory(
      category: 'Thriller',
      imgUrl: 'assets/thriller.jpg',
    ),
  ];

  void selectCategory(MovieCategory cat, BuildContext context) {
    Provider.of<Movies>(context, listen: false).clearCatMovies();
    categories.forEach((element) {
      element.isSelected = false;
    });
    cat.isSelected = true;
    notifyListeners();
  }
}
