import 'package:bfg/screens/listings/book_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? _user;

class YourListings extends StatefulWidget {
  const YourListings({Key? key}) : super(key: key);

  @override
  State<YourListings> createState() => _YourListingsState();
}

class _YourListingsState extends State<YourListings> {
  late Stream<QuerySnapshot> _booksStream =
        FirebaseFirestore.instance.collection('books').snapshots();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _user = _auth.currentUser!.uid.toString();
    OurTheme _theme = OurTheme();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.primaryColor,
          title: Text(
            "Your Listings",
            style: TextStyle(
              color: _theme.secondaryColor,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
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
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      if (_user == data['seller_id']) {
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
          ),
        );
      } else {
        return const SizedBox(height: 0,);
      }
    }).toList();
  }
}
