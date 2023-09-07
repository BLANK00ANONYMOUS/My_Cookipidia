import 'package:flutter/material.dart';
import '../cookipidia_theme.dart';
import '../models/explore_recipe.dart';

import 'package:url_launcher/url_launcher_string.dart';

class Card3 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card3({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  // List<Widget> createTagChips() {
  //   final chips = <Widget>[];
  //   recipe.tags.take(6).forEach((element) {
  //     final chip = Chip(
  //       label: Text(
  //         element,
  //         style: CookipidiaTheme.darkTextTheme.bodyText1,
  //       ),
  //       // backgroundColor: Colors.black.withOpacity(0.7),
  //     );
  //     chips.add(chip);
  //   });
  //
  //   return chips;
  // }
  _launchURL() async {
    const url = 'https://youtu.be/dOiwccflDkY';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _launchURL,
        child: Container(
          constraints: const BoxConstraints.expand(
            width: 350,
            height: 450,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/food_pics/Dal-Makhani-New-3.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.6),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(5, 50, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Icon(
                    //   Icons.book,
                    //   color: Colors.white,
                    //   size: 40,
                    // ),
                    // const SizedBox(height: 8),
                    Text(
                      // recipe.title,
                      "Make the Perfect Dal Makhani",
                      // style: CookipidiaTheme.darkTextTheme.bodyText1,
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              // Center(
              //   child: Wrap(
              //     alignment: WrapAlignment.start,
              //     spacing: 12,
              //     runSpacing: 12,
              //     children: createTagChips(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
