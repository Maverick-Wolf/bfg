import 'package:bfg/providers/login_providers/login_provider.dart';
import 'package:bfg/screens/initialization/initialization.dart';
import 'package:bfg/screens/listings/add_book.dart';
import 'package:bfg/screens/listings/book_card.dart';
import 'package:bfg/screens/listings/listings.dart';
import 'package:bfg/screens/login/enter_details.dart';
import 'package:bfg/screens/login/login_page.dart';
import 'package:bfg/screens/login/sign_up.dart';
import 'package:bfg/screens/user/profile.dart';
import 'package:bfg/screens/user/user_menu.dart';
import 'package:bfg/theme.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async{

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
          '/': (context) => const Initialization(),
          '/login': (context) => const LoginPage(),
          '/signUp': (context) => const SignUp(),
          '/addBook': (context) => const AddBook(),
          '/userMenu': (context) => UserMenu(),
          '/listings': (context) => const Listings(),
          '/enterDetails': (context) => const Details(),
          '/bookCard': (context) => const BookCard(),
          '/Profile': (context) => const Profile(),
        },
      ),
    ),
  );
}
