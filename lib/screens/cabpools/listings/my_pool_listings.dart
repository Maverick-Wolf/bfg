import 'package:bfg/screens/cabpools/listings/pool_card.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPoolListings extends StatefulWidget {
  const MyPoolListings({Key? key}) : super(key: key);

  @override
  _MyPoolListingsState createState() => _MyPoolListingsState();
}

User? _user;
OurTheme _theme = OurTheme();

class _MyPoolListingsState extends State<MyPoolListings> {
  final Stream<QuerySnapshot> _poolssStream =
      FirebaseFirestore.instance.collection('pools').snapshots();
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.primaryColor,
        centerTitle: true,
        title: Text(
          "My Pools",
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
                    builder: (context) => _buildInfoPopupDialogue(context),
                  );
                },
                icon: const Icon(Icons.info),
                color: _theme.tertiaryColor,
              )),
        ],
      ),
      body: StreamBuilder(
          stream: _poolssStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
    );
  }

  getPools(AsyncSnapshot<QuerySnapshot> snapshot) {
    String contactPreference = "Whatsapp";
    return snapshot.data!.docs.map((DocumentSnapshot document) {
      List phoneNumbers = [];
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      for (Map map in data['pools']) {
        phoneNumbers.add(map['phone']);
      }
      if (_user!.phoneNumber == data['initiator']['phone'] ||
          phoneNumbers.contains(_user!.phoneNumber)) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
          child: PoolDetailsCard(
              initiator: data['initiator'],
              time: data['time'],
              pools: data["pools"],
              booked: data['booked'],
              city: data['city'],
              date: data['date'],
              from: data['from'],
              to: data['to'],
              note: data['note'],
              maxCapacity: data['max_capacity'],
              how: data['how'],
              documentID: document.id,
              contactPreference: contactPreference,
              longPressBool: true),
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
            "\nThese are pools you are a part of \n\nTo contact pool mates just tap on the item\n\nRemember to remove pools that have already been completed to avoid unnecessary calls\n\nTo delete or leave a pool, hold down on the item for 2 seconds and tap 'Delete/Leave' on the pop up box",
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
