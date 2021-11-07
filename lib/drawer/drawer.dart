import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({Key? key}) : super(key: key);

  @override
  _DrawerClassState createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {

  OurTheme _theme = OurTheme();

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
                children: [
                  Text("Rachit Champu"),
                  Text("AH 2 - 344")
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {

              },
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
                title: Text('Your Listings'),
                leading: Icon(Icons.list_alt_rounded),
                onTap: () {

                }
            ),
            Divider(thickness: 1,),
            ListTile(
              leading: Icon(Icons.view_headline_outlined),
              title: Text('View Books'),
              onTap: () {

              },
            ),
            Divider(thickness: 1,),
            ListTile(
              leading: Icon(Icons.bookmark_outline_sharp),
              title: Text('Add a Book'),
              onTap: () {

              },
            ),
            Divider(thickness: 1,),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
              onTap: () {

              },
            ),
          ],
        )
    );
  }
}
