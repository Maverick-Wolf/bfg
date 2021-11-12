import 'package:bfg/screens/initialization/initialization.dart';
import 'package:bfg/screens/listings/add_book.dart';
import 'package:bfg/screens/listings/listings.dart';
import 'package:bfg/screens/listings/your_listings.dart';
import 'package:bfg/screens/login/enter_details.dart';
import 'package:bfg/screens/login/sign_up.dart';
import 'package:bfg/screens/initialization/logooo.dart';
import 'package:bfg/screens/user/profile.dart';
import 'package:bfg/screens/user/user_menu.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

void main() {

  OurTheme _theme = OurTheme();
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColorDark: _theme.primaryColor,
        primaryColor: _theme.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Initialization(),
        '/signUp': (context) => const SignUp(),
        '/addBook': (context) => const AddBook(),
        '/userMenu': (context) => UserMenu(),
        '/listings': (context) => Listings(),
        '/enterDetails': (context) => const Details(),
        '/Profile': (context) => const Profile(),
        '/yourListings': (context) => YourListings(),
      },
    ),
  );
}
