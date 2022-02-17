import 'package:bfg/screens/cabpools/listings/pool_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PoolListings extends StatefulWidget {
  const PoolListings({Key? key}) : super(key: key);

  @override
  _PoolListingsState createState() => _PoolListingsState();
}

class _PoolListingsState extends State<PoolListings> {
  late CollectionReference users;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  late Stream<QuerySnapshot> _booksStream;
  final OurTheme _theme = OurTheme();
  String _date = "";

  @override
  Widget build(BuildContext context) {
    _booksStream = FirebaseFirestore.instance
        .collection('pools')
        .orderBy('date', descending: false)
        .snapshots();

    _user = _auth.currentUser;
    users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          // centerTitle: true,
          backgroundColor: _theme.primaryColor,
          title: Text(
            "Pool Listings",
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
            length: 2,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: _theme.tertiaryColor,
                  tabs: [
                    _buildTab("Within Goa"),
                    _buildTab("42"),
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
                              children: getBooks(snapshot, "goa"),
                            ),
                            ListView(
                              children: getBooks(snapshot, "other"),
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

  getBooks(AsyncSnapshot<QuerySnapshot> snapshot, String _where) {
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      if (data['where'] == _where) {
        return Padding(
          padding: EdgeInsets.only(bottom: 3.0, top: 7.0),
          child: PoolDetailsCard(
            documentID: document.id,
            longPressBool: false,
            booked: data['booked'],
            city: data['city'],
            date: data['date'],
            from: data['from'],
            initiator: data['initiator'],
            maxCapacity: data['max_capacity'],
            note: data['note'],
            pools: data['pools'],
            to: data['to'],
            time: data['time'],
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
    String dateFilter = _date;
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        child: Scaffold(
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
                      "Date : datepicker",
                      style: TextStyle(
                          fontFamily: _theme.font,
                          fontSize: 16,
                          color: _theme.secondaryColor,
                          fontWeight: FontWeight.w600),
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
                    setFilter(dateFilter);
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
        ),
      );
    });
  }

  setFilter(String semFilter) {
    setState(() {
      _date = semFilter;
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
            Navigator.pushNamed(context, '/carpoolSearch');
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
