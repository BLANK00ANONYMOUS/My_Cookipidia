import 'package:cookipidia/models/cookipidia_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'color_constants.dart';
import 'package:cookipidia/data/user_dao.dart';

import 'package:cookipidia/data/user_dao.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future resetPassword() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset email was sent'),
          ),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ,
        elevation: 0,
        title: Text(
          'Reset Password',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Receive an email to\nreset your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email == null ? 'Enter a valid email' : null,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: resetPassword,
                icon: Icon(
                  Icons.email_outlined,
                ),
                label: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
