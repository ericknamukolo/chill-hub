import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/screens/mobile/trailer_player_screen.dart';
import 'package:chill_hub/widgets/desktop_widgets/movie_card.dart';
import 'package:chill_hub/widgets/mobile_widgets/cutsom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../models/movie.dart';
import '../../widgets/mobile_widgets/movie_details_card.dart';

class MobileMovieDetails extends StatelessWidget {
  final Movie movie;
  const MobileMovieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      appBar: CustomAppBar(
        title: 'Movie Details',
        icon: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: movie.id,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 340,
                    width: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(movie.coverImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 340,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MovieDetailsCard(
                          title: 'Genre',
                          icon: Icons.movie_creation_rounded,
                          content: movie.genres.join(' | '),
                        ),
                        MovieDetailsCard(
                          title: 'Duration',
                          icon: Icons.timer_rounded,
                          content: '${movie.runtime} Minutes',
                        ),
                        MovieDetailsCard(
                          title: 'Rating',
                          icon: Icons.star_rounded,
                          content: '${movie.rating} / 10',
                        ),
                        MovieDetailsCard(
                          title: 'Trailer',
                          icon: MdiIcons.youtube,
                          content: movie.trailer == ''
                              ? 'Not Available'
                              : 'Available',
                          click: () {
                            if (movie.trailer != '') {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      TrailerPlayerScreen(movie: movie),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
