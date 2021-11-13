import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  User? _user;
  String userName = "Name";
  String hostel = "Hostel";
  Future<void> _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    _user = _auth.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: _theme.primaryColor),
            child: Image.asset(
              "assets/images/college.png",
              width: MediaQuery.of(context).size.width,
            ),
          ),
          ListTile(
            title: FutureBuilder<DocumentSnapshot>(
                future: users.doc(_user!.uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return Text("Document does not exist");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        Text(
                          data['name'],
                          style: TextStyle(
                              fontFamily: _theme.font,
                              fontSize: 20,
                              color: _theme.secondaryColor),
                        ),
                        Text(
                          data['hostel'] + " - " + data['room_number'],
                          style: TextStyle(fontFamily: _theme.font),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontFamily: _theme.font,
                            fontSize: 20,
                            color: _theme.secondaryColor),
                      ),
                      Text(
                        "Hostel",
                        style: TextStyle(fontFamily: _theme.font),
                      ),
                    ],
                  );
                }),
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: _theme.secondaryColor,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                  fontFamily: _theme.font,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _theme.tertiaryColor),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/Profile');
            },
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
              title: Text(
                'My Listings',
                style: TextStyle(
                    fontFamily: _theme.font,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _theme.tertiaryColor),
              ),
              leading:
                  Icon(Icons.list_alt_rounded, color: _theme.secondaryColor),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/myListings');
                final snackBar = SnackBar(
                  content: Text(
                      "Tap and hold a listing for 2 seconds to delete it",
                      style: TextStyle(color: _theme.tertiaryColor)),
                  backgroundColor: Colors.blue,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.view_headline_outlined,
                color: _theme.secondaryColor),
            title: Text(
              'View Available Books',
              style: TextStyle(
                  fontFamily: _theme.font,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _theme.tertiaryColor),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/listings');
            },
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.bookmark_outline_sharp,
                color: _theme.secondaryColor),
            title: Text(
              'Sell a Book',
              style: TextStyle(
                  fontFamily: _theme.font,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _theme.tertiaryColor),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/addBook');
            },
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.logout, color: _theme.secondaryColor),
            title: Text(
              'Sign Out',
              style: TextStyle(
                  fontFamily: _theme.font,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _theme.tertiaryColor),
            ),
            onTap: () {
              _signOut();
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.pushNamed(context, '/signUp');
            },
          ),
          const Spacer(),
          Text(
            "Made by",
            style: TextStyle(
                fontFamily: _theme.font,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: _theme.tertiaryColor),
          ),
          Text(
            "Vardaan & Rachit",
            style: TextStyle(
                fontFamily: _theme.font,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: _theme.tertiaryColor),
          ),
          const SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
