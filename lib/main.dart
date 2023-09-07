import 'package:cookipidia/data/authentication_service.dart';
import 'package:cookipidia/screens/login_screen.dart';
import 'package:cookipidia/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'cookipidia_theme.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';

import 'package:cookipidia/data/user_dao.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cookipidia/data/repository.dart';

import 'package:cookipidia/network/service_interface.dart';
import 'package:cookipidia/network/recipe_service.dart';

import 'package:cookipidia/data/moor/moor_repository.dart';
import 'package:cookipidia/data/message_dao.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final repository = MoorRepository();
  await repository.init();
  runApp(
    Cookipidia(
      repository: repository,
    ),
  );
}

class Cookipidia extends StatefulWidget {
  final Repository repository;

  const Cookipidia({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  State<Cookipidia> createState() => _CookipidiaState();
}

class _CookipidiaState extends State<Cookipidia> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();

  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider<UserDao>(
          lazy: false,
          create: (context) => UserDao(),
        ),
        Provider<MessageDao>(
          lazy: false,
          create: (context) => MessageDao(),
        ),
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        Provider<Repository>(
          lazy: false,
          create: (_) => widget.repository,
          dispose: (_, Repository repository) => repository.close(),
        ),
        Provider<ServiceInterface>(
          create: (_) => RecipeService.create(),
          lazy: false,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = CookipidiaTheme.dark();
          } else {
            theme = CookipidiaTheme.light();
          }

          return MaterialApp(
            theme: theme,
            title: 'My Cookery Master',
            home: Consumer<UserDao>(builder: (context, userDao, child) {
              if (userDao.isLoggedIn()) {
                return Router(
                  routerDelegate: _appRouter,
                  backButtonDispatcher: RootBackButtonDispatcher(),
                );
              } else {
                return LoginScreen();
              }
            }
                // child: Router(
                //   routerDelegate: _appRouter,
                //   backButtonDispatcher: RootBackButtonDispatcher(),
                // ),
                ),
          );
        },
      ),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     context.watch<User>()
//     return Container();
//   }
// }

// PAGE - 363
