import 'package:bfg/providers/login_providers/login_provider.dart';
import 'package:bfg/screens/listings/add_book.dart';
import 'package:bfg/screens/listings/book_card.dart';
import 'package:bfg/screens/listings/listings.dart';
import 'package:bfg/screens/login/enter_details.dart';
import 'package:bfg/screens/login/login_page.dart';
import 'package:bfg/screens/login/sign_up.dart';
import 'package:bfg/screens/user/profile.dart';
import 'package:bfg/screens/user/user_menu.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  OurTheme _theme = OurTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColorDark: _theme.primaryColor,
          primaryColor: _theme.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const LoginPage(),
          '/signUp': (context) => const SignUp(),
          '/otpClass': (context) => const OtpClass(),
          '/addBook': (context) => const AddBook(),
          '/userMenu': (context) => const UserMenu(),
          '/listings': (context) => const Listings(),
          '/enterDetails': (context) => const Details(),
          '/bookCard': (context) => const BookCard(),
          '/Profile': (context) => const Profile(),
        },
      ),
    ),
  );
}
