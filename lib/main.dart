import 'package:bfg/screens/bfg/listings/add_book.dart';
import 'package:bfg/screens/bfg/listings/listings.dart';
import 'package:bfg/screens/bfg/listings/my_listings.dart';
import 'package:bfg/screens/bfg/listings/search_page.dart';
import 'package:bfg/screens/cabpools/listings/add_carpool.dart';
import 'package:bfg/screens/cabpools/listings/pool_listings.dart';
import 'package:bfg/screens/cabpools/listings/pool_search_page.dart';
import 'package:bfg/screens/cabpools/pool_home.dart';
import 'package:bfg/screens/initialization/initialization.dart';
import 'package:bfg/screens/initialization/start.dart';
import 'package:bfg/screens/login/enter_details.dart';
import 'package:bfg/screens/login/sign_up.dart';
import 'package:bfg/screens/main_home.dart';
import 'package:bfg/screens/user/feedback.dart';
import 'package:bfg/screens/user/profile.dart';
import 'package:bfg/screens/bfg/bfg_home.dart';
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
        '/userMenu': (context) => const MainHome(),
        '/listings': (context) => const Listings(),
        '/enterDetails': (context) => const Details(),
        '/Profile': (context) => const Profile(),
        '/myListings': (context) => const MyListings(),
        '/search': (context) => SearchPage(),
        '/feedbackPage': (context) => const FeedbackPage(),
        '/poolListings': (context) => const PoolListings(),
        '/carpoolSearch': (context) => PoolSearchPage(),
        '/addCarpool': (context) => const AddCarpool(),
      },
    ),
  );
}
