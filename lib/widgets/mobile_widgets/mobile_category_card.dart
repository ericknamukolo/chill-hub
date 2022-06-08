import 'package:chill_hub/models/movie_category.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';

class MobileCategoryCard extends StatelessWidget {
  final MovieCategory category;
  const MobileCategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSecondaryColorDark,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(category.imgUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.0), BlendMode.srcOver),
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: kSecondaryColorDark.withOpacity(.5),
        ),
        child: Text(
          category.category,
          style: kBodyTextStyleWhite.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
