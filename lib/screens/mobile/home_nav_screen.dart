import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/models/movie.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:chill_hub/widgets/desktop_widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../../widgets/mobile_widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Categories',
                  style: kBodyTitleTextStyle,
                ),
              ],
            ),
            Consumer<MovieCategories>(
              builder: (context, cat, __) => Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cat.categories
                        .mapIndexed(
                          (i, category) =>
                              CategoryCard(category: category, i: i),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
