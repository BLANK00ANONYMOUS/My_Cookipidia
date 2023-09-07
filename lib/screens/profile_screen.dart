import 'dart:io';

import 'package:cookipidia/models/cookipidia_pages.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/circle_image.dart';
import '../models/models.dart';

import 'package:cookipidia/data/user_dao.dart';

import 'package:firebase_auth/firebase_auth.dart' as authFire;

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  static MaterialPage page(User user) {
    return MaterialPage(
      name: CookipidiaPages.profilePath,
      key: ValueKey(CookipidiaPages.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  final User user;

  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Future<void> _getUserName() async {
  //   var tempMail = authFire.FirebaseAuth.instance.currentUser?.email;
  //   setState(() {
  //     userEmail = tempMail;
  //     showSpinner = false;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _getUserName();
  // }

  String? userEmail;

  // Future<String?> getUserEmail() async {
  //   final currUser = await authFire.FirebaseAuth.instance.currentUser;
  //   final userMail = currUser?.email;
  //   return userMail;
  // }
  // bool showSpinner = true;
  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: false);
    // email = userDao.email();

    Future<String?> getUserMail() async {
      final userMail = userDao.email();
      return userMail;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            Column(
              children: [
                InkWell(
                  onTap: pickImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 70,
                    child: CircleAvatar(
                      radius: 70,
                      child: image == null
                          ? FlutterLogo(
                              size: 70,
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 70,
                            ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                FutureBuilder(
                  future: getUserMail(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} has occured',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final data = snapshot.data as String;
                        return Center(
                          child: Text(
                            data,
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Text(
                  'Social Chef',
                ),
                Text(
                  '${widget.user.points} points',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  buildDarkModeRow(),
                  ListTile(
                    title: const Text('View help site'),
                    onTap: () async {
                      await launch('https://www.epicurious.com/');
                      // if (kIsWeb) {
                      //   await launch('https://www.epicurious.com/');
                      // } else {
                      //   Provider.of<ProfileManager>(context, listen: false)
                      //       .tapOnRaywenderlich(true);
                      // }
                    },
                  ),
                  ListTile(
                    title: const Text('Log out'),
                    onTap: () {
                      userDao.logout();
                      Provider.of<ProfileManager>(context, listen: false)
                          .tapOnProfile(false);
                      Provider.of<AppStateManager>(context, listen: false)
                          .logout();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Switch(
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<ProfileManager>(context, listen: false).darkMode =
                  value;
            },
          )
        ],
      ),
    );
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick the image: $e');
    }
  }
}
