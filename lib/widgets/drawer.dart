import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({Key? key}) : super(key: key);

  @override
  _DrawerClassState createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  OurTheme _theme = OurTheme();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: _theme.primaryColor),
          child: Image.asset("assets/images/college.png"),
        ),
        ListTile(
          title: Column(
            children: const [Text("Rachit Champu"), Text("AH 2 - 344")],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          onTap: () {
            Navigator.pushNamed(context, '/Profile');
          },
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
            title: const Text('Your Listings'),
            leading: const Icon(Icons.list_alt_rounded),
            onTap: () {}),
        const Divider(
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(Icons.view_headline_outlined),
          title: const Text('View Available Books'),
          onTap: () {
            Navigator.pushNamed(context, '/listings');
          },
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(Icons.bookmark_outline_sharp),
          title: const Text('Sell a Book'),
          onTap: () {
            Navigator.pushNamed(context, '/addBook');
          },
        ),
        const Divider(
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sign Out'),
          onTap: () {
            _signOut();
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    ));
  }
}
