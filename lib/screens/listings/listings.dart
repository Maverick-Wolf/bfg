import 'package:bfg/screens/listings/book_card.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class Listings extends StatelessWidget {
  const Listings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OurTheme _theme = OurTheme();
    return Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: _theme.secondaryColor.withOpacity(0.8),
          title: Text(
            "Book Listings",
            style: TextStyle(
              color: _theme.tertiaryColor,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.menu,
                  color: _theme.tertiaryColor,
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: DefaultTabController(
            length: 7,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: _theme.tertiaryColor,
                  tabs: [
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("CS"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Phoenix"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Mechanical"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Chemical"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Dual Degree"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Higher Degree"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Misc"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const Center(child: BookCard()),
                      Center(
                          child: Text(
                        "Phoenix",
                        style: TextStyle(color: _theme.tertiaryColor),
                      )),
                      Center(
                          child: Text(
                        "Mechanical",
                        style: TextStyle(color: _theme.tertiaryColor),
                      )),
                      Center(
                          child: Text(
                        "Chemical",
                        style: TextStyle(color: _theme.tertiaryColor),
                      )),
                      Center(
                          child: Text(
                        "Dual Degree",
                        style: TextStyle(color: _theme.tertiaryColor),
                      )),
                      Center(
                          child: Text(
                        "Higher Degree",
                        style: TextStyle(color: _theme.tertiaryColor),
                      )),
                      Center(
                          child: Text(
                        "Misc",
                        style: TextStyle(color: _theme.tertiaryColor),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
