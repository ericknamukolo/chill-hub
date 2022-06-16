import 'package:chill_hub/providers/movie_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/mobile_widgets/mobile_category_card.dart';

class CategoriesNavScreen extends StatelessWidget {
  const CategoriesNavScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Consumer<MovieCategories>(
          builder: (context, mov, __) => Column(
            children: mov.categories
                .map(
                  (category) => MobileCategoryCard(category: category),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
