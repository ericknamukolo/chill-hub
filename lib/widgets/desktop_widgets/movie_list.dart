import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../providers/movie_categories.dart';
import '../../providers/movie_views.dart';
import '../../providers/movies.dart';
import 'latest_movies_widget.dart';
import 'movie_card.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int pageNumber = 1;
  bool _isLoading = false;
  bool _isCatLoading = false;
  bool _loadMore = false;
  bool _showBar = false;
  String genre = 'All';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _search = TextEditingController();
  String query = '';

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
        _isCatLoading = true;
      });

      await Provider.of<Movies>(context, listen: false).fetchLatestMovies();
      setState(() {
        _isLoading = false;
      });
      await Provider.of<Movies>(context, listen: false)
          .fetchCatMovies(pageNumber, genre);
      setState(() {
        _isCatLoading = false;
      });
    });
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= 300) {
        setState(() {
          _showBar = true;
        });
      } else {
        setState(() {
          _showBar = false;
        });
      }

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 400) {
        if (!_loadMore) {
          pageNumber = pageNumber + 1;
          setState(() {
            _loadMore = true;
          });

          await Provider.of<Movies>(context, listen: false)
              .fetchCatMovies(pageNumber, genre);

          setState(() {
            _loadMore = false;
          });
        }
      }
    });
  }

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
      floatingActionButton: _loadMore
          ? FloatingActionButton(
              elevation: 10.0,
              onPressed: () {},
              backgroundColor: kAccentColor,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3.0,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                          const Spacer(),
                          Consumer<Movies>(
                            builder: (context, movieData, __) => ElevatedButton(
                              onPressed: () async {
                                if (query.isNotEmpty) {
                                  Provider.of<MovieViews>(context,
                                          listen: false)
                                      .toggleisSearch(true);
                                  await movieData.searchMovie(query);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kAccentColor.withOpacity(.3),
                                fixedSize: const Size(200, 40),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                    Container(
                      //padding: const EdgeInsets.only(top: 20),
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      height: 320,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Latest movies',
                                      style: kTitleTextStyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                LatestMoviesWidget(isLoading: _isLoading),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Consumer<MovieCategories>(
                                builder: (context, catData, __) => Column(
                                  children: catData.categories
                                      .map(
                                        (category) => MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () async {
                                              catData.selectCategory(
                                                  category, context);
                                              pageNumber = 1;
                                              genre = category.category;
                                              setState(() {
                                                _isCatLoading = true;
                                              });
                                              await Provider.of<Movies>(context,
                                                      listen: false)
                                                  .fetchCatMovies(
                                                      pageNumber, genre);
                                              setState(() {
                                                _isCatLoading = false;
                                              });
                                            },
                                            child: Container(
                                              height: 80,
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                                bottom: 10,
                                              ),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      category.imgUrl),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black.withOpacity(
                                                          category.isSelected
                                                              ? 0.0
                                                              : .65),
                                                      BlendMode.srcOver),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                category.category,
                                                style: kBodyTextStyleWhite
                                                    .copyWith(
                                                  color: category.isSelected
                                                      ? kSecondaryColor
                                                      : Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Consumer<MovieCategories>(
                            builder: (context, cat, __) {
                              String activeCategory = cat.categories
                                  .firstWhere((element) => element.isSelected)
                                  .category;
                              return Text(
                                activeCategory == 'All'
                                    ? 'Movies'
                                    : activeCategory,
                                style: kTitleTextStyle,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Consumer<Movies>(
                      builder: (context, catMovieData, __) => _isCatLoading
                          ? GridView.builder(
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
                              itemBuilder: (context, index) =>
                                  Shimmer.fromColors(
                                baseColor: kSecondaryColorDark,
                                highlightColor: kPrimaryColorDark,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              itemCount: 20,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            )
                          : GridView.builder(
                              controller: ScrollController(),
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 20, left: 15, right: 15),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 6 / 8, //7 / 8,
                                crossAxisSpacing: 15.0,
                                mainAxisSpacing: 15.0,
                              ),
                              itemBuilder: (context, index) => MovieCard(
                                movie: catMovieData.catMovies[index],
                                isGrid: true,
                              ),
                              itemCount: catMovieData.catMovies.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                    )
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
