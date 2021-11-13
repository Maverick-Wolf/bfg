import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

final OurTheme _theme = OurTheme();
String _feedback = "";
late CollectionReference feedbacks;
final FirebaseAuth _auth = FirebaseAuth.instance;
User? _user;

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {

    _user = _auth.currentUser;
    feedbacks = FirebaseFirestore.instance.collection('feedback');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          backgroundColor: _theme.primaryColor,
          centerTitle: true,
          title: Text(
            "Send Feedback",
            style: TextStyle(fontFamily: _theme.font, fontWeight: FontWeight.bold, color: _theme.secondaryColor),
          ),
        ),
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
                      flex: 3,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        _feedback = value;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Feedback",
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
                        fontSize: 20
                      ),
                      keyboardType: TextInputType.text,
                      maxLength: 100,
                      maxLines: 5,
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    _buildSendFeedbackButton(),
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

  Widget _buildSendFeedbackButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async{
          if(_feedback.isNotEmpty) {
            await sendFeedback();
            final snackBar = SnackBar(content: Text("Thank you for your invaluable feedback >_<", style: TextStyle(color: _theme.tertiaryColor)), backgroundColor: Colors.blue,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(content: Text("Kuch likh toh dete", style: TextStyle(color: _theme.tertiaryColor)), backgroundColor: Colors.blue,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          Navigator.pushReplacementNamed(context, '/userMenu');
        },
        style: ElevatedButton.styleFrom(
            primary: _theme.secondaryColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Text(
          "Send",
          style: TextStyle(
              fontSize: 18.0,
              fontFamily: _theme.font,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> sendFeedback() {
    return feedbacks.doc()
        .set({
      'feedback': _feedback,
      'user_id': _user!.uid,
    })
        .then((value) => print("Feedback sent"))
        .catchError((error) => print("Failed to send feedback: $error"));
  }
}
