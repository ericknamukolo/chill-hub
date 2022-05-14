import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final String imgUrl;
  final String title;
  final int year;
  final num rating;
  final bool isGrid;

  const MovieCard({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.year,
    required this.rating,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        margin: EdgeInsets.only(right: widget.isGrid ? 0 : 20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: kSecondaryColorDark,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(widget.imgUrl),
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
                      widget.rating.toString(),
                      style: kBodyTextStyleWhite.copyWith(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              widget.title,
              style: kBodyTextStyleWhite,
            ),
            const SizedBox(height: 5),
            Text(
              widget.year.toString(),
              style: kBodyTextStyleGrey.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
