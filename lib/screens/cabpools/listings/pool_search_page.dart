import 'package:bfg/screens/cabpools/listings/pool_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PoolSearchPage extends StatefulWidget {
  const PoolSearchPage({Key? key}) : super(key: key);
  @override
  State<PoolSearchPage> createState() => _PoolSearchPageState();
}

OurTheme _theme = OurTheme();

class _PoolSearchPageState extends State<PoolSearchPage> {
  final Stream<QuerySnapshot> _poolsStream =
      FirebaseFirestore.instance.collection('pools').snapshots();
  String stringToBeSearched = "";

  @override
  Widget build(BuildContext context) {
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
                      builder: (_) => _buildInfoPopupDialogue(context),
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
                      stream: _poolsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                            children: getPools(snapshot),
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
        autofocus: true,
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
                    color: Colors.grey.withOpacity(0.3)),
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
            )),
        cursorColor: _theme.primaryColor,
        style: TextStyle(
            fontFamily: _theme.font,
            fontWeight: FontWeight.bold,
            color: _theme.primaryColor),
      ),
    );
  }

  getPools(AsyncSnapshot<QuerySnapshot> snapshot) {
    String contactPreference = 'Call';
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      if (data['contact_preference'].toString().isNotEmpty) {
        contactPreference = data['contact_preference'].toString();
      }
      if (data['to']
              .toString()
              .toLowerCase()
              .contains(stringToBeSearched.toLowerCase()) ||
          data['from']
              .toString()
              .toLowerCase()
              .contains(stringToBeSearched.toLowerCase()) ||
          data['city']
              .toString()
              .toLowerCase()
              .contains(stringToBeSearched.toLowerCase()) ||
          data['date']
              .toString()
              .toLowerCase()
              .contains(stringToBeSearched.toLowerCase()) ||
          data['note']
              .toString()
              .toLowerCase()
              .contains(stringToBeSearched.toLowerCase())) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
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
            how: data['how'],
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
            "\nYou can search the listings by city, date, To or From\n\nSearch with a blank text field to view all pools at once\n",
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
