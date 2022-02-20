import 'package:bfg/screens/cabpools/listings/pool_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class PoolListings extends StatefulWidget {
  const PoolListings({Key? key}) : super(key: key);

  @override
  _PoolListingsState createState() => _PoolListingsState();
}

class _PoolListingsState extends State<PoolListings> {
  late CollectionReference users;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  late Stream<QuerySnapshot> _poolsStream;
  final OurTheme _theme = OurTheme();
  DateTime _date = DateTime.now();
  String _dateSet = "";
  String _goaFilter = 'All';

  @override
  Widget build(BuildContext context) {
    _poolsStream = FirebaseFirestore.instance
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
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: _theme.tertiaryColor,
                  tabs: [
                    _buildTab("By Car"),
                    _buildTab("By Flight"),
                    _buildTab("By Train"),
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: _poolsStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return TabBarView(
                          children: [
                            ListView(
                              children: getpools(snapshot, "car"),
                            ),
                            ListView(
                              children: getpools(snapshot, "flight"),
                            ),
                            ListView(
                              children: getpools(snapshot, "train"),
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

  getpools(AsyncSnapshot<QuerySnapshot> snapshot, String _how) {
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      if (data['how'] == _how) {
        if (data['date'] == _dateSet && _goaFilter == 'All') {
          return detailsCard(document, data);
        } else if (data['date'] == _dateSet &&
            _goaFilter == 'Goa' &&
            data["inGoa"] == true) {
          return detailsCard(document, data);
        } else if (data['date'] == _dateSet &&
            _goaFilter == 'Other' &&
            data["inGoa"] == false) {
          return detailsCard(document, data);
        } else if (_dateSet == "" && _goaFilter == 'All') {
          return detailsCard(document, data);
        } else if (_dateSet == "" &&
            _goaFilter == 'Goa' &&
            data['inGoa'] == true) {
          return detailsCard(document, data);
        } else if (_dateSet == "" &&
            _goaFilter == 'Other' &&
            data['inGoa'] == false) {
          return detailsCard(document, data);
        } else {
          return const SizedBox(
            height: 0,
          );
        }
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
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPopUp(BuildContext context) {
    String dateFilter = _dateSet;
    String goaFilter = _goaFilter;
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
                      "Search in :",
                      style: TextStyle(
                          fontFamily: _theme.font,
                          fontSize: 16,
                          color: _theme.secondaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                    DropdownButton<String>(
                      value: goaFilter,
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
                          goaFilter = newValue!;
                        });
                      },
                      items: <String>[
                        'All',
                        'Goa',
                        'Other',
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
                TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2022, 2, 2),
                          theme: DatePickerTheme(
                              headerColor: _theme.secondaryColor,
                              backgroundColor: _theme.primaryColor,
                              itemStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle: TextStyle(
                                  color: _theme.primaryColor,
                                  fontSize: 16)), onChanged: (date) {
                        _date = date;
                        DateFormat _dateFormatter = DateFormat('yMMMd');
                        dateFilter = _dateFormatter.format(date);
                      }, onConfirm: (date) {
                        _date = date;
                        DateFormat _dateFormatter = DateFormat('yMMMd');
                        dateFilter = _dateFormatter.format(date);
                      }, currentTime: _date, locale: LocaleType.en);
                    },
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                          fontFamily: _theme.font,
                          fontSize: 16,
                          color: _theme.tertiaryColor,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    )),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                  onPressed: () {
                    setFilter(dateFilter, goaFilter);
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

  setFilter(String dateFilter, String goaFilter) {
    setState(() {
      _dateSet = dateFilter;
      _goaFilter = goaFilter;
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

  Widget detailsCard(DocumentSnapshot document, Map data) => Padding(
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
      ));
}
