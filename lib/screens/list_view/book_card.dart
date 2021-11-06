import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  const BookCard({Key? key}) : super(key: key);

  @override
  _BookCardState createState() => _BookCardState();
}

OurTheme _theme = OurTheme();

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BookDetailsCard(),
      ],
    );
  }
}

class BookDetailsCard extends StatelessWidget {
  const BookDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 4),
                RichText(
                  text: TextSpan(
                      text: "Seller: ",
                      style: TextStyle(
                        color: _theme.secondaryColor,
                        fontFamily: _theme.font,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Rachit Champu",
                            style: TextStyle(
                              color: _theme.tertiaryColor,
                              fontFamily: _theme.font,
                            )
                        ),
                      ]
                  ),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                      text: "AH 2 - ",
                      style: TextStyle(
                        color: _theme.secondaryColor,
                        fontFamily: _theme.font,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "344",
                            style: TextStyle(
                              color: _theme.tertiaryColor,
                              fontFamily: _theme.font,
                            )
                        ),
                      ]
                  ),
                ),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              "Elements of the Theory of Computation",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 22, 10, 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Author(s): ",
                          style: TextStyle(
                            color: _theme.secondaryColor,
                            fontFamily: _theme.font,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Harry Lewis, Christos Papadimitriou",
                                style: TextStyle(
                                  color: _theme.tertiaryColor,
                                  fontFamily: _theme.font,
                                )
                            ),
                          ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Edition: ",
                            style: TextStyle(
                              color: _theme.secondaryColor,
                              fontFamily: _theme.font,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "2",
                                  style: TextStyle(
                                    color: _theme.tertiaryColor,
                                    fontFamily: _theme.font,
                                  )
                              ),
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Department: ",
                            style: TextStyle(
                              color: _theme.secondaryColor,
                              fontFamily: _theme.font,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Comp Sc",
                                  style: TextStyle(
                                    color: _theme.tertiaryColor,
                                    fontFamily: _theme.font,
                                  )
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Year: ",
                            style: TextStyle(
                              color: _theme.secondaryColor,
                              fontFamily: _theme.font,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "2",
                                  style: TextStyle(
                                    color: _theme.tertiaryColor,
                                    fontFamily: _theme.font,
                                  )
                              ),
                            ]
                        ),
                      ),
                      SizedBox(height: 3,),
                      RichText(
                        text: TextSpan(
                            text: "₹ ",
                            style: TextStyle(
                              color: _theme.secondaryColor,
                              fontFamily: _theme.font,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "300",
                                  style: TextStyle(
                                    color: _theme.tertiaryColor,
                                    fontFamily: _theme.font,
                                  )
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 7),
              child: RichText(
                text: TextSpan(
                    text: "Note: ",
                    style: TextStyle(
                      color: _theme.secondaryColor,
                      fontFamily: _theme.font,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Lorem ipsum ............ my name is khan and i am not a terrorist",
                          style: TextStyle(
                            color: _theme.tertiaryColor,
                            fontFamily: _theme.font,
                          )
                      ),
                    ]
                ),
              ),
            ),
            SizedBox(height: 7,),
          ],
        ),
      ),
    );
  }
}
