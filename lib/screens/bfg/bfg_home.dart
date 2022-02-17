import 'package:bfg/widgets/drawer.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class BfgHome extends StatefulWidget {
  const BfgHome({Key? key}) : super(key: key);

  @override
  _BfgHomeState createState() => _BfgHomeState();
}

class _BfgHomeState extends State<BfgHome> {
  final OurTheme _theme = OurTheme();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      drawer: const DrawerClass(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildListingsContainer(context, height, width),
            _buildSellContainer(context, height, width),
            _buildMyListingsContainer(context, height, width)
          ],
        ),
      ),
    );
  }

  Widget _buildListingsContainer(
      BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/listings');
        const snackBar = SnackBar(
          content: Text(
            "Tap on a card to view more details about the seller",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(milliseconds: 1700),
          backgroundColor: Colors.blue,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        height: height * 0.16,
        width: width * 0.8,
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
              Icons.view_headline_outlined,
              color: _theme.secondaryColor,
              size: 40,
            ),
            const Spacer(),
            Text(
              "View Listings",
              style: TextStyle(
                  color: _theme.tertiaryColor,
                  fontFamily: _theme.font,
                  fontSize: 28.0,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSellContainer(
      BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/addBook');
      },
      child: Container(
        height: height * 0.16,
        width: width * 0.8,
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
              size: 40,
            ),
            const Spacer(),
            Text(
              "Sell a Book",
              style: TextStyle(
                  color: _theme.tertiaryColor,
                  fontFamily: _theme.font,
                  fontSize: 28.0,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMyListingsContainer(
      BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/myListings');
        final snackBar = SnackBar(
          content: Text("Tap and hold a listing for 2 seconds to delete it",
              style: TextStyle(color: _theme.tertiaryColor)),
          backgroundColor: Colors.blue,
          duration: const Duration(milliseconds: 1700),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        height: height * 0.16,
        width: width * 0.8,
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
              Icons.list_alt_rounded,
              color: _theme.secondaryColor,
              size: 40,
            ),
            const Spacer(),
            Text(
              "My Listings",
              style: TextStyle(
                  color: _theme.tertiaryColor,
                  fontFamily: _theme.font,
                  fontSize: 28.0,
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
