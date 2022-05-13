import 'package:chill_hub/models/movie_category.dart';
import 'package:flutter/foundation.dart';

class MovieCategories with ChangeNotifier {
  List<MovieCategory> categories = [
    MovieCategory(category: 'All', isSelected: true),
    MovieCategory(category: 'Action'),
    MovieCategory(category: 'Adventure'),
    MovieCategory(category: 'Animation'),
    MovieCategory(category: 'Comedy'),
    MovieCategory(category: 'Romance'),
    MovieCategory(category: 'Sci-Fi'),
    MovieCategory(category: 'Horror'),
  ];

  void selectCategory(MovieCategory cat) {
    categories.forEach((element) {
      element.isSelected = false;
    });
    cat.isSelected = true;
    notifyListeners();
  }
}
