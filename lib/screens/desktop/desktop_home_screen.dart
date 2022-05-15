import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/providers/menu_buttons.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:chill_hub/screens/desktop/widgets/latest_movies_widget.dart';
import 'package:chill_hub/screens/desktop/widgets/menu_btn_widget.dart';
import 'package:chill_hub/widgets/footer_info.dart';
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
  bool _showBar = false;
  String genre = 'All';
  final ScrollController _scrollController = ScrollController();
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: kSecondaryColorDark,
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.filmstrip,
                          color: kBodyTextStyleGrey.color,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Chill Hub',
                          style: kBodyTextStyleGrey.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'MENU',
                      style: kBodyTextStyleGrey.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Consumer<MenuButtons>(
                    builder: (context, btnData, __) => Column(
                      children: btnData.buttonsData
                          .map(
                            (btn) => MenuBtnWidget(
                              btn: btn,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'LIBRARY',
                      style: kBodyTextStyleGrey.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Consumer<MenuButtons>(
                    builder: (context, btnData, __) => Column(
                      children: btnData.libButtonsData
                          .map(
                            (btn) => MenuBtnWidget(
                              btn: btn,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'GENERAL',
                      style: kBodyTextStyleGrey.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Consumer<MenuButtons>(
                    builder: (context, btnData, __) => Column(
                      children: btnData.genButtonsData
                          .map(
                            (btn) => MenuBtnWidget(
                              btn: btn,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Spacer(),
                  const FooterInfo(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: kPrimaryColorDark,
                  height: _showBar ? 25 : 0,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(child: MoveWindow()),
                      MinimizeWindowButton(
                        colors: WindowButtonColors(
                          iconNormal: Colors.white,
                          mouseOver: kAccentColor,
                        ),
                      ),
                      MaximizeWindowButton(
                          colors: WindowButtonColors(
                        iconNormal: Colors.white,
                        mouseOver: kAccentColor,
                      )),
                      CloseWindowButton(
                          colors: WindowButtonColors(
                        iconNormal: Colors.white,
                        mouseOver: Theme.of(context).errorColor,
                      )),
                    ],
                  ),
                ),
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
                                    Colors.black.withOpacity(.5),
                                    BlendMode.srcOver),
                              ),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(child: MoveWindow()),
                                      MinimizeWindowButton(
                                        colors: WindowButtonColors(
                                          iconNormal: Colors.white,
                                          mouseOver: kAccentColor,
                                        ),
                                      ),
                                      MaximizeWindowButton(
                                          colors: WindowButtonColors(
                                        iconNormal: Colors.white,
                                        mouseOver: kAccentColor,
                                      )),
                                      CloseWindowButton(
                                          colors: WindowButtonColors(
                                        iconNormal: Colors.white,
                                        mouseOver: Theme.of(context).errorColor,
                                      )),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const SizedBox(
                                  width: 600,
                                  child: TextField(
                                    style: kBodyTextStyleWhite,
                                    cursorColor: kAccentColor,
                                    decoration: InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      hintText: 'Search Movie',
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(),
                              ],
                            ),
                          ),
                          Container(
                            //padding: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            height: 320,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
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
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Consumer<MovieCategories>(
                                      builder: (context, catData, __) => Column(
                                        children: catData.categories
                                            .map(
                                              (category) => MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    catData.selectCategory(
                                                        category, context);
                                                    pageNumber = 1;
                                                    genre = category.category;
                                                    setState(() {
                                                      _isCatLoading = true;
                                                    });
                                                    await Provider.of<Movies>(
                                                            context,
                                                            listen: false)
                                                        .fetchCatMovies(
                                                            pageNumber, genre);
                                                    setState(() {
                                                      _isCatLoading = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 80,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                      bottom: 10,
                                                    ),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            category.imgUrl),
                                                        fit: BoxFit.cover,
                                                        colorFilter: ColorFilter.mode(
                                                            Colors.black
                                                                .withOpacity(
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
                                                        color: category
                                                                .isSelected
                                                            ? kSecondaryColor
                                                            : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                              children: [
                                Consumer<MovieCategories>(
                                  builder: (context, cat, __) {
                                    String activeCategory = cat.categories
                                        .firstWhere(
                                            (element) => element.isSelected)
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
                          ),
                          Consumer<Movies>(
                            builder: (context, catMovieData, __) =>
                                _isCatLoading
                                    ? GridView.builder(
                                        controller: ScrollController(),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 20,
                                            left: 15,
                                            right: 15),
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
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          baseColor: kSecondaryColorDark,
                                          highlightColor: kPrimaryColorDark,
                                        ),
                                        itemCount: 20,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      )
                                    : GridView.builder(
                                        controller: ScrollController(),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 20,
                                            left: 15,
                                            right: 15),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          childAspectRatio: 6 / 7, //7 / 8,
                                          crossAxisSpacing: 15.0,
                                          mainAxisSpacing: 15.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            MovieCard(
                                          imgUrl: catMovieData
                                              .catMovies[index].coverImg,
                                          title: catMovieData
                                              .catMovies[index].title,
                                          year: catMovieData
                                              .catMovies[index].year,
                                          rating: catMovieData
                                              .catMovies[index].rating,
                                          isGrid: true,
                                        ),
                                        itemCount:
                                            catMovieData.catMovies.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
