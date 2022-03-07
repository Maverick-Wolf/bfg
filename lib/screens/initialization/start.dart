import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final OurTheme _theme = OurTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/initialization');
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 1,
              ),
              SizedBox(
                height: 300,
                width: 150,
                child: Image.asset('assets/images/bfg.png'),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Books For Ghots",
                    textStyle: TextStyle(
                        color: _theme.secondaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                    speed: const Duration(milliseconds: 150),
                  )
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
                onFinished: () {
                  Future.delayed(const Duration(milliseconds: 20));
                  Navigator.pushReplacementNamed(context, '/initialization');
                },
              ),
              const SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
