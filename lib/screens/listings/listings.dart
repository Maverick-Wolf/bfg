import 'package:bfg/screens/listings/book_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String _semester = "All";

class Listings extends StatefulWidget {
  Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  late CollectionReference users;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  late Stream<QuerySnapshot> _booksStream =
      FirebaseFirestore.instance.collection('books').snapshots();
  OurTheme _theme = OurTheme();

  @override
  Widget build(BuildContext context) {
    _user = _auth.currentUser;
    users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          // centerTitle: true,
          backgroundColor: _theme.primaryColor,
          title: Text(
            "Book Listings",
            style: TextStyle(
              color: _theme.secondaryColor,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Text(
                  "Sem : ",
                  style: TextStyle(
                      fontFamily: _theme.font,
                      fontSize: 16,
                      color: _theme.secondaryColor,
                      fontWeight: FontWeight.w600),
                ),
                DropdownButton<String>(
                  value: _semester,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 22,
                  elevation: 16,
                  style: TextStyle(color: _theme.secondaryColor),
                  underline: Container(
                    height: 2,
                    color: _theme.secondaryColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _semester = newValue!;
                    });
                  },
                  items: <String>[
                    'All',
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '-'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 15.0,
                )
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: DefaultTabController(
            length: 8,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: _theme.tertiaryColor,
                  tabs: [
                    _buildTab("All"),
                    _buildTab("Comp Sc"),
                    _buildTab("Phoenix"),
                    _buildTab("Mechanical"),
                    _buildTab("Chemical"),
                    _buildTab("Dual Degree"),
                    _buildTab("Higher Degree"),
                    _buildTab("Misc"),
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: _booksStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return TabBarView(
                          children: [
                            ListView(
                              children: getBooks(snapshot, "All"),
                            ),
                            ListView(
                              children: getBooks(snapshot, "Comp Sc"),
                            ),
                            ListView(
                              children: getBooks(snapshot, "Phoenix"),
                            ),
                            ListView(
                              children: getBooks(snapshot, "Mechanical"),
                            ),
                            ListView(
                              children: getBooks(snapshot, "Chemical"),
                            ),
                            ListView(
                              children: getBooks(snapshot, "Dual Degree"),
                            ),
                            ListView(
                              children: getBooks(snapshot, "Higher Deg"),
                            ),
                            ListView(
                              children: getBooks(snapshot, "Misc"),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  getBooks(AsyncSnapshot<QuerySnapshot> snapshot, String department) {
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      if ("All" == department && _semester == "All") {
        return Padding(
          padding: EdgeInsets.only(bottom: 5.0, top: 7.0),
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
      } else if (department == "All" && data['semester'] == _semester) {
        return Padding(
          padding: EdgeInsets.only(bottom: 5.0, top: 7.0),
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
      } else if (data['department'] == department && _semester == "All") {
        return Padding(
          padding: EdgeInsets.only(bottom: 5.0, top: 7.0),
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
      } else if (data['department'] == department &&
          _semester == data['semester']) {
        return Padding(
          padding: EdgeInsets.only(bottom: 5.0, top: 7.0),
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
        return const SizedBox(
          height: 0,
        );
      }
    }).toList();
  }

  Widget _buildTab(String title) {
    return SizedBox(
      height: 75.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/college.png"),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: TextStyle(
                  color: _theme.tertiaryColor,
                  fontFamily: _theme.font,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
