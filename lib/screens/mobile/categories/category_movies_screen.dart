import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/models/movie_category.dart';
import 'package:chill_hub/widgets/mobile_widgets/cutsom_app_bar.dart';
import 'package:flutter/material.dart';

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
      appBar: CustomAppBar(title: cat.category, showClose: true),
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
            ),
          ),
        ],
      ),
    );
  }
}
