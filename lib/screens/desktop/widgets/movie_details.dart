import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/providers/movie_views.dart';
import 'package:chill_hub/providers/movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  bool _showBar = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Movies>(
        builder: (context, mov, __) => Column(
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
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 350,
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kSecondaryColorDark,
                          image: mov.movieDetail == null
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(mov.movieDetail!.bgImg),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(.5),
                                      BlendMode.srcOver),
                                ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: SizedBox(
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
                            ),
                            Positioned(
                              top: 40,
                              right: 15,
                              child: Consumer<MovieViews>(
                                builder: (context, movie, __) =>
                                    GestureDetector(
                                  onTap: () {
                                    movie.toggleMovieDetails(false);
                                    mov.clearMovieObj();
                                    //
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(.4),
                                      ),
                                      child: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 50,
                              bottom: -50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  mov.movieDetail == null
                                      ? Shimmer.fromColors(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            width: 200,
                                            height: 280,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          baseColor: kBs,
                                          highlightColor: kPrimaryColorDark)
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: kAccentColor,
                                              width: 3.0,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  mov.movieDetail!.img),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          width: 200,
                                          height: 280,
                                        ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 8.0),
                                        child: mov.movieDetail == null
                                            ? Shimmer.fromColors(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 8.0),
                                                  height: 20,
                                                  width: 100,
                                                  color: Colors.grey,
                                                ),
                                                baseColor: kBs,
                                                highlightColor:
                                                    kPrimaryColorDark)
                                            : Text(
                                                mov.movieDetail!.title
                                                    .toUpperCase(),
                                                style: kTitleTextStyle.copyWith(
                                                    fontSize: 20),
                                              ),
                                      ),
                                      mov.movieDetail == null
                                          ? Shimmer.fromColors(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    height: 12,
                                                    width: 600,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    height: 12,
                                                    width: 500,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    height: 12,
                                                    width: 600,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    height: 12,
                                                    width: 200,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                              baseColor: kBs,
                                              highlightColor: kPrimaryColorDark)
                                          : Container(
                                              width: 600,
                                              margin: const EdgeInsets.only(
                                                  bottom: 5.0),
                                              child: Text(
                                                mov.movieDetail!.introDes,
                                                maxLines: 5,
                                                overflow: TextOverflow.fade,
                                                style: kBodyTextStyleWhite,
                                              ),
                                            ),
                                      mov.movieDetail == null
                                          ? Shimmer.fromColors(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10.0),
                                                height: 15,
                                                width: 100,
                                                color: Colors.grey,
                                              ),
                                              baseColor: kBs,
                                              highlightColor:
                                                  kSecondaryColorDark)
                                          : Row(
                                              children: [
                                                Row(
                                                  children: mov
                                                      .movieDetail!.genres
                                                      .map((gen) {
                                                    return Text(
                                                      '$gen | ',
                                                      style: kBodyTextStyleWhite
                                                          .copyWith(
                                                        color: kAccentColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                Text(
                                                  '  (${mov.movieDetail!.runtime} minutes)',
                                                  style: kBodyTextStyleWhite
                                                      .copyWith(
                                                    color: kAccentColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        mov.movieDetail?.year.toString() ?? '',
                                        style: kBodyTextStyleGrey.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
