import 'dart:async';

import 'package:cookipidia/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) {
          checkEmailVerified();
        },
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(
        Duration(seconds: 5),
      );
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Home(
          currentTab: 1,
        )
      : Scaffold(
          appBar: AppBar(
            title: Text('Verify Email'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A verification email has been sent to your email.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    canResendEmail ? sendVerificationEmail : null;
                  },
                  icon: Icon(
                    Icons.email,
                    size: 32,
                  ),
                  label: Text(
                    'Resent Email',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                ),
              ],
            ),
          ),
        );
}
