import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/screens/desktop/widgets/latest_movies_widget.dart';
import 'package:chill_hub/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
      //  await Provider.of<Movies>(context, listen: false).fetchLatestMovies();
      setState(() {
        _isLoading = false;
      });
      await Provider.of<Movies>(context, listen: false)
          .fetchCatMovies(pageNumber);
      setState(() {
        _isCatLoading = false;
      });
    });
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        pageNumber = pageNumber + 1;
        _scrollController.jumpTo(
          300,
          //  duration: const Duration(milliseconds: 500),
          //  curve: Curves.ease,
        );
        setState(() {
          _isCatLoading = true;
        });
        await Provider.of<Movies>(context, listen: false)
            .fetchCatMovies(pageNumber);
        setState(() {
          _isCatLoading = false;
        });
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: kSecondaryColorDark,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Movies',
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
