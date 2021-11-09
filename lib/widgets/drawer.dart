import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: _theme.primaryColor),
              child: Image.asset("assets/images/college.png"),
            ),
            ListTile(
              title: FutureBuilder<DocumentSnapshot>(
                  future: users.doc(_user!.uid).get(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                    return Text("Something went wrong");
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                    return Text("Document does not exist");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data!
                          .data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          Text(
                            data['name'],
                            style: TextStyle(
                              fontFamily: _theme.font,
                              fontSize: 20,
                              color: _theme.secondaryColor
                            ),
                          ),
                          Text(
                            data['hostel'],
                            style: TextStyle(
                                fontFamily: _theme.font
                            ),
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
                              color: _theme.secondaryColor
                          ),
                        ),
                        Text(
                          "Hostel",
                          style: TextStyle(
                              fontFamily: _theme.font
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.person, color: _theme.secondaryColor,),
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
                leading: Icon(Icons.list_alt_rounded, color: _theme.secondaryColor),
                onTap: () {}),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.view_headline_outlined, color: _theme.secondaryColor),
              title: const Text('View Available Books'),
              onTap: () {
                Navigator.pushNamed(context, '/listings');
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.bookmark_outline_sharp, color: _theme.secondaryColor),
              title: const Text('Sell a Book'),
              onTap: () {
                Navigator.pushNamed(context, '/addBook');
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.logout, color: _theme.secondaryColor),
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
