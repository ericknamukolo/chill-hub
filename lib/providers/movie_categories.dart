import 'package:chill_hub/models/movie_category.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieCategories with ChangeNotifier {
  List<MovieCategory> categories = [
    MovieCategory(category: 'All', isSelected: true),
    MovieCategory(category: 'Action'),
    MovieCategory(category: 'Adventure'),
    MovieCategory(category: 'Animation'),
    MovieCategory(category: 'Drama'),
    MovieCategory(category: 'Comedy'),
    MovieCategory(category: 'Romance'),
    MovieCategory(category: 'Sci-Fi'),
    MovieCategory(category: 'Horror'),
    MovieCategory(category: 'Thriller'),
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
