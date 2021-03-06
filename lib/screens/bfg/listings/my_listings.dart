import 'package:bfg/screens/bfg/listings/book_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyListings extends StatefulWidget {
  const MyListings({Key? key}) : super(key: key);
  @override
  State<MyListings> createState() => _MyListingsState();
}

String? _user;
OurTheme _theme = OurTheme();

class _MyListingsState extends State<MyListings> {
  final Stream<QuerySnapshot> _booksStream =
      FirebaseFirestore.instance.collection('books').snapshots();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _user = _auth.currentUser!.uid.toString();
    OurTheme _theme = OurTheme();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.primaryColor,
          centerTitle: true,
          title: Text(
            "My Listings",
            style: TextStyle(
              color: _theme.secondaryColor,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext) =>
                          _buildInfoPopupDialogue(context),
                    );
                  },
                  icon: const Icon(Icons.info),
                  color: _theme.tertiaryColor,
                )),
          ],
        ),
        body: StreamBuilder(
            stream: _booksStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: getBooks(snapshot),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  getBooks(AsyncSnapshot<QuerySnapshot> snapshot) {
    String contactPreference = "Call";
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      if (_user == data['seller_id']) {
        if (data['contact_preference'] == null) {
          contactPreference = "Call";
        } else {
          contactPreference = data['contact_preference'];
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
          child: BookDetailsCard(
            bookEdition: data['edition'],
            note: data['note'],
            userIdOfSeller: data['seller_id'],
            semester: data['semester'],
            priceOfBook: data['price'],
            nameOfBook: data['title'],
            bookAuthor: data['author'],
            department: data['department'],
            nameOfSeller: data['seller_name'],
            roomNumberOfSeller: data['seller_room'],
            hostelNumberOfSeller: data['seller_hostel'],
            phoneNumberOfSeller: data['seller_phone'],
            documentID: document.id,
            longPressBool: true,
            contactPreference: contactPreference,
          ),
        );
      } else {
        return const SizedBox();
      }
    }).toList();
  }
  Widget _buildInfoPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text(
        "thots",
        style: TextStyle(
            fontSize: 24,
            fontFamily: _theme.font,
            fontWeight: FontWeight.bold,
            color: _theme.secondaryColor),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\nThese are books you have put up to sell \n\nRemember to remove books that have already been sold to avoid unnecessary calls\n\n\nTo delete a listing, hold down on the item for 2 seconds and tap 'Delete' on the pop up box",
            style: TextStyle(
              color: _theme.tertiaryColor,
              fontFamily: _theme.font,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
