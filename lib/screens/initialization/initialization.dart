import 'package:bfg/screens/login/login_page.dart';
import 'package:bfg/screens/user/user_menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Initialization extends StatelessWidget {
  const Initialization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    User? _user;
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final FirebaseAuth _auth = FirebaseAuth.instance;
              _user = _auth.currentUser;
              if (_user != null) {
                return UserMenu();
              } else {
                return const LoginPage();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
