import 'package:bfg/screens/listings/book_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

String? _user;
OurTheme _theme = OurTheme();

class _SearchPageState extends State<SearchPage> {
  final Stream<QuerySnapshot> _booksStream =
  FirebaseFirestore.instance.collection('books').snapshots();
  String stringToBeSearched = "";

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _user = _auth.currentUser!.uid.toString();
    OurTheme _theme = OurTheme();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
          appBar: AppBar(
            backgroundColor: _theme.primaryColor,
            centerTitle: true,
            title: Text(
              "Search",
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSearchBar(),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 185,
                    child: StreamBuilder(
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
                        }),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        initialValue: "",
        onChanged: (value) {
          stringToBeSearched = value;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: _theme.tertiaryColor,
          border: const OutlineInputBorder(),
          labelText: "Search",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(color: _theme.primaryColor),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _theme.secondaryColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _theme.secondaryColor, width: 2)),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:Colors.grey.withOpacity(0.3)
              ),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).unfocus();
                  });
                },
                splashRadius: 24,
                color: _theme.primaryColor,
              ),
            ),
          )
        ),
        cursorColor: _theme.primaryColor,
        style: TextStyle(
          fontFamily: _theme.font,
          fontWeight: FontWeight.bold,
          color: _theme.primaryColor
        ),
      ),
    );
  }

  getBooks(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      if (data['title'].toString().toLowerCase().contains(stringToBeSearched.toLowerCase()) || data['seller_name'].toString().toLowerCase().contains(stringToBeSearched.toLowerCase()) || data['author'].toString().toLowerCase().contains(stringToBeSearched.toLowerCase())) {
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
            longPressBool: false,
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
            "\nYou can search the listings by book title, author name or seller name\n\nSearch with a blank text field to view all books at once\n",
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
