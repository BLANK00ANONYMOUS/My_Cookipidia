import 'package:cookipidia/models/recipe_list.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../api/mock_cookipidia_service.dart';
import '../components/components.dart';

class RecipesScreen extends StatelessWidget {
  final exploreService = MockCookipidiaService();

  RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeList();
  }
}
