import 'package:flutter/material.dart';
import '../cookipidia_theme.dart';
import 'circle_image.dart';

class AuthorCard extends StatefulWidget {
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  const AuthorCard({
    Key? key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  }) : super(key: key);

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            children: [
              // CircleImage(
              //   imageProvider: widget.imageProvider,
              //   imageRadius: 25,
              // ),
              // const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prepare the best Gujiya",
                    style: CookipidiaTheme.darkTextTheme.headline3,
                  ),
                  Text(
                    // widget.title,
                    "Gujiya Champ",
                    style: CookipidiaTheme.darkTextTheme.bodyText1,
                  )
                ],
              ),
            ],
          ),
          // IconButton(
          //
          //     icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
          //     iconSize: 30,
          //     color: Colors.red[400],
          //
          //     onPressed: () {
          //       setState(() {
          //         _isFavorited = !_isFavorited;
          //       });
          //     }),
        ],
      ),
    );
  }
}
