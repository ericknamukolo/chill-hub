import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../models/movie.dart';

class MobileMovieCard extends StatelessWidget {
  final Movie movie;
  const MobileMovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: kSecondaryColorDark,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(movie.coverImg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kAccentColor.withOpacity(.5),
                ),
                child: Center(
                  child: Text(
                    movie.rating.toString(),
                    style: kBodyTextStyleWhite.copyWith(fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: kSecondaryColorDark.withOpacity(.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: kMobileBodyTextStyleWhite,
                ),
                const SizedBox(height: 5),
                Text(
                  movie.year.toString(),
                  style: kMobileBodyTextStyleGrey.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
