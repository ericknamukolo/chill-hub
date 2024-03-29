import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../providers/movie_views.dart';
import '../../providers/movies.dart';
import 'movie_card.dart';

class MovieSearch extends StatefulWidget {
  final String? queryString;
  const MovieSearch({
    Key? key,
    this.queryString,
  }) : super(key: key);

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  bool _showBar = false;
  String genre = 'All';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _search = TextEditingController();
  String query = '';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      body: Column(
        children: [
          // AnimatedContainer(
          //   duration: const Duration(milliseconds: 500),
          //   color: kPrimaryColorDark,
          //   height: _showBar ? 25 : 0,
          //   width: double.infinity,
          //   child: Row(
          //     children: [
          //       Expanded(child: MoveWindow()),
          //       MinimizeWindowButton(
          //         colors: WindowButtonColors(
          //           iconNormal: Colors.white,
          //           mouseOver: kAccentColor,
          //         ),
          //       ),
          //       MaximizeWindowButton(
          //           colors: WindowButtonColors(
          //         iconNormal: Colors.white,
          //         mouseOver: kAccentColor,
          //       )),
          //       CloseWindowButton(
          //           colors: WindowButtonColors(
          //         iconNormal: Colors.white,
          //         mouseOver: Theme.of(context).errorColor,
          //       )),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Container(
              color: kPrimaryColorDark,
              // padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 300,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kSecondaryColorDark,
                        image: DecorationImage(
                          image: const AssetImage('assets/hd2.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(.5), BlendMode.srcOver),
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   height: 25,
                          //   width: double.infinity,
                          //   child: Row(
                          //     children: [
                          //       Expanded(child: MoveWindow()),
                          //       MinimizeWindowButton(
                          //         colors: WindowButtonColors(
                          //           iconNormal: Colors.white,
                          //           mouseOver: kAccentColor,
                          //         ),
                          //       ),
                          //       MaximizeWindowButton(
                          //           colors: WindowButtonColors(
                          //         iconNormal: Colors.white,
                          //         mouseOver: kAccentColor,
                          //       )),
                          //       CloseWindowButton(
                          //           colors: WindowButtonColors(
                          //         iconNormal: Colors.white,
                          //         mouseOver: Theme.of(context).errorColor,
                          //       )),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                SizedBox(
                                  width: 600,
                                  child: TextField(
                                    controller: _search,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: kBodyTextStyleWhite,
                                    cursorColor: kAccentColor,
                                    onChanged: (newVal) {
                                      setState(() {
                                        query = newVal;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                      filled: true,
                                      border: InputBorder.none,
                                      hintText: 'Search Movie',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            query = '';
                                            _search.clear();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: query.isNotEmpty || query != ''
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Consumer<MovieViews>(
                                  builder: (context, movie, __) =>
                                      GestureDetector(
                                    onTap: () {
                                      movie.toggleisSearch(false);

                                      Provider.of<Movies>(context,
                                              listen: false)
                                          .clearSearchedMovies();
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(.4),
                                        ),
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Consumer<Movies>(
                            builder: (context, movieData, __) => ElevatedButton(
                              onPressed: () async {
                                if (query.isNotEmpty) {
                                  movieData.clearSearchedMovies();
                                  await movieData.searchMovie(query);
                                  setState(() {
                                    query = '';
                                  });
                                }
                                _search.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kAccentColor.withOpacity(.3),
                                fixedSize: const Size(200, 40),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Search',
                                    style: kBodyTextStyleWhite,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Consumer<Movies>(
                        builder: (context, searchMovieData, __) => Text(
                          'Results for \'${searchMovieData.queryString}\' (${searchMovieData.searchedMovies.length})',
                          style: kBodyTextStyleGrey,
                        ),
                      ),
                    ),
                    Consumer<Movies>(builder: (context, searchMovieData, __) {
                      Widget _widget;

                      if (searchMovieData.searchLoading) {
                        _widget = GridView.builder(
                          controller: ScrollController(),
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 15, right: 15),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 6 / 7, //7 / 8,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 15.0,
                          ),
                          itemBuilder: (context, index) => Shimmer.fromColors(
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            baseColor: kSecondaryColorDark,
                            highlightColor: kPrimaryColorDark,
                          ),
                          itemCount: 20,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        );
                      } else {
                        if (searchMovieData.searchedMovies.isNotEmpty) {
                          _widget = GridView.builder(
                            controller: ScrollController(),
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 20, left: 50, right: 50),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              childAspectRatio: 6 / 8, //7 / 8,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                            ),
                            itemBuilder: (context, index) => MovieCard(
                              movie: searchMovieData.searchedMovies[index],
                              isGrid: true,
                            ),
                            itemCount: searchMovieData.searchedMovies.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          );
                        } else {
                          _widget = Center(
                            child: Text(
                              'No movies found for the query \'${searchMovieData.queryString}\'',
                              style: kBodyTextStyleGrey,
                            ),
                          );
                        }
                      }
                      return _widget;
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
