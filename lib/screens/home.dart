import 'package:cookipidia/screens/my_recipes_list.dart';
import 'package:cookipidia/screens/shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/cookipidia_pages.dart';
import '../models/models.dart';
import 'explore_screen.dart';
import 'grocery_screen.dart';
import 'recipes_screen.dart';

class Home extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: CookipidiaPages.home,
      key: ValueKey(CookipidiaPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
    MyRecipesList(),
    ShoppingList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Cookery Master',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              profileButton(),
            ],
          ),
          body: IndexedStack(
            index: widget.currentTab,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: widget.currentTab,
            onTap: (index) {
              Provider.of<AppStateManager>(context, listen: false)
                  .goToTab(index);
            },
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore_outlined,
                  color: Colors.cyan,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.food_bank_outlined,
                  color: Colors.cyan,
                ),
                label: 'Recipes',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_outlined,
                  color: Colors.cyan,
                ),
                label: 'To Buy',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmarks,
                  color: Colors.cyan,
                ),
                label: 'BookMarks',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.file_copy_outlined,
                  color: Colors.cyan,
                ),
                label: 'Groceries',
              ),
            ],
          ),
        );
      },
    );
  }

  // Provider.of<ProfileManager>(context, listen: false)
  //     .tapOnProfile(true);

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: IconButton(
        onPressed: () {
          Provider.of<ProfileManager>(context, listen: false)
              .tapOnProfile(true);
        },
        icon: Icon(Icons.person),
      ),
    );
  }
}
