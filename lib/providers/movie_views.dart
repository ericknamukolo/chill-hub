import 'package:chill_hub/providers/movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class MovieViews with ChangeNotifier {
  bool isMovieDetails = false;

  void toggleMovieDetails(bool status) {
    isMovieDetails = status;

    notifyListeners();
  }
}
