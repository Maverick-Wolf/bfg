import 'package:bfg/screens/initialization/initialization.dart';
import 'package:bfg/screens/listings/add_book.dart';
import 'package:bfg/screens/listings/listings.dart';
import 'package:bfg/screens/listings/my_listings.dart';
import 'package:bfg/screens/listings/search_page.dart';
import 'package:bfg/screens/login/enter_details.dart';
import 'package:bfg/screens/login/sign_up.dart';
import 'package:bfg/screens/initialization/start.dart';
import 'package:bfg/screens/user/feedback.dart';
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
        '/': (context) => const Start(),
        '/initialization': (context) => const Initialization(),
        '/signUp': (context) => const SignUp(),
        '/addBook': (context) => const AddBook(),
        '/userMenu': (context) => UserMenu(),
        '/listings': (context) => const Listings(),
        '/enterDetails': (context) => const Details(),
        '/Profile': (context) => const Profile(),
        '/myListings': (context) => const MyListings(),
        '/search': (context) => SearchPage(),
        '/feedbackPage':(context) => const FeedbackPage(),
      },
    ),
  );
}
