import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/widgets/desktop_widgets/movie_card.dart';
import 'package:chill_hub/widgets/mobile_widgets/cutsom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../models/movie.dart';

class MobileMovieDetails extends StatelessWidget {
  final Movie movie;
  const MobileMovieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: CustomAppBar(
        title: 'Movie Details',
        icon: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: movie.id,
            child: Container(
              height: 500,
              width: 250,
              child: Image.network(movie.coverImg),
            ),
          ),
        ],
      ),
    );
  }
}
