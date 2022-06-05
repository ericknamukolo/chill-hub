import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/providers/movie_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                              (i, category) =>
                                  CategoryCard(category: category, i: i),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      cat.categories.firstWhere((c) => c.isSelected).category ==
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
              builder: (context, mov, __) => GridView.builder(
                controller: ScrollController(),
                padding: const EdgeInsets.only(top: 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
