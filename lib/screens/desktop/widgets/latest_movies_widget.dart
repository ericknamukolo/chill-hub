import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/screens/desktop/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LatestMoviesWidget extends StatelessWidget {
  const LatestMoviesWidget({
    Key? key,
    required bool isLoading,
  })  : _isLoading = isLoading,
        super(key: key);

  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<Movies>(
        builder: (context, movieData, __) => _isLoading
            ? ListView.builder(
                itemBuilder: (context, index) => Shimmer.fromColors(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 200,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  baseColor: kSecondaryColorDark,
                  highlightColor: kPrimaryColorDark,
                ),
                itemCount: 10,
                shrinkWrap: true,
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => MovieCard(
                  imgUrl: movieData.latestMovies[index].coverImg,
                  title: movieData.latestMovies[index].title,
                  year: movieData.latestMovies[index].year,
                  rating: movieData.latestMovies[index].rating,
                ),
                itemCount: movieData.latestMovies.length,
                shrinkWrap: true,
              ),
      ),
    );
  }
}