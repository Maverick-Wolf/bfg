import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

OurTheme _theme = OurTheme();

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 236, 49),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "Send Help",
            style: TextStyle(letterSpacing: 2, color: _theme.secondaryColor),
          ),
          backgroundColor: _theme.primaryColor,
        ),
        body: SizedBox(
          height: _height,
          width: _width,
          child: Column(
            children: [
              SizedBox(
                height: _height * 0.3,
                width: _width,
                child: Image.asset(
                  "assets/images/wows.jpeg",
                  fit: BoxFit.fill,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: _height * 0.3,
                    width: _width * 0.5,
                    child: Image.asset(
                      "assets/images/rihanna.gif",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                      child: Image.asset(
                        "assets/images/simpsons.jpg",
                        fit: BoxFit.fill,
                      ),
                      height: _height * 0.3,
                      width: _width * 0.5),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: _height * 0.3019,
                    width: _width * 0.55,
                    child: Image.asset(
                      "assets/images/bernie.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                          child: Image.asset(
                            "assets/images/doge.gif",
                            fit: BoxFit.fill,
                          ),
                          height: _height * 0.3019,
                          width: _width * 0.45),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 20.0),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        _donatePopUp(context));
                              },
                              child: Container(
                                width: _width * 0.4,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Donate(Click Me)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _donatePopUp(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      content: SizedBox(
        height: MediaQuery.of(context).size.width * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SelectableText(
                  "9411046007@upi",
                  showCursor: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  width: 45.0,
                ),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          const ClipboardData(text: "9411046007@upi"));
                      const snackBar = SnackBar(
                        content: Text('UPI ID copied to clipboard'),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.copy,
                      color: _theme.secondaryColor,
                      size: 28.0,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SelectableText(
                  "7042274018@paytm",
                  showCursor: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          const ClipboardData(text: "7042274018@paytm"));
                      const snackBar = SnackBar(
                        content: Text('UPI ID copied to clipboard'),
                        duration: Duration(seconds: 2),
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(
                      Icons.copy,
                      color: _theme.secondaryColor,
                      size: 28.0,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
