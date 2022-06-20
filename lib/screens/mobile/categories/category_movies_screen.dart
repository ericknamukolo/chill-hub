import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/models/movie_category.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/widgets/mobile_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../constants/text_style.dart';

class CategoryMovieScreen extends StatefulWidget {
  final MovieCategory cat;
  const CategoryMovieScreen({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  State<CategoryMovieScreen> createState() => _CategoryMovieScreenState();
}

class _CategoryMovieScreenState extends State<CategoryMovieScreen> {
  int pageNumber = 1;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Movies>(context, listen: false)
          .fetchCatMovies(pageNumber, widget.cat.category);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: const CustomAppBar(title: 'Category', showClose: true),
      body: Column(
        children: [
          Hero(
            tag: widget.cat.category,
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.cat.imgUrl),
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
                    widget.cat.category,
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
