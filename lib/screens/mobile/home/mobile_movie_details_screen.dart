import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/widgets/mobile_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../constants/constants.dart';
import '../../../models/movie.dart';
import '../../../widgets/mobile_widgets/movie_details_card.dart';

class MobileMovieDetails extends StatefulWidget {
  final Movie movie;
  const MobileMovieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MobileMovieDetails> createState() => _MobileMovieDetailsState();
}

class _MobileMovieDetailsState extends State<MobileMovieDetails> {
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
      // floatingActionButton: SizedBox(
      //   height: 50,
      //   width: 50,
      //   child: FloatingActionButton(
      //     backgroundColor: kAccentColor,
      //     onPressed: () async {},
      //     child: const GlowIcon(
      //       Icons.download_rounded,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      appBar: const CustomAppBar(
        title: 'Movie Details',
        showClose: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: widget.movie.id,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 340,
                      width: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.movie.coverImg),
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
                            content: widget.movie.genres.join(' | '),
                          ),
                          MovieDetailsCard(
                            title: 'Duration',
                            icon: Icons.timer_rounded,
                            content: '${widget.movie.runtime} Minutes',
                          ),
                          MovieDetailsCard(
                            title: 'Rating',
                            icon: Icons.star_rounded,
                            content: '${widget.movie.rating} / 10',
                          ),
                          MovieDetailsCard(
                            title: 'Trailer',
                            icon: MdiIcons.youtube,
                            content: widget.movie.trailer == ''
                                ? 'Not Available'
                                : 'Watch Trailer',
                            isAvailable: widget.movie.trailer != '',
                            click: () {
                              if (widget.movie.trailer != '') {
                                logger.i(widget.movie.trailer);
                                Links.goToLink(widget.movie.trailer);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // MovieDetailsCard(
              //   title: 'Watch NOW',
              //   icon: Icons.play_arrow_rounded,
              //   click: () async {},
              // ),
              // const SizedBox(height: 10),
              Text(
                '${widget.movie.title} (${widget.movie.year})',
                style: kBarTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              const Divider(
                thickness: 2.0,
                color: kSecondaryColorDark,
              ),
              const SizedBox(height: 5),
              Text(
                'Synopsis',
                style: kBarTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.movie.introDes,
                style: kMobileBodyTextStyleGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
