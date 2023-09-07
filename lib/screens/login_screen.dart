import 'package:cookipidia/models/cookipidia_pages.dart';
import 'package:cookipidia/screens/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

import 'package:cookipidia/data/user_dao.dart';

import 'package:cookipidia/data/user_dao.dart';

class LoginScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: CookipidiaPages.loginPath,
      key: ValueKey(CookipidiaPages.loginPath),
      child: const LoginScreen(),
    );
  }

  final String? username;

  const LoginScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
  final TextStyle focusedStyle = const TextStyle(color: Colors.green);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                child: Image(
                  image: AssetImage(
                    'assets/cookipidia_assets/al5.png',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildTextfieldEmail(widget.username ?? 'Email Address'),
              const SizedBox(height: 16),
              TextFormField(
                cursorColor: rwColor,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(height: 0.5),
                ),
                autofocus: false,
                obscureText: _isObscure,
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password Required';
                  }
                  return null;
                },
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 55,
                child: MaterialButton(
                  color: rwColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    userDao.login(
                      _emailController.text,
                      _passwordController.text,
                    );
                    Provider.of<AppStateManager>(context, listen: false)
                        .login('mockUsername', 'mockPassword');
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 55,
                child: MaterialButton(
                  color: rwColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    userDao.signup(
                      _emailController.text,
                      _passwordController.text,
                    );
                    Provider.of<AppStateManager>(context, listen: false)
                        .login('mockUsername', 'mockPassword');
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 115,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildSignUpButton(BuildContext context) {
  //   return SizedBox(
  //     height: 55,
  //     child: MaterialButton(
  //       color: rwColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //       child: const Text(
  //         'Sign Up',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       onPressed: () async {
  //         Provider.of<AppStateManager>(context, listen: false)
  //             .login('mockUsername', 'mockPassword');
  //       },
  //     ),
  //   );
  // }

  // Widget buildLoginButton(BuildContext context) {
  //   return SizedBox(
  //     height: 55,
  //     child: MaterialButton(
  //       color: rwColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //       child: const Text(
  //         'Login',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       onPressed: () async {
  //         userDao.login(
  //             _emailController.text, _passwordController.text);
  //         Provider.of<AppStateManager>(context, listen: false)
  //             .login('mockUsername', 'mockPassword');
  //       },
  //     ),
  //   );
  // }

  Widget buildTextfieldEmail(String hintText) {
    return TextFormField(
      cursorColor: rwColor,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Email Required';
        }
        return null;
      },
      controller: _emailController,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
    );
  }

  Widget buildTextfieldPassWord(String hintText) {
    bool _isObscure = true;
    return TextFormField(
      cursorColor: rwColor,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
      autofocus: false,
      obscureText: _isObscure,
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password Required';
        }
        return null;
      },
      controller: _passwordController,
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class User {
//   final String firstName;
//   final String lastName;
//   final String role;
//   final String profileImageUrl;
//   final int points;
//   final bool darkMode;
//
//   User({
//     required this.firstName,
//     required this.lastName,
//     required this.role,
//     required this.profileImageUrl,
//     required this.points,
//     required this.darkMode,
//   });
//
// // factory User.fromJson(Map<dynamic, dynamic> json) => User(
// //     text: json['text'] as String,
// //     date: DateTime.parse(json['date'] as String),
// //     email: json['email'] as String?);
// // Map<String, dynamic> toJson() => <String, dynamic>{
// //   'date': date.toString(),
// //   'text': text,
// //   'email': email,
// // };
// // factory Message.fromSnapshot(DocumentSnapshot snapshot) {
// //   final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);
// //   message.reference = snapshot.reference;
// //   return message;
// // }
// }
