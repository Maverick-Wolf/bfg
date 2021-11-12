import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

OurTheme _theme = OurTheme();

class _DetailsState extends State<Details> {
  String hostelDropdown1 = "AH ";
  String hostelDropdown2 = "1";
  String _name = "";
  String _roomNumber= "";
  String _hostel= "";
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
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 5,
                    ),
                    _buildRichText(),
                    const Spacer(
                      flex: 5,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        _name = value;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Name",
                        labelStyle: TextStyle(color: _theme.secondaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: _theme.tertiaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _theme.secondaryColor, width: 1.3)),
                      ),
                      cursorColor: _theme.secondaryColor,
                      style: TextStyle(
                        fontFamily: _theme.font,
                        fontWeight: FontWeight.bold,
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    _buildDropdownRow(),
                    const Spacer(
                      flex: 2,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextFormField(
                          onChanged: (value) {
                            _roomNumber = value;
                          },
                          maxLength: 3,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Room Number",
                            labelStyle: TextStyle(color: _theme.secondaryColor),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: _theme.tertiaryColor)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _theme.secondaryColor, width: 1.3)),
                          ),
                          cursorColor: _theme.secondaryColor,
                          style: TextStyle(
                            fontFamily: _theme.font,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 6,
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    _buildSignUpButton(),
                    const Spacer(
                      flex: 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users.doc(_user!.uid)
        .set({
      'name': _name,
      'hostel': _hostel,
      'phone_number': _user!.phoneNumber,
      'room_number': _roomNumber,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Widget _buildRichText() {
    return RichText(
      text: TextSpan(
        text: "Enter Your Details",
        style: TextStyle(
            color: _theme.tertiaryColor,
            fontSize: 30.0,
            fontFamily: _theme.font,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _buildDropdownRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton<String>(
          value: hostelDropdown1,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: _theme.secondaryColor),
          underline: Container(
            height: 2,
            color: _theme.secondaryColor,
          ),
          onChanged: (String? newValue) {
            setState(() {
              hostelDropdown1 = newValue!;
            });
          },
          items: <String>['AH ', 'CH ', 'DH ']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        DropdownButton<String>(
          value: hostelDropdown2,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: _theme.secondaryColor),
          underline: Container(
            height: 2,
            color: _theme.secondaryColor,
          ),
          onChanged: (String? newValue) {
            setState(() {
              hostelDropdown2 = newValue!;
            });
          },
          items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          _hostel = hostelDropdown1 + hostelDropdown2;
          try{
            addUser();
            Navigator.pushReplacementNamed(context, '/userMenu');
          } catch(e) {
            print(e);
          }
        },
        style: ElevatedButton.styleFrom(
            primary: _theme.secondaryColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Text(
          "Lets Gooo!",
          style: TextStyle(
              fontSize: 18.0,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInfoPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text(
        "for privacy ke chode",
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
          Text("Your details won't be shared unless you list a book\n\n"
              "On listing a book, your name and hostel room number will be displayed\n\n"
              "Your phone number wont be displayed in the app itself, but an interested buyer can view it in their phone app"),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Oki",
              style: TextStyle(
                fontSize: 24,
                color: _theme.secondaryColor,
              ),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
          )
        ],
      ),
    );
  }
}

