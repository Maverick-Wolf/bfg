import 'package:bfg/screens/listings/book_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Listings extends StatefulWidget {
  Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {

  late CollectionReference users;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  final Stream<QuerySnapshot> _booksStream = FirebaseFirestore.instance.collection('books').snapshots();

  @override
  Widget build(BuildContext context) {

    _user = _auth.currentUser;
    users = FirebaseFirestore.instance.collection('users');
    OurTheme _theme = OurTheme();

    return Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: _theme.secondaryColor.withOpacity(0.8),
          title: Text(
            "Book Listings",
            style: TextStyle(
              color: _theme.tertiaryColor,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.menu,
                  color: _theme.tertiaryColor,
                )),
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
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("All"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("CS"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Phoenix"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Mechanical"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Chemical"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Dual Degree"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Higher Degree"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/college.png"),
                              ),
                              Text("Misc"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      //ALL
                      StreamBuilder<QuerySnapshot>(
                        stream: _booksStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: BookDetailsCard(
                                    bookEdition: data['edition'],
                                    roomNumberOfSeller: data['semester'],
                                    note: data['note'],
                                    semester: data['semester'],
                                    priceOfBook: data['price'],
                                    nameOfSeller: data['edition'],
                                    nameOfBook: data['title'],
                                    bookAuthor: data['author'],
                                    department: data['department'],
                                  ),
                                );
                              });
                            }
                          );
                        },
                      ),
                      // ListView.builder(
                      //   itemCount: 10,
                      //   itemBuilder: (context, index) {
                      //     return const Padding(
                      //       padding: EdgeInsets.only(bottom: 10.0),
                      //       child: Text,
                      //     );
                      //   },
                      // ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text("hi"),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text("hi"),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text("hi"),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text("hi"),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text("hi"),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text("hi"),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text("hi"),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
