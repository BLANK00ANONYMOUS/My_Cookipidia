import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cookipidia_pages.dart';
import '../models/models.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: CookipidiaPages.splashPath,
      key: ValueKey(CookipidiaPages.splashPath),
      child: const SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(
      context,
      listen: false,
    ).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/cookipidia_assets/al5.png'),
            ),
            const Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
