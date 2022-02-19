import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    OurTheme _theme = OurTheme();
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Send Help"),
        ),
        body: Container(
          height: _height,
          width: _width,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: _height * 0.2,
                    width: _width * 0.7,
                    child: Image.asset(
                      "assets/images/wows.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                      child: Image.asset(
                        "assets/images/rihanna.gif",
                        fit: BoxFit.fill,
                      ),
                      height: _height * 0.2,
                      width: _width * 0.3),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: _height * 0.25,
                    width: _width * 0.5,
                    child: Image.asset(
                      "assets/images/simpsons.gif",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                      child: Image.asset(
                        "assets/images/stewie.gif",
                        fit: BoxFit.fill,
                      ),
                      height: _height * 0.25,
                      width: _width * 0.5),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: _height * 0.26,
                    child: Column(
                      children: [
                        Spacer(),
                        SelectableText(
                          "7042274018@paytm",
                          style: TextStyle(
                              fontFamily: _theme.font,
                              fontSize: 16,
                              color: _theme.secondaryColor,
                              fontWeight: FontWeight.w600),
                          toolbarOptions: const ToolbarOptions(
                            copy: true,
                            selectAll: true,
                          ),
                        ),
                        SelectableText(
                          "9411046007@upi",
                          style: TextStyle(
                              fontFamily: _theme.font,
                              fontSize: 16,
                              color: _theme.secondaryColor,
                              fontWeight: FontWeight.w600),
                          toolbarOptions: const ToolbarOptions(
                            copy: true,
                            selectAll: true,
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                            child: Image.asset(
                              "assets/images/give.jpeg",
                              fit: BoxFit.fill,
                            ),
                            height: _height * 0.18,
                            width: _width * 0.45),
                      ],
                    ),
                  ),
                  SizedBox(
                      child: Image.asset(
                        "assets/images/bernie.jpeg",
                        fit: BoxFit.fill,
                      ),
                      height: _height * 0.26,
                      width: _width * 0.55),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: _height * 0.156,
                    width: _width * 0.55,
                    child: Image.asset(
                      "assets/images/doge.gif",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                      child: Image.asset(
                        "assets/images/broke.jpeg",
                        fit: BoxFit.fill,
                      ),
                      height: _height * 0.156,
                      width: _width * 0.45),
                ],
              ),
            ],
          ),
        ));
  }
}
