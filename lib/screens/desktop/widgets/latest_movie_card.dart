import 'package:chill_hub/constants/colors.dart';
import 'package:flutter/material.dart';

class LatestMovieCard extends StatelessWidget {
  final String imgUrl;
  const LatestMovieCard({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: kSecondaryColorDark,
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
      width: 400,
    );
  }
}
