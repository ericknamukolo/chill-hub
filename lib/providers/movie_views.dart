import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MovieViews with ChangeNotifier {
  bool isMovieDetails = false;
  bool isSearch = false;

  void toggleMovieDetails(bool status) {
    isMovieDetails = status;
    notifyListeners();
  }

  void toggleisSearch(bool status) {
    isSearch = status;
    notifyListeners();
  }
}
