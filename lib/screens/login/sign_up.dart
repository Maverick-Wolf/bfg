import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

OurTheme _theme = OurTheme();
FirebaseAuth _auth = FirebaseAuth.instance;
late String _verificationId;
late String _phoneNumber;
String _otp = "";
bool isPhoneNumberTfVisible = true;
late BuildContext _context;
late Timer _timer;
int _start = 60;
bool resendOtpButtonActivated = false;
String _bitsID = "";

class _SignUpState extends State<SignUp> {
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRichText("Sign In"),
                  _buildSizedBox(30),
                  isPhoneNumberTfVisible
                      ? _buildPhoneNumberTF()
                      : _buildOtpTF(),
                  isPhoneNumberTfVisible ? _buildBitsIdTF() : const SizedBox(),
                ],
              ),
            ),
            Column(
              children: [
                isPhoneNumberTfVisible
                    ? _buildSendOtpButton()
                    : _buildVerifyOtpButton(),
                if (!isPhoneNumberTfVisible) _buildResendOtpButton(),
                if (!isPhoneNumberTfVisible) _buildChangeNumberButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Callback for when the user has already previously signed in with this phone number on this device
  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    await _auth.signInWithCredential(phoneAuthCredential);
    if (kDebugMode) {
      print(
          'Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}');
    }
  }

  //Listens for errors with verification, such as too many attempts
  void verificationFailed(FirebaseAuthException authException) {
    if (kDebugMode) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    }
  }

  //Callback for when the code is sent
  void codeSent(String verificationId, [int? forceResendingToken]) async {
    if (kDebugMode) {
      print('Please check your phone for the verification code.');
    }
    _verificationId = verificationId;
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    if (kDebugMode) {
      print("verification code: " + verificationId);
    }
    _verificationId = verificationId;
  }

  verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      final snackBar =
          SnackBar(content: Text("Failed to Verify Phone Number: $e"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  // hello

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otp,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      _checkIfUserExists(user);
      isPhoneNumberTfVisible = !isPhoneNumberTfVisible;
    } catch (e) {
      const snackBar = SnackBar(content: Text("Failed to sign in"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future _checkIfUserExists(User? user) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    try {
      if (((documentSnapshot.data() as dynamic)['name'])
          .toString()
          .isNotEmpty) {
        Navigator.pushReplacementNamed(_context, '/userMenu');
        const snackBar = SnackBar(
          content: Text("aur bhai ki haal chaal"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      Navigator.pushReplacementNamed(_context, '/enterDetails');
      const snackBar = SnackBar(content: Text("ghot spotted"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildSendOtpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_bitsID.toLowerCase().endsWith('g') && _bitsID.length > 10) {
            if (_phoneNumber.length == 13) {
              showDialog(
                  context: context,
                  builder: (_) => _buildPopupDialogue(context));
              setState(() {
                FocusScope.of(context).unfocus();
              });
            } else {
              const snackBar = SnackBar(content: Text("Invalid phone number"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            const snackBar = SnackBar(
                content: Text(
                    "Sowwy, this app is available only for students from BPGC at the moment :p"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        style: ElevatedButton.styleFrom(
            primary: _theme.secondaryColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Wrap(
          children: [
            const Icon(Icons.send),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              "SEND OTP",
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

  Widget _buildPhoneNumberTF() {
    return TextFormField(
      initialValue: "",
      key: const ValueKey("test"),
      maxLength: 10,
      onChanged: (value) {
        _phoneNumber = "+91" + value;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Phone Number",
        labelStyle: TextStyle(color: _theme.secondaryColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _theme.secondaryColor, width: 1.3)),
      ),
      cursorColor: _theme.secondaryColor,
      style: TextStyle(
        fontFamily: _theme.font,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildBitsIdTF() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: TextFormField(
        initialValue: "",
        key: const ValueKey("test4"),
        onChanged: (value) {
          _bitsID = value;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "BITS ID",
          labelStyle: TextStyle(color: _theme.secondaryColor),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _theme.tertiaryColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _theme.secondaryColor, width: 1.3)),
        ),
        cursorColor: _theme.secondaryColor,
        style: TextStyle(
          fontFamily: _theme.font,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOtpTF() {
    return TextFormField(
      initialValue: "",
      maxLength: 6,
      onChanged: (text) {
        _otp = text;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "OTP",
        labelStyle: TextStyle(color: _theme.secondaryColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _theme.secondaryColor, width: 1.3)),
      ),
      style: TextStyle(
        fontFamily: _theme.font,
        fontWeight: FontWeight.bold,
      ),
      cursorColor: _theme.secondaryColor,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildVerifyOtpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          signInWithPhoneNumber();
        },
        style: ElevatedButton.styleFrom(
            primary: _theme.secondaryColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Wrap(
          children: [
            const Icon(Icons.login_rounded),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              "VERIFY OTP",
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

  Widget _buildResendOtpButton() {
    return TextButton(
        onPressed: () {
          if (_start == 0) {
            setState(() {
              _start = 60;
              resendOtpButtonActivated = false;
            });
            verifyPhoneNumber();
            startTimer();
          }
          setState(() {
            FocusScope.of(context).unfocus();
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Resend OTP in",
              style: TextStyle(
                fontFamily: _theme.font,
                color: resendOtpButtonActivated
                    ? _theme.secondaryColor
                    : Colors.white54,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "$_start",
              style: TextStyle(
                fontFamily: _theme.font,
                color: _theme.secondaryColor,
              ),
            ),
          ],
        ));
  }

  Widget _buildPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text(
        "IMPORTANT",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _theme.secondaryColor,
          fontFamily: _theme.font,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You may be prompted to open a browser\n\nKindly allow and wait for a few secs",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 18,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "\n\nThe process is used to verify your phone number and will not last more than a few seconds",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black54,
                letterSpacing: 1,
                fontSize: 10,
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.red.withOpacity(0.8),
                onPrimary: _theme.tertiaryColor),
            onPressed: () {
              setState(() {
                isPhoneNumberTfVisible = !isPhoneNumberTfVisible;
                _start = 60;
              });
              verifyPhoneNumber();
              startTimer();
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            resendOtpButtonActivated = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Widget _buildChangeNumberButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isPhoneNumberTfVisible = true;
            FocusScope.of(context).unfocus();
          });
        },
        child: Text(
          "Change Phone Number",
          style: TextStyle(
            fontFamily: _theme.font,
            color: _theme.secondaryColor,
          ),
        ));
  }
}

Widget _buildSizedBox(double height) {
  return SizedBox(
    height: height,
  );
}

Widget _buildRichText(String title) {
  return RichText(
    text: TextSpan(
      text: title,
      style: TextStyle(
          color: _theme.secondaryColor,
          fontSize: 30.0,
          fontFamily: _theme.font,
          fontWeight: FontWeight.w800),
    ),
  );
}
