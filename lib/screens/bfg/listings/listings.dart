import 'package:bfg/screens/bfg/listings/book_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String _semester = "All";
String _orderBy = "Most Recent";

class Listings extends StatefulWidget {
  const Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  late CollectionReference users;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  late Stream<QuerySnapshot> _booksStream;
  final OurTheme _theme = OurTheme();

  @override
  Widget build(BuildContext context) {
    if (_orderBy == "Most Recent") {
      _booksStream = FirebaseFirestore.instance.collection('books').snapshots();
    } else if (_orderBy == "Alphabetical") {
      _booksStream = FirebaseFirestore.instance
          .collection('books')
          .orderBy('title')
          .snapshots();
    } else if (_orderBy == "Seller Name Ascending") {
      _booksStream = FirebaseFirestore.instance
          .collection('books')
          .orderBy('seller_name', descending: false)
          .snapshots();
    } else if (_orderBy == "Seller Name Descending") {
      _booksStream = FirebaseFirestore.instance
          .collection('books')
          .orderBy('seller_name', descending: true)
          .snapshots();
    }
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
            _buildFilterRow(context),
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
                    _buildTab("All", "college"),
                    _buildTab("Misc", "misc"),
                    _buildTab("Comp Sc", "cs"),
                    _buildTab("Phoenix", "phx"),
                    _buildTab("Mechanical", "mech"),
                    _buildTab("Chemical", "chem"),
                    _buildTab("Dual Degree", "dual"),
                    _buildTab("Higher Degree", "high"),
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
                              children: getBooks(snapshot, "Misc"),
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
    String contactPreference = "Call";
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      if ("All" == department && _semester == "All") {
        if (data['contact_preference'] == null) {
          contactPreference = "Call";
        } else {
          contactPreference = data['contact_preference'];
        }
        return Padding(
          padding: EdgeInsets.only(bottom: 3.0, top: 7.0),
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
            contactPreference: contactPreference,
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
            contactPreference: contactPreference,
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
            contactPreference: contactPreference,
          ),
        );
      } else if (data['department'] == department &&
          _semester == data['semester']) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 7.0),
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
            contactPreference: contactPreference,
          ),
        );
      } else {
        return const SizedBox(
          height: 0,
        );
      }
    }).toList();
  }

  Widget _buildTab(String title, String logo) {
    return SizedBox(
      height: 75.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Tab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (logo == "college")
                const CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/college_white.png"),
                ),
              if (logo == "cs")
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/cs.png"),
                ),
              if (logo == "phx")
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/phx.png"),
                ),
              if (logo == "mech")
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/mech.png"),
                ),
              if (logo == "chem")
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/chem.png"),
                ),
              if (logo == "dual")
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/dual.png"),
                ),
              if (logo == "high")
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/high.png"),
                ),
              if (logo == "misc")
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/book.png"),
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

  Widget _buildFilterPopUp(BuildContext context) {
    String semFilter = _semester;
    String orderByFilter = _orderBy;
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Scaffold(
        body: AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(
            "Filters",
            style: TextStyle(
                fontSize: 24,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold,
                color: _theme.secondaryColor),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 1.0,
                  ),
                  Text(
                    "Sem : ",
                    style: TextStyle(
                        fontFamily: _theme.font,
                        fontSize: 16,
                        color: _theme.secondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  DropdownButton<String>(
                    value: semFilter,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: _theme.tertiaryColor,
                    ),
                    iconSize: 22,
                    elevation: 16,
                    style: TextStyle(color: _theme.tertiaryColor),
                    underline: Container(
                      height: 2,
                      color: _theme.tertiaryColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        semFilter = newValue!;
                      });
                    },
                    items: <String>[
                      'All',
                      '1-1',
                      '1-2',
                      '2-1',
                      '2-2',
                      '3-1',
                      '3-2',
                      '4-1',
                      '4-2',
                      '5-1',
                      '5-2',
                      '-'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    width: 1.0,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 1.0,
                  ),
                  Text(
                    "Order By : ",
                    style: TextStyle(
                        fontFamily: _theme.font,
                        fontSize: 16,
                        color: _theme.secondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  DropdownButton<String>(
                    value: orderByFilter,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: _theme.tertiaryColor,
                    ),
                    iconSize: 22,
                    elevation: 16,
                    style: TextStyle(color: _theme.tertiaryColor),
                    underline: Container(
                      height: 2,
                      color: _theme.tertiaryColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        orderByFilter = newValue!;
                      });
                    },
                    items: <String>[
                      'Most Recent',
                      'Alphabetical',
                      'Seller Name Ascending',
                      'Seller Name Descending'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    width: 1.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () {
                  setFilter(semFilter, orderByFilter);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(
                      reason: SnackBarClosedReason.dismiss);
                  const snackBar = SnackBar(
                    content: Text("Filter applied >_<"),
                    duration: Duration(milliseconds: 700),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  "Set Filter",
                  style: TextStyle(
                    fontSize: 20,
                    color: _theme.tertiaryColor,
                  ),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.8)),
              )
            ],
          ),
        ),
      );
    });
  }

  setFilter(String semFilter, String orderByFilter) {
    setState(() {
      _semester = semFilter;
      _orderBy = orderByFilter;
    });
  }

  Widget _buildFilterRow(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext) => _buildFilterPopUp(context),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.filter_alt_rounded),
              Text(
                "Filters",
                style: TextStyle(
                    fontFamily: _theme.font,
                    fontSize: 12,
                    color: _theme.secondaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search),
              Text(
                "Search",
                style: TextStyle(
                    fontFamily: _theme.font,
                    fontSize: 12,
                    color: _theme.secondaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 15.0,
        )
      ],
    );
  }
}
