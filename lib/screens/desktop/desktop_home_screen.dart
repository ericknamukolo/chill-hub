import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/screens/desktop/widgets/latest_movies_widget.dart';
import 'package:chill_hub/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/movie_card.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  int pageNumber = 1;
  bool _isLoading = false;
  bool _isCatLoading = false;
  bool _loadMore = false;
  String genre = 'All';
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      setState(() {
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
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: kSecondaryColorDark,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: const [
                  Logo(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: kPrimaryColorDark,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      height: 360,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                TextField(
                                  style: kBodyTextStyleWhite,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor:
                                        kSecondaryColorDark.withOpacity(.5),
                                    hintText: 'Search Movie',
                                    hintStyle: kBodyTextStyleGrey,
                                    hoverColor:
                                        kSecondaryColorDark.withOpacity(.08),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: kAccentColor,
                                      // size: 25,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Text(
                                      'Latest movies',
                                      style: kTitleTextStyle,
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'See all',
                                      style: kBodyTextStyleGrey,
                                    ),
                                    Icon(
                                      MdiIcons.chevronRight,
                                      color: kBodyTextStyleGrey.color,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                LatestMoviesWidget(isLoading: _isLoading),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Designed & Built By',
                                  style: GoogleFonts.dosis(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () async {
                                    await launch(
                                        'https://ericknamukolo.github.io/');
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      'Erick Namukolo',
                                      style: GoogleFonts.dosis(
                                        fontSize: 22,
                                        color: kAccentColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 25),
                                      child: Consumer<MovieCategories>(
                                        builder: (context, catData, __) =>
                                            Column(
                                          children: catData.categories
                                              .map(
                                                (category) => MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      catData.selectCategory(
                                                          category);
                                                      pageNumber = 1;
                                                      genre = category.category;
                                                      setState(() {
                                                        _isCatLoading = true;
                                                      });
                                                      await Provider.of<Movies>(
                                                              context,
                                                              listen: false)
                                                          .fetchCatMovies(
                                                              pageNumber,
                                                              genre);
                                                      setState(() {
                                                        _isCatLoading = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: category
                                                                .isSelected
                                                            ? kAccentColor
                                                            : kSecondaryColorDark,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        category.category,
                                                        style:
                                                            kBodyTextStyleWhite,
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
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
                        const Spacer(),
                        const Text(
                          'See all',
                          style: kBodyTextStyleGrey,
                        ),
                        Icon(
                          MdiIcons.chevronRight,
                          color: kBodyTextStyleGrey.color,
                        )
                      ],
                    ),
                    Consumer<Movies>(
                      builder: (context, catMovieData, __) => _isCatLoading
                          ? GridView.builder(
                              controller: ScrollController(),
                              padding: const EdgeInsets.only(top: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 6 / 7, //7 / 8,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 15.0,
                              ),
                              itemBuilder: (context, index) =>
                                  Shimmer.fromColors(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                baseColor: kSecondaryColorDark,
                                highlightColor: kPrimaryColorDark,
                              ),
                              itemCount: 20,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            )
                          : GridView.builder(
                              controller: ScrollController(),
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 6 / 7, //7 / 8,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 15.0,
                              ),
                              itemBuilder: (context, index) => MovieCard(
                                imgUrl: catMovieData.catMovies[index].coverImg,
                                title: catMovieData.catMovies[index].title,
                                year: catMovieData.catMovies[index].year,
                                rating: catMovieData.catMovies[index].rating,
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
