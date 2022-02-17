import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bfg/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final String contactPreference;

  const BookDetailsCard(
      {Key? key,
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
      required this.contactPreference})
      : super(key: key);

  @override
  _BookDetailsCardState createState() => _BookDetailsCardState();
}

OurTheme _theme = OurTheme();
late double _width;
final FirebaseAuth _auth = FirebaseAuth.instance;

class _BookDetailsCardState extends State<BookDetailsCard> {
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Center(
        child: Container(
          width: _width * 0.96,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                spreadRadius: 16,
                color: Colors.black.withOpacity(0.1),
              )
            ],
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.black12.withOpacity(0.5),
              Colors.grey.withOpacity(0.45),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                decoration: BoxDecoration(
                    color: _theme.tertiaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        width: 1.5,
                        color: _theme.tertiaryColor.withOpacity(0.4))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 4),
                          _buildRichText("Seller: ", widget.nameOfSeller, 15),
                          const Spacer(),
                          _buildRichText(
                              "",
                              "${widget.hostelNumberOfSeller} - ${widget.roomNumberOfSeller}",
                              15),
                          const SizedBox(width: 4),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildBookTitle(widget.nameOfBook),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildAuthorRichText(
                                    "Author(s): ", widget.bookAuthor, 14),
                                _buildRichText(
                                    "Edition: ", widget.bookEdition, 13),
                                _buildRichText(
                                    "Department: ", widget.department, 13),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                _buildRichText("Sem: ", widget.semester, 13),
                                const SizedBox(
                                  height: 3,
                                ),
                                _buildRichText("₹ ", widget.priceOfBook, 25),
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
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext) => _buildPopupDialogue(
                context,
                widget.nameOfSeller,
                widget.nameOfBook,
                widget.priceOfBook,
                "${widget.hostelNumberOfSeller} - ${widget.roomNumberOfSeller}"));
      },
      onLongPress: () async {
        String phoneNumber = "";
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .get();
        if (documentSnapshot.exists) {
          phoneNumber = (documentSnapshot.data() as dynamic)['phone_number'];
        }
        print(phoneNumber);
        if (widget.longPressBool || phoneNumber == "+919876543210") {
          CollectionReference books =
              FirebaseFirestore.instance.collection('books');
          showDialog(
              context: context,
              builder: (BuildContext) =>
                  _deleteBookConfirmationPopUp(context, books));
        }
      },
    );
  }

  Widget _buildBookTitle(String bookTitle) {
    return Text(
      bookTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 22.0,
        letterSpacing: 1,
        fontFamily: _theme.font,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAuthorRichText(String text1, String text2, double _fontSize) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 120,
      child: RichText(
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
    IconData contactIcon = Icons.call;
    if (widget.contactPreference == "Whatsapp") {
      contactIcon = Icons.message;
    } else if (widget.contactPreference == "Call") {
      contactIcon = Icons.call;
    } else {
      contactIcon = Icons.call;
    }
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
          const Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black45.withOpacity(0.1),
            ),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    if (widget.contactPreference == "Whatsapp") {
                      openWhatsapp();
                    } else if (widget.contactPreference == "Call") {
                      _makePhoneCall('tel:${widget.phoneNumberOfSeller}');
                    } else {
                      _makePhoneCall('tel:${widget.phoneNumberOfSeller}');
                    }
                  },
                  icon: Icon(
                    contactIcon,
                    size: 36,
                    color: _theme.secondaryColor,
                  ),
                ),
                Text(
                  "Contact",
                  style: TextStyle(
                      fontFamily: _theme.font,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _theme.secondaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
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
          const SizedBox(
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

  openWhatsapp() async {
    var whatsappURl =
        "whatsapp://send?phone=" + widget.phoneNumberOfSeller + "&text=";
    try {
      launch(whatsappURl);
    } catch (e) {
      print(e);
      _makePhoneCall('tel:${widget.phoneNumberOfSeller}');
    }
  }

  Widget _deleteBookConfirmationPopUp(
      BuildContext context, CollectionReference books) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Center(
        child: Text(
          "DELETE?",
          style: TextStyle(
              color: _theme.secondaryColor,
              letterSpacing: 0.7,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tapping delete will remove all instances of this listing\nThis action cannot be undone",
            style: TextStyle(
                color: _theme.tertiaryColor,
                letterSpacing: 0.7,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red.withOpacity(0.8),
                onPrimary: _theme.tertiaryColor),
            onPressed: () {
              deleteBooks(books);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          )
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      Clipboard.setData(ClipboardData(text: widget.phoneNumberOfSeller));
      const snackBar = SnackBar(
        content: Text('Seller phone number copied to clipboard'),
        duration: Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> deleteBooks(CollectionReference books) {
    return books.doc(widget.documentID).delete().then((value) {
      const snackBar =
          SnackBar(content: Text('Your listing was deleted successfully :D'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      final snackBar =
          SnackBar(content: Text("Failed to delete book ;-; ... $error"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
