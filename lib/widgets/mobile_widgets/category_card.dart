import 'package:chill_hub/models/movie_category.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';

class CategoryCard extends StatelessWidget {
  final MovieCategory category;
  final int i;
  final Function() click;
  const CategoryCard({
    Key? key,
    required this.category,
    required this.i,
    required this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        margin: EdgeInsets.only(right: i != 9 ? 10 : 0),
        decoration: BoxDecoration(
          color: category.isSelected ? kAccentColor : kSecondaryColorDark,
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Text(category.category,
            style:
                category.isSelected ? kBodyTextStyleWhite : kBodyTextStyleGrey),
      ),
    );
  }
}
