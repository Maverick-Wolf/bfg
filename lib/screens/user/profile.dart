import 'package:bfg/widgets/drawer.dart';
import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  OurTheme _theme = OurTheme();
  late CollectionReference users;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  Widget build(BuildContext context) {
    _user = _auth.currentUser;
    users = FirebaseFirestore.instance.collection('users');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          backgroundColor: _theme.primaryColor,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold,
                color: _theme.secondaryColor),
          ),
        ),
        drawer: const DrawerClass(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: users.doc(_user!.uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }
                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const Text("Document does not exist");
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.transparent,
                                )),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                _buildRichText("Name", data['name']),
                                _buildRichText(
                                    "Phone Number", data['phone_number']),
                                _buildRichText("Hostel", data['hostel']),
                                _buildRichText(
                                    "Room Number", data['room_number']),
                                _buildRichText("Contact Preference",
                                    data['contact_preference'] ?? "Call"),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                _buildEditButton(),
                              ],
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: _theme.secondaryColor,
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(String title, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: title + ": ",
                  style: TextStyle(
                      color: _theme.secondaryColor,
                      fontSize: 20.0,
                      fontFamily: _theme.font,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: text,
                  style: TextStyle(
                    color: _theme.tertiaryColor,
                    fontFamily: _theme.font,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Divider(
            color: _theme.secondaryColor,
            thickness: 0.2,
          )
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          Navigator.pushNamed(context, '/enterDetails');
        },
        style: ElevatedButton.styleFrom(
            primary: _theme.secondaryColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Wrap(
          children: [
            const Icon(Icons.edit),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              "Edit Details",
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: _theme.font,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
