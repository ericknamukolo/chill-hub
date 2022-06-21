import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/models/movie_category.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/widgets/mobile_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/constants.dart';
import '../../../constants/text_style.dart';
import '../../../widgets/mobile_widgets/mobile_movie_card.dart';

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
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Movies>(context, listen: false).clearCatMovies();
      await Provider.of<Movies>(context, listen: false)
          .fetchCatMovies(pageNumber, widget.cat.category);
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: const CustomAppBar(title: 'Category', showClose: true),
      body: SingleChildScrollView(
        child: Column(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            Consumer<Movies>(
              builder: (context, mov, __) => _isLoading
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: GridView.builder(
                        controller: ScrollController(),
                        padding: const EdgeInsets.only(top: 0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                        ),
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          child: Container(
                            // margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          baseColor: kSecondaryColorDark,
                          highlightColor: kPrimaryColorDark,
                        ),
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: GridView.builder(
                        controller: ScrollController(),
                        padding: const EdgeInsets.only(top: 0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                        ),
                        itemBuilder: (context, index) =>
                            MobileMovieCard(movie: mov.catMovies[index]),
                        itemCount: mov.catMovies.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
