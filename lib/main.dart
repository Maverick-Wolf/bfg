import 'package:bfg/delete_this_later.dart';
import 'package:bfg/providers/login_providers/login_provider.dart';
import 'package:bfg/screens/list_view/book_card.dart';
import 'package:bfg/screens/login/enter_details.dart';
import 'package:bfg/screens/login/login_page.dart';
import 'package:bfg/screens/login/sign_up.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  OurTheme _theme = OurTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider(),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColorDark: _theme.primaryColor,
          primaryColor: _theme.primaryColor
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const BookCard(),
          '/details': (context) => const LoginPage(),
          '/signUp': (context) => const SignUp(),
          '/enterDetails': (context) => const Details(),
        },
      ),
    ),
  );
}

