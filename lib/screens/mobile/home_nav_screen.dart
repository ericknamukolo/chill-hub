import 'package:carousel_slider/carousel_slider.dart';
import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/models/movie.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:shimmer/shimmer.dart';
import '../../providers/movies.dart';
import '../../widgets/mobile_widgets/category_card.dart';
import '../../widgets/mobile_widgets/mobile_movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageNumber = 1;
  String genre = 'All';
  bool _loadMore = false;
  bool _isLoading = false;

  //bool _isCatLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
        // _isCatLoading = true;
      });

      // await Provider.of<Movies>(context, listen: false).fetchLatestMovies();
      // setState(() {
      //   _isLoading = false;
      // });
      await Provider.of<Movies>(context, listen: false)
          .fetchCatMovies(pageNumber, genre);
      setState(() {
        _isLoading = false;
        // _isCatLoading = true;
      });
      // setState(() {
      //   _isCatLoading = false;
      // });
    });
    super.initState();
    _scrollController.addListener(() async {
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
      backgroundColor: kPrimaryColorDark,
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: () {
            if (!_loadMore) {
              _scrollController.animateTo(
                0.0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              );
            }
          },
          backgroundColor: kAccentColor,
          child: _loadMore
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.white,
                  ),
                )
              : const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: Colors.white,
                ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: cat.categories
                              .mapIndexed(
                                (i, category) => CategoryCard(
                                  category: category,
                                  i: i,
                                  click: () async {
                                    cat.selectCategory(category, context);
                                    pageNumber = 1;
                                    genre = category.category;
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await Provider.of<Movies>(context,
                                            listen: false)
                                        .fetchCatMovies(pageNumber, genre);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cat.categories
                                    .firstWhere((c) => c.isSelected)
                                    .category ==
                                'All'
                            ? 'Movies'
                            : cat.categories
                                .firstWhere((c) => c.isSelected)
                                .category,
                        style: kBodyTitleTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<Movies>(
                builder: (context, mov, __) => _isLoading
                    ? GridView.builder(
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
                      )
                    : GridView.builder(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
