import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class logooo extends StatefulWidget {
  logooo({Key? key}) : super(key: key);

  @override
  _logoooState createState() => _logoooState();
}

class _logoooState extends State<logooo> {
  OurTheme _theme = OurTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 1,),
            Container(
              height: 300,
              width: 150,
              child: Image.asset('assets/images/bfg.png'),
            ),
            Text(
              "Books For Ghots",
              style: TextStyle(
                color: _theme.secondaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 1,),
          ],
        ),
      ),
    );
  }
}
