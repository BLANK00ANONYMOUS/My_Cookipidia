import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/explore_recipe.dart';
import 'author_card.dart';
import '../cookipidia_theme.dart';

import 'package:url_launcher/url_launcher.dart';

class Card2 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card2({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  _launchURL() async {
    const url = 'https://youtu.be/iho_v5w26a4';
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
              image: AssetImage('assets/food_pics/Best-Mawa-Gujiya-500x500.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              AuthorCard(
                authorName: recipe.authorName,
                title: recipe.role,
                // imageProvider: AssetImage(recipe.profileImage),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 16,
                      right: 50,
                      child: Text(
                        // recipe.title,
                        "Gujiya",
                        style: CookipidiaTheme.darkTextTheme.headline1,
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 30,
                      child: Text(
                        // recipe.subtitle,
                        "Mawa",
                        style: CookipidiaTheme.darkTextTheme.headline1,
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