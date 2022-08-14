import 'package:chill_hub/constants/constants.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/widgets/mobile_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';
import '../../../widgets/mobile_widgets/mobile_movie_card.dart';

class SearchedMovieScreen extends StatefulWidget {
  final String query;
  const SearchedMovieScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchedMovieScreen> createState() => _SearchedMovieScreenState();
}

class _SearchedMovieScreenState extends State<SearchedMovieScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Movies>(context, listen: false)
          .searchMovie(widget.query);
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.e(_isLoading);
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: const CustomAppBar(title: 'Search', showClose: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                            MobileMovieCard(movie: mov.searchedMovies[index]),
                        itemCount: mov.searchedMovies.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
