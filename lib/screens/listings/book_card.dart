import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsCard extends StatefulWidget {
  final String nameOfBook;
  final String priceOfBook;
  final String userIdOfSeller;
  final String bookAuthor;
  final String department;
  final String bookEdition;
  final String semester;
  final String note;
  final String nameOfSeller;
  final String roomNumberOfSeller;
  final String hostelNumberOfSeller;
  final String phoneNumberOfSeller;
  final String documentID;
  final bool longPressBool;

  const BookDetailsCard({
    Key? key,
    required this.nameOfBook,
    required this.note,
    required this.userIdOfSeller,
    required this.priceOfBook,
    required this.bookAuthor,
    required this.bookEdition,
    required this.department,
    required this.semester,
    required this.nameOfSeller,
    required this.roomNumberOfSeller,
    required this.phoneNumberOfSeller,
    required this.hostelNumberOfSeller,
    required this.documentID,
    required this.longPressBool,
  }) : super(key: key);

  @override
  _BookDetailsCardState createState() => _BookDetailsCardState();
}

OurTheme _theme = OurTheme();
late double _height;
late double _width;

class _BookDetailsCardState extends State<BookDetailsCard> {
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Center(
        child: GlassmorphicContainer(
          height: _height * 0.31,
          width: _width * 0.93,
          borderRadius: 15,
          blur: 15,
          alignment: Alignment.center,
          border: 2,
          linearGradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.2),
            Colors.white38.withOpacity(0.2)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderGradient: LinearGradient(colors: [
            Colors.white24.withOpacity(0.2),
            Colors.white70.withOpacity(0.2)
          ]),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 16,
                spreadRadius: 16,
                color: Colors.black.withOpacity(0.1),
              )
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20.0,
                  sigmaY: 20.0,
                ),
                child: Container(
                    height: _height * 0.7,
                    width: _width * 0.93,
                    decoration: BoxDecoration(
                        color: _theme.tertiaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.2),
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 4),
                              _buildRichText(
                                  "Seller: ", widget.nameOfSeller, 14),
                              Spacer(),
                              _buildRichText(
                                  "",
                                  "${widget.hostelNumberOfSeller}/${widget.roomNumberOfSeller}",
                                  14),
                              SizedBox(width: 4),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _buildBookTitle(widget.nameOfBook),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildRichText(
                                        "Author(s): ", widget.bookAuthor, 14),
                                    _buildRichText(
                                        "Edition: ", widget.bookEdition, 12),
                                    _buildRichText(
                                        "Department: ", widget.department, 12),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    _buildRichText(
                                        "Sem: ", widget.semester, 12),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    _buildRichText(
                                        "₹ ", widget.priceOfBook, 25),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (widget.note.isNotEmpty)
                            _buildRichText("Note: ", widget.note, 12),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext) => _buildPopupDialogue(
                context,
                widget.nameOfSeller,
                widget.nameOfBook,
                widget.priceOfBook,
                "${widget.hostelNumberOfSeller}/${widget.roomNumberOfSeller}"));
      },
      onLongPress: () {
        if (widget.longPressBool) {
          CollectionReference books =
              FirebaseFirestore.instance.collection('books');
          deleteBooks(books);
        }
      },
    );
  }

  Widget _buildBookTitle(String bookTitle) {
    return Text(
      bookTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
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
                    fontWeight: FontWeight.w400)),
          ]),
    );
  }

  Widget _buildPopupDialogue(BuildContext context, String _sellerName,
      String _bookName, String _bookPrice, String _roomNumber) {
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
                    fontWeight: FontWeight.bold),
              ),
              Text(
                _roomNumber,
                style: TextStyle(
                    color: _theme.secondaryColor,
                    fontFamily: _theme.font,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  _makePhoneCall('tel:${widget.phoneNumberOfSeller}');
                },
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
                    color: _theme.secondaryColor),
              ),
            ],
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            _bookName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 24,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "₹ " + _bookPrice,
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 20,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> deleteBooks(CollectionReference books) {
    return books
        .doc(widget.documentID)
        .delete()
        .then((value) => print("Book Deleted"))
        .catchError((error) => print("Failed to delete book: $error"));
  }
}
