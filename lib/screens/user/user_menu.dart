import 'package:bfg/drawer/drawer.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  OurTheme _theme = OurTheme();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _theme.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("BFG"),
        backgroundColor: _theme.primaryColor,
      ),
      drawer: const DrawerClass(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildListingsContainer(context, height, width),
            _buildSellContainer(context, height, width),
          ],
        ),
      ),
    );
  }

  Widget _buildListingsContainer(BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/listings');
      },
      child: Container(
        height: height * 0.16,
        width: width * 0.75,
        decoration: BoxDecoration(
          color: _theme.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _theme.secondaryColor),
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
              size: 50,
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
    );
  }

  Widget _buildSellContainer(BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/addBook');
      },
      child: Container(
        height: height * 0.16,
        width: width * 0.75,
        decoration: BoxDecoration(
          color: _theme.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _theme.secondaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 15.0,
            ),
            Icon(
              Icons.bookmark_outline,
              color: _theme.secondaryColor,
              size: 50,
            ),
            const Spacer(),
            Text(
              "Sell a Book",
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
    );
  }
}
