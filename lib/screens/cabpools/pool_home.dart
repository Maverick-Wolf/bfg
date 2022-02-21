import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

final OurTheme _theme = OurTheme();

class PoolHome extends StatelessWidget {
  const PoolHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
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
      ),
    );
  }

  Widget _buildListingsContainer(
      BuildContext context, double height, double width) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/poolListings');
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
              Icons.map,
              color: _theme.secondaryColor,
              size: 40,
            ),
            const Spacer(),
            Text(
              "View Pools",
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
        Navigator.pushNamed(context, '/addCarpool');
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
              Icons.directions_car,
              color: _theme.secondaryColor,
              size: 40,
            ),
            const Spacer(),
            Text(
              "Start a pool",
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
        Navigator.pushNamed(context, '/myPools');
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
              Icons.person,
              color: _theme.secondaryColor,
              size: 40,
            ),
            const Spacer(),
            Text(
              "My Pools",
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
