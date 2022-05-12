import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/latest_movie_card.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Movies>(context, listen: false).fetchLatestMovies();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: kSecondaryColorDark,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: kPrimaryColorDark,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                children: [
                  SizedBox(
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
                              Expanded(
                                child: Consumer<Movies>(
                                  builder: (context, movieData, __) =>
                                      _isLoading
                                          ? ListView.builder(
                                              itemBuilder: (context, index) =>
                                                  Shimmer.fromColors(
                                                child: Container(
                                                  width: 200,
                                                ),
                                                baseColor: kSecondaryColorDark,
                                                highlightColor:
                                                    kPrimaryColorDark,
                                              ),
                                              itemCount: 10,
                                              shrinkWrap: true,
                                            )
                                          : ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  LatestMovieCard(
                                                imgUrl: movieData
                                                    .latestMovies[index]
                                                    .coverImg,
                                                title: movieData
                                                    .latestMovies[index].title,
                                                year: movieData
                                                    .latestMovies[index].year,
                                                rating: movieData
                                                    .latestMovies[index].rating,
                                              ),
                                              itemCount:
                                                  movieData.latestMovies.length,
                                              shrinkWrap: true,
                                            ),
                                ),
                              ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
