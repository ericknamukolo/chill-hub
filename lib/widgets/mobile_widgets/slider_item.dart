import 'package:chill_hub/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_style.dart';
import '../../models/movie.dart';

class SliderItem extends StatelessWidget {
  final Movie movie;
  const SliderItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String durationToString(int minutes) {
      var d = Duration(minutes: minutes);
      List<String> parts = d.toString().split(':');
      return '${parts[0].padLeft(2, '0')} hrs ${parts[1].padLeft(2, '0')} mins';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: kSecondaryColorDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              border: Border.all(
                color: kAccentColor,
                width: 1.5,
              ),
              image: DecorationImage(
                image: NetworkImage(movie.coverImg),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery.of(context).size.width * .3,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: kTitleTextStyle.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 5),
                Text(
                  movie.introDes,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: kMobileBodyTextStyleGrey,
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 10,
                  child: ListView.builder(
                      itemCount: movie.genres.length,
                      // movie.genres.length >= 2 ? 2 : movie.genres.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        bool isLast = i == movie.genres.length - 1;
                        return Text(
                          isLast ? movie.genres[i] : '${movie.genres[i]} | ',
                          style: kMobileBodyTextStyleWhite.copyWith(
                            color: kAccentColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '(${durationToString(int.parse(movie.runtime.toString()))})',
                      style: kBodyTextStyleWhite.copyWith(
                        color: kAccentColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${movie.rating}/10',
                      style: kBodyTextStyleWhite.copyWith(
                        color: kAccentColor,
                        fontSize: 10,
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
    );
  }
}
