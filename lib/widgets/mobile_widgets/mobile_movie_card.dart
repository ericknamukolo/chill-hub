import 'package:chill_hub/constants/constants.dart';
import 'package:chill_hub/screens/mobile/home/mobile_movie_details_screen.dart';
import 'package:chill_hub/services/ad_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../models/movie.dart';

class MobileMovieCard extends StatelessWidget {
  final Movie movie;
  const MobileMovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AdManager.loadInterstitialAd(onLoaded: (ad) async {
        //   InterstitialAd loadedAd = ad;
        //   await loadedAd.show();
        // }, onAdFailedToLoad: (ad) {
        //   logger.i('failed $ad');
        // });
        // AdManager.loadInterstitialVidAd(
        //   onLoaded: (ad) async {
        //     InterstitialAd loadedAd = ad;
        //   },
        //   onAdFailedToLoad: (ad) {},
        // );
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => MobileMovieDetails(movie: movie),
          ),
        );
      },
      child: Hero(
        tag: movie.id,
        key: Key(movie.id.toString()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color: kSecondaryColorDark,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(movie.coverImg),
              fit: BoxFit.cover,
            ),
          ),
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
                      child: DefaultTextStyle(
                        style: kMobileBodyTextStyleWhite.copyWith(
                          fontFamily: 'VarelaRound',
                          fontSize: 10,
                        ),
                        child: Text(
                          movie.rating.toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: kSecondaryColorDark.withOpacity(.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: kMobileBodyTextStyleWhite.copyWith(
                        fontFamily: 'VarelaRound',
                      ),
                      child: Text(
                        movie.title,
                      ),
                    ),
                    const SizedBox(height: 5),
                    DefaultTextStyle(
                      style: kMobileBodyTextStyleGrey.copyWith(
                        fontFamily: 'VarelaRound',
                      ),
                      child: Text(
                        movie.year.toString(),
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
