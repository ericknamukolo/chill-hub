import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/models/movie.dart';
import 'package:chill_hub/providers/movie_views.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  final bool isGrid;

  const MovieCard({
    Key? key,
    required this.movie,
    this.isGrid = false,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () async {
          Provider.of<MovieViews>(context, listen: false)
              .toggleMovieDetails(true);
          Provider.of<Movies>(context, listen: false)
              .fetchMovieDetails(widget.movie.id);
          await Provider.of<Movies>(context, listen: false)
              .clearRelatedMovies();
          Provider.of<Movies>(context, listen: false)
              .fetchRelatedMovies(widget.movie.id);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
          margin: EdgeInsets.only(right: widget.isGrid ? 0 : 20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: kSecondaryColorDark,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(widget.movie.coverImg),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.overlay,
              ),
            ),
          ),
          width: _isHovered ? 190 : 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kAccentColor.withOpacity(.5),
                    ),
                    child: Center(
                      child: Text(
                        widget.movie.rating.toString(),
                        style: kBodyTextStyleWhite.copyWith(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: kSecondaryColorDark.withOpacity(.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: kBodyTextStyleWhite,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.movie.year.toString(),
                      style: kBodyTextStyleGrey.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
