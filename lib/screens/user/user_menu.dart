import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OurTheme _theme = OurTheme();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _theme.primaryColor,
      appBar: AppBar(
        backgroundColor: _theme.secondaryColor.withOpacity(0.8),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          children: [
            ListTile(
              title: Text(
                "Option 1",
                style: TextStyle(fontFamily: _theme.font),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Option 2",
                style: TextStyle(fontFamily: _theme.font),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Option 3",
                style: TextStyle(fontFamily: _theme.font),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Option 4",
                style: TextStyle(fontFamily: _theme.font),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Option 5",
                style: TextStyle(fontFamily: _theme.font),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.16,
              width: width * 0.75,
              decoration: BoxDecoration(
                color: _theme.primaryColor,
                borderRadius: BorderRadius.circular(17.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    Icons.table_view_rounded,
                    color: _theme.secondaryColor,
                    size: 57,
                  ),
                  const Spacer(),
                  Text(
                    "View Listings",
                    style: TextStyle(
                        color: _theme.tertiaryColor,
                        fontFamily: _theme.font,
                        fontSize: 32.0,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Container(
              height: height * 0.16,
              width: width * 0.75,
              decoration: BoxDecoration(
                color: _theme.primaryColor,
                borderRadius: BorderRadius.circular(17.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    Icons.add_circle_outline_rounded,
                    color: _theme.secondaryColor,
                    size: 57,
                  ),
                  const Spacer(),
                  Text(
                    "Add New Listing",
                    style: TextStyle(
                        color: _theme.tertiaryColor,
                        fontFamily: _theme.font,
                        fontSize: 32.0,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
