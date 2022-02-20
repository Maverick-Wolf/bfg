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
        backgroundColor: Color.fromARGB(255, 20, 236, 49),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.yellowAccent,
          ),
          title: const Text(
            "Send Help",
            style: TextStyle(letterSpacing: 6, color: Colors.deepPurpleAccent),
          ),
          backgroundColor: Colors.pinkAccent,
        ),
        body: SizedBox(
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
                        SizedBox(
                            child: Image.asset(
                              "assets/images/give.jpeg",
                              fit: BoxFit.fill,
                            ),
                            height: _height * 0.18,
                            width: _width * 0.45),
                        const Spacer(),
                        const SelectableText(
                          "7042274018@paytm",
                          style: TextStyle(
                              // fontFamily: _theme.font,
                              fontSize: 16,
                              color: Color.fromARGB(255, 211, 41, 41),
                              fontWeight: FontWeight.w800),
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                          ),
                        ),
                        const SelectableText(
                          "9411046007@upi",
                          style: TextStyle(
                              // fontFamily: _theme.font,
                              fontSize: 16,
                              color: Color.fromARGB(255, 53, 55, 165),
                              fontWeight: FontWeight.w800),
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                          ),
                        ),
                        const Spacer(),
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
                    height: _height * 0.19,
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
                      height: _height * 0.19,
                      width: _width * 0.45),
                ],
              ),
            ],
          ),
        ));
  }
}
