import 'package:bfg/drawer/drawer.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("List View"),
      ),
      drawer: DrawerClass(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BookDetailsCard(),
        ],
      ),
    );
  }
}

class BookDetailsCard extends StatefulWidget {
  const BookDetailsCard({Key? key}) : super(key: key);

  @override
  _BookDetailsCardState createState() => _BookDetailsCardState();
}

class _BookDetailsCardState extends State<BookDetailsCard> {
  @override

  String nameOfBook = "Elements of the Theory of Computation";
  String priceOfBook = "300";
  String roomNumberOfSeller = "AH 2 - 344";
  String nameOfSeller = "Rachit Champu";
  String bookAuthor = "Harry Lewis, Christos Papadimitriou";
  String department = "Comp Sc";
  String bookEdition = "2";
  String year = "2";

  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 4),
                  _buildRichText("Seller: ", nameOfSeller, 14),
                  Spacer(),
                  _buildRichText("", roomNumberOfSeller, 14),
                  SizedBox(width: 4),
                ],
              ),
              SizedBox(height: 30,),
              _buildBookTitle(nameOfBook),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 32, 10, 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRichText("Author(s): ", bookAuthor, 14),
                        _buildRichText("Edition: ", bookEdition, 14),
                        _buildRichText("Department: ", department, 14),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        _buildRichText("Year: ", year, 14),
                        SizedBox(height: 3,),
                        _buildRichText("₹ ", priceOfBook, 25),
                      ],
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 7),
              //   child: _buildRichText("Note: ", "Lorem ipsum ............ my name is khan and i am not a terrorist", 14),
              // ),
              SizedBox(height: 7,),
            ],
          ),
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext) => _buildPopupDialogue(context, nameOfSeller, nameOfBook, priceOfBook, roomNumberOfSeller)
          );
        },
      ),
    );
  }
}

Widget _buildBookTitle(String bookTitle) {
  return Text(
    bookTitle,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 25.0,
      letterSpacing: 1,
      fontFamily: _theme.font,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _buildRichText(String text1, String text2, double _fontSize) {
  return RichText(
    text: TextSpan(
        text: text1,
        style: TextStyle(
          color: _theme.secondaryColor,
          fontFamily: _theme.font,
          fontWeight: FontWeight.w600,
          fontSize: _fontSize,
        ),
        children: <TextSpan>[
          TextSpan(
              text: text2,
              style: TextStyle(
                color: _theme.tertiaryColor,
                fontFamily: _theme.font,
                fontWeight: FontWeight.w400
              )
          ),
        ]
    ),
  );
}

Widget _buildPopupDialogue(BuildContext context, String _sellerName, String _bookName, String _bookPrice, String _roomNumber) {
  return AlertDialog(
    backgroundColor: Colors.grey,
    title: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _sellerName,
              style: TextStyle(
                  color: _theme.secondaryColor,
                  letterSpacing: 0.7,
                  fontFamily: _theme.font,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              _roomNumber,
              style: TextStyle(
                  color: _theme.secondaryColor,
                  fontFamily: _theme.font,
                  fontWeight: FontWeight.w600,
                  fontSize: 16
              ),
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            IconButton(
              onPressed:() {},
              icon: Icon(
                Icons.phone,
                size: 34,
                color: _theme.secondaryColor,
              ),
            ),
            Text(
              "Call",
              style: TextStyle(
                fontFamily: _theme.font,
                fontSize: 12,
                color: _theme.secondaryColor
              ),
            ),
          ],
        ),
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 15,),
        Text(
          _bookName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontSize: 24,
            fontFamily: _theme.font,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 25,),
        Text(
          "₹ " + _bookPrice,
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1,
              fontSize: 20,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
  );
}
