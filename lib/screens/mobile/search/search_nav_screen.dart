import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/screens/mobile/search/searched_movie_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchNavScreen extends StatelessWidget {
  const SearchNavScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: query,
            cursorColor: kAccentColor,
            style: kBodyTextStyleGrey,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: kSecondaryColorDark,
              hintText: 'Search movie..',
              hintStyle: kBodyTextStyleGrey,
              suffixIcon: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) =>
                          SearchedMovieScreen(query: query.text),
                    ),
                  );
                },
                icon: Icon(
                  Icons.search_rounded,
                  color: kBodyTextStyleGrey.color,
                  size: 20,
                ),
              ),
            ),
          ),
          const Text(
            'Search for any movie you\'d like to download',
            style: kBodyTextStyleGrey,
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
