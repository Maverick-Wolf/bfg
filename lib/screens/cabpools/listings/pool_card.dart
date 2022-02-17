import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bfg/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PoolDetailsCard extends StatefulWidget {
  final Map initiator;
  final Map pools;
  final String booked;
  final String city;
  final String date;
  final String from;
  final String to;
  final String note;
  final String time;
  final String maxCapacity;
  final String documentID;
  final bool longPressBool;

  const PoolDetailsCard({
    Key? key,
    required this.initiator,
    required this.time,
    required this.pools,
    required this.booked,
    required this.city,
    required this.date,
    required this.from,
    required this.to,
    required this.note,
    required this.maxCapacity,
    required this.documentID,
    required this.longPressBool,
  }) : super(key: key);

  @override
  _PoolDetailsCardState createState() => _PoolDetailsCardState();
}

OurTheme _theme = OurTheme();
late double _width;
final FirebaseAuth _auth = FirebaseAuth.instance;

class _PoolDetailsCardState extends State<PoolDetailsCard> {
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
                          const Spacer(),
                          _buildRichText(
                              "Initiator: ", widget.initiator['name'], 15),
                          const SizedBox(width: 4),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildTitle(widget.date, 20),
                      _buildTitle(widget.city, 24),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRichText("From: ", widget.from, 15),
                                _buildRichText("To: ", widget.to, 15),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                _buildRichText(
                                    "Capacity: ",
                                    widget.booked.toString() +
                                        "/" +
                                        widget.maxCapacity.toString(),
                                    15),
                                const SizedBox(
                                  height: 3,
                                ),
                                _buildRichText("Time: ", widget.time, 15),
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
            builder: (BuildContext) => _buildPopupDialogue(context));
      },
      // onLongPress: () async {
      //   String phoneNumber = "";
      //   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      //       .collection("users")
      //       .doc(_auth.currentUser!.uid)
      //       .get();
      //   if (documentSnapshot.exists) {
      //     phoneNumber = (documentSnapshot.data() as dynamic)['phone_number'];
      //   }
      //   print(phoneNumber);
      //   if (widget.longPressBool || phoneNumber == "+919876543210") {
      //     CollectionReference books =
      //         FirebaseFirestore.instance.collection('books');
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext) =>
      //             _deleteBookConfirmationPopUp(context, books));
      //   }
      // },
    );
  }

  Widget _buildTitle(String bookTitle, double fontSize) {
    return Text(
      bookTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        letterSpacing: 1,
        fontFamily: _theme.font,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRichText(String text1, String text2, double _fontSize) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.45),
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

  Widget _buildPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildTitle(widget.date, 20),
          _buildTitle(widget.city, 24),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText("Initiator: ", widget.initiator['name'], 15),
                    _buildRichText("Pools:", "", 14),
                    for (var i = 2; i <= int.parse(widget.booked); i++)
                      widget.pools['name$i'].toString().isNotEmpty
                          ? _buildRichText(
                              "${i - 1}: ", widget.pools['name$i'], 13)
                          : const SizedBox(),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildRichText("From: ", widget.from, 14),
                    _buildRichText("To: ", widget.to, 14),
                    _buildRichText(
                        "Capacity: ",
                        widget.booked.toString() +
                            "/" +
                            widget.maxCapacity.toString(),
                        14),
                    const SizedBox(
                      height: 3,
                    ),
                    _buildRichText("Time: ", widget.time, 14),
                  ],
                ),
              ],
            ),
          ),
          if (widget.note.isNotEmpty) _buildRichText("Note: ", widget.note, 12),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  await openWhatsapp(widget.initiator['phone']);
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: _theme.primaryColor,
                          offset: Offset.fromDirection(1, 2),
                          blurRadius: 1)
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Contact Initiator",
                      style: TextStyle(
                          fontFamily: _theme.font,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _theme.tertiaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: _theme.primaryColor,
                          offset: Offset.fromDirection(1, 2),
                          blurRadius: 1)
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Join pool",
                      style: TextStyle(
                          fontFamily: _theme.font,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _theme.tertiaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  openWhatsapp(String _phoneNumber) async {
    var whatsappURl = "whatsapp://send?phone=" + _phoneNumber + "&text=";
    try {
      launch(whatsappURl);
    } catch (e) {
      _makePhoneCall('tel:$_phoneNumber', _phoneNumber);
    }
  }

  // Widget _deleteBookConfirmationPopUp(
  //     BuildContext context, CollectionReference books) {
  //   return AlertDialog(
  //     backgroundColor: Colors.grey,
  //     title: Center(
  //       child: Text(
  //         "DELETE?",
  //         style: TextStyle(
  //             color: _theme.secondaryColor,
  //             letterSpacing: 0.7,
  //             fontFamily: _theme.font,
  //             fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           "Tapping delete will remove all instances of this listing\nThis action cannot be undone",
  //           style: TextStyle(
  //               color: _theme.tertiaryColor,
  //               letterSpacing: 0.7,
  //               fontFamily: _theme.font,
  //               fontWeight: FontWeight.bold),
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //               primary: Colors.red.withOpacity(0.8),
  //               onPrimary: _theme.tertiaryColor),
  //           onPressed: () {
  //             deleteBooks(books);
  //             Navigator.pop(context);
  //           },
  //           child: const Text("Delete"),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<void> _makePhoneCall(String url, String _phoneNumber) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      Clipboard.setData(ClipboardData(text: _phoneNumber));
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
