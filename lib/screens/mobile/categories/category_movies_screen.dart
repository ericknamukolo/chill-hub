import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/models/movie_category.dart';
import 'package:chill_hub/widgets/mobile_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../constants/text_style.dart';

class CategoryMovieScreen extends StatelessWidget {
  final MovieCategory cat;
  const CategoryMovieScreen({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: const CustomAppBar(title: 'Category', showClose: true),
      body: Column(
        children: [
          Hero(
            tag: cat.category,
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(cat.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: kSecondaryColorDark.withOpacity(.5),
                ),
                child: DefaultTextStyle(
                  style: kBodyTextStyleWhite.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontFamily: 'VarelaRound',
                  ),
                  child: Text(
                    cat.category,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
