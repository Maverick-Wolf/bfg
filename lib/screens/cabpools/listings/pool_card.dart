import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bfg/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PoolDetailsCard extends StatefulWidget {
  final Map initiator;
  final List pools;
  final String booked;
  final String city;
  final String date;
  final String from;
  final String to;
  final String note;
  final String time;
  final String maxCapacity;
  final String documentID;
  final bool longPressBool;
  final String contactPreference;

  const PoolDetailsCard({
    Key? key,
    required this.initiator,
    required this.time,
    required this.pools,
    required this.booked,
    required this.city,
    required this.date,
    required this.from,
    required this.to,
    required this.note,
    required this.maxCapacity,
    required this.documentID,
    required this.longPressBool,
    required this.contactPreference,
  }) : super(key: key);

  @override
  _PoolDetailsCardState createState() => _PoolDetailsCardState();
}

User? _user;
OurTheme _theme = OurTheme();
late double _width;
late CollectionReference users;
String _username = "";

class _PoolDetailsCardState extends State<PoolDetailsCard> {
  @override
  Widget build(BuildContext context) {
    _user = FirebaseAuth.instance.currentUser;
    users = FirebaseFirestore.instance.collection('users');
    _width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Center(
        child: Container(
          width: _width * 0.96,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                spreadRadius: 16,
                color: Colors.black.withOpacity(0.1),
              )
            ],
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.black12.withOpacity(0.5),
              Colors.grey.withOpacity(0.45),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                decoration: BoxDecoration(
                    color: _theme.tertiaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        width: 1.5,
                        color: _theme.tertiaryColor.withOpacity(0.4))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _buildRichText(
                            "Initiator: ", widget.initiator['name'], 15),
                      ),
                      const SizedBox(width: 4),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildTitle(widget.date, 20),
                      _buildTitle(widget.city, 24),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRichText("From: ", widget.from, 15),
                                _buildRichText("To: ", widget.to, 15),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                _buildRichText(
                                    "Capacity: ",
                                    widget.booked.toString() +
                                        "/" +
                                        widget.maxCapacity.toString(),
                                    15),
                                const SizedBox(
                                  height: 3,
                                ),
                                _buildRichText("Time: ", widget.time, 15),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (widget.note.isNotEmpty)
                        _buildRichText("Note: ", widget.note, 12),
                    ],
                  ),
                )),
          ),
        ),
      ),
      onTap: () {
        if (widget.longPressBool) {
          showDialog(
              context: context,
              builder: (context) => _buildLongPressPopupDialogue(context));
        } else {
          showDialog(
              context: context,
              builder: (context) => _buildPopupDialogue(context));
        }
      },
      onLongPress: () async {
        String initiatorphoneNumber = "";
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection("pools")
            .doc(widget.documentID)
            .get();
        if (documentSnapshot.exists) {
          initiatorphoneNumber =
              (documentSnapshot.data() as dynamic)['initiator']['phone'];
        }
        List _poolsPhoneNumber = [];
        for (Map map in widget.pools) {
          _poolsPhoneNumber.add(map['phone']);
        }
        CollectionReference pools =
            FirebaseFirestore.instance.collection('pools');
        if ((widget.longPressBool &&
            _user!.phoneNumber == initiatorphoneNumber)) {
          showDialog(
              context: context,
              builder: (context) =>
                  _deletePoolConfirmationPopUp(context, pools));
        } else if (_poolsPhoneNumber.contains(_user!.phoneNumber)) {
          showDialog(
              context: context,
              builder: (context) => _leaveConfirmationPopUp(context, pools));
        }
      },
    );
  }

  Widget _leaveConfirmationPopUp(
      BuildContext context, CollectionReference pools) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Center(
        child: Text(
          "Leave",
          style: TextStyle(
              color: _theme.secondaryColor,
              letterSpacing: 0.7,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tapping leave will make you leave this pool, you can join back the pool later if you want",
            style: TextStyle(
                color: _theme.tertiaryColor,
                letterSpacing: 0.7,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red.withOpacity(0.8),
                onPrimary: _theme.tertiaryColor),
            onPressed: () async {
              widget.pools.removeWhere(
                  (element) => element['phone'] == _user!.phoneNumber);
              await FirebaseFirestore.instance
                  .collection('pools')
                  .doc(widget.documentID)
                  .update({
                'pools': widget.pools,
                'booked': (int.parse(widget.booked) - 1).toString()
              });
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text("Leave"),
          )
        ],
      ),
    );
  }

  Widget _deletePoolConfirmationPopUp(
      BuildContext context, CollectionReference pools) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Center(
        child: Text(
          "DELETE?",
          style: TextStyle(
              color: _theme.secondaryColor,
              letterSpacing: 0.7,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tapping delete will remove all instances of this listing\nThis action cannot be undone",
            style: TextStyle(
                color: _theme.tertiaryColor,
                letterSpacing: 0.7,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red.withOpacity(0.8),
                onPrimary: _theme.tertiaryColor),
            onPressed: () {
              deletePools(pools);
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text("Delete"),
          )
        ],
      ),
    );
  }

  Future<void> deletePools(CollectionReference pools) {
    return pools.doc(widget.documentID).delete().then((value) {
      const snackBar =
          SnackBar(content: Text('Your listing was deleted successfully :D'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      final snackBar =
          SnackBar(content: Text("Failed to delete pool ;-; ... $error"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Widget _buildTitle(String bookTitle, double fontSize) {
    return Text(
      bookTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        letterSpacing: 1,
        fontFamily: _theme.font,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRichText(String text1, String text2, double _fontSize) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.45),
      child: RichText(
        text: TextSpan(
            text: text1,
            style: TextStyle(
              color: _theme.secondaryColor,
              fontFamily: _theme.font,
              fontWeight: FontWeight.w600,
              fontSize: _fontSize,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: text2,
                  style: TextStyle(
                      color: _theme.tertiaryColor,
                      fontFamily: _theme.font,
                      fontWeight: FontWeight.w400)),
            ]),
      ),
    );
  }

  Widget _buildPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildTitle(widget.date, 20),
          _buildTitle(widget.city, 24),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText("Initiator: ", widget.initiator['name'], 15),
                    _buildRichText("Pools:", "", 14),
                    for (Map map in widget.pools)
                      widget.pools.isNotEmpty
                          ? _buildRichText("• ", map["name"], 13)
                          : const SizedBox(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildRichText("From: ", widget.from, 14),
                    _buildRichText("To: ", widget.to, 14),
                    _buildRichText(
                        "Capacity: ",
                        widget.booked.toString() +
                            "/" +
                            widget.maxCapacity.toString(),
                        14),
                    const SizedBox(
                      height: 3,
                    ),
                    _buildRichText("Time: ", widget.time, 14),
                  ],
                ),
              ],
            ),
          ),
          if (widget.note.isNotEmpty) _buildRichText("Note: ", widget.note, 12),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  if (widget.contactPreference == "Whatsapp") {
                    openWhatsapp(widget.initiator['phone']);
                  } else if (widget.contactPreference == "Call") {
                    _makePhoneCall('tel:${widget.initiator['phone']}',
                        '${widget.initiator['phone']}');
                  } else {
                    _makePhoneCall('tel:${widget.initiator['phone']}',
                        '${widget.initiator['phone']}');
                  }
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: _theme.primaryColor,
                          offset: Offset.fromDirection(1, 1),
                          blurRadius: 1)
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Contact Initiator",
                      style: TextStyle(
                          fontFamily: _theme.font,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _theme.tertiaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async {
                  await users
                      .doc(_user!.uid)
                      .get()
                      .then((value) => _username = value['name']);
                  List _poolsphoneNumbers = [];
                  for (Map map in widget.pools) {
                    _poolsphoneNumbers.add(map['phone']);
                  }
                  List _pools = widget.pools;
                  _pools.add({
                    'name': _username,
                    'phone': _user!.phoneNumber.toString()
                  });
                  if (int.parse(widget.booked) <=
                          int.parse(widget.maxCapacity) &&
                      _user!.phoneNumber != widget.initiator['phone'] &&
                      !_poolsphoneNumbers.contains(_user!.phoneNumber)) {
                    try {
                      await FirebaseFirestore.instance
                          .collection('pools')
                          .doc(widget.documentID)
                          .update({
                        'pools': _pools,
                        'booked': (int.parse(widget.booked) + 1).toString()
                      });
                    } catch (e) {
                      const snackBar =
                          SnackBar(content: Text('Couldn\'t join pool :('));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    const snackBar =
                        SnackBar(content: Text('Can\'t join pool'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: _theme.primaryColor,
                          offset: Offset.fromDirection(1, 1),
                          blurRadius: 1)
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Join pool",
                      style: TextStyle(
                          fontFamily: _theme.font,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _theme.tertiaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLongPressPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildTitle(widget.date, 20),
          _buildTitle(widget.city, 24),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText("Initiator: ", widget.initiator['name'], 15),
                    _buildRichText("Pools:", "", 14),
                    for (Map map in widget.pools)
                      widget.pools.isNotEmpty
                          ? _buildRichText("• ", map["name"], 13)
                          : const SizedBox(),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildRichText("From: ", widget.from, 14),
                    _buildRichText("To: ", widget.to, 14),
                    _buildRichText(
                        "Capacity: ",
                        widget.booked.toString() +
                            "/" +
                            widget.maxCapacity.toString(),
                        14),
                    const SizedBox(
                      height: 3,
                    ),
                    _buildRichText("Time: ", widget.time, 14),
                  ],
                ),
              ],
            ),
          ),
          if (widget.note.isNotEmpty) _buildRichText("Note: ", widget.note, 12),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => _poolMatesPopUp(context));
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
              decoration: BoxDecoration(
                color: Colors.amberAccent[700],
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: _theme.primaryColor,
                      offset: Offset.fromDirection(1, 1),
                      blurRadius: 1)
                ],
              ),
              child: Center(
                child: Text(
                  "Contact Pool Mates",
                  style: TextStyle(
                      fontFamily: _theme.font,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _theme.tertiaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _poolMatesPopUp(BuildContext context) {
    List _pools = [];
    _pools.add(widget.initiator);
    _pools.addAll(widget.pools);
    return AlertDialog(
      backgroundColor: Colors.grey,
      content: SizedBox(
        height: 400.0,
        width: 300.0,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _pools.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  _pools[index]['name'],
                  style: TextStyle(
                      color: _theme.secondaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    openWhatsapp(_pools[index]['phone']);
                  },
                  child: Container(
                    child: Text("Contact"),
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: _pools[index]['phone']));
                      const snackBar = SnackBar(
                        content:
                            Text('Seller phone number copied to clipboard'),
                        duration: Duration(seconds: 4),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Colors.black,
                    ))
              ],
            );
          },
        ),
      ),
    );
  }

  openWhatsapp(String _phoneNumber) async {
    var whatsappURl = "whatsapp://send?phone=" + _phoneNumber + "&text=";
    try {
      launch(whatsappURl);
    } catch (e) {
      _makePhoneCall('tel:$_phoneNumber', _phoneNumber);
    }
  }

  Future<void> _makePhoneCall(String url, String _phoneNumber) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      Clipboard.setData(ClipboardData(text: _phoneNumber));
      const snackBar = SnackBar(
        content: Text('Seller phone number copied to clipboard'),
        duration: Duration(seconds: 4),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
