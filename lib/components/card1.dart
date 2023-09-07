import 'package:cookipidia/cookipidia_theme.dart';
import 'package:cookipidia/main.dart';
import 'package:flutter/material.dart';
import 'package:cookipidia/cookipidia_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/explore_recipe.dart';
import 'package:url_launcher/url_launcher.dart';

class Card1 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card1({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  _launchURL() async {
    const url = 'https://youtu.be/c-oVDb-O2Q8';
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
          child: Stack(
            children: [
              Text(
                // recipe.subtitle,
                "Expert's Choice",
                style: CookipidiaTheme.darkTextTheme.bodyText1,
              ),
              Positioned(
                child: Text(
                  // recipe.title,
                  "Achaari Paneer",
                  style: CookipidiaTheme.darkTextTheme.headline2,
                ),
                top: 20,
              ),
              Positioned(
                child: Text(
                  // recipe.message,
                  "Learn to make the perfect tikka",
                  style: CookipidiaTheme.darkTextTheme.bodyText1,
                ),
                bottom: 2,
                right: 0,
              ),
              // Positioned(
              //   child: Text(
              //     // "Shubham Mahajan",
              //     style: CookipidiaTheme.darkTextTheme.bodyText1,
              //   ),
              //   bottom: 10,
              //   right: 0,
              // ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints.expand(
            width: 350,
            height: 450,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/food_pics/Achari_Paneer_Tikka_Recipe_Party_Food.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
