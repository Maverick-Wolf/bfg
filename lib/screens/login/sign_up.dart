import 'package:bfg/providers/login_providers/login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

OurTheme _theme = OurTheme();
FirebaseAuth _auth = FirebaseAuth.instance;
// bool isLoading = false;
late String _verificationId;
late String _phoneNumber;
String _otp = "";
bool isPhoneNumberTfVisible = true;
late BuildContext _context;


class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    _context = context;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRichText("Sign Up"),
                  _buildSizedBox(30),
                  isPhoneNumberTfVisible ? _buildPhoneNumberTF() : _buildOtpTF(),
                  _buildSizedBox(200),
                ],
              ),
            ),
            isPhoneNumberTfVisible ? _buildSendOtpButton() : _buildVerifyOtpButton(),
            if (!isPhoneNumberTfVisible) _buildResendOtpButton(),
            if (!isPhoneNumberTfVisible) _buildChangeNumberButton(),
          ],
        ),
      ),
    );
  }

  //Callback for when the user has already previously signed in with this phone number on this device
  PhoneVerificationCompleted verificationCompleted =
      (PhoneAuthCredential phoneAuthCredential) async {
    await _auth.signInWithCredential(phoneAuthCredential);
    print('Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}');
  };

  //Listens for errors with verification, such as too many attempts
  PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException authException) {
    print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
  };

  //Callback for when the code is sent
  PhoneCodeSent codeSent =
      (String verificationId, [int? forceResendingToken]) async {
    print('Please check your phone for the verification code.');
    _verificationId = verificationId;
  };

  PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    print("verification code: " + verificationId);
    _verificationId = verificationId;
  };

  verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      print("Failed to Verify Phone Number: ${e}");
    }
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otp,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      Navigator.pushNamed(_context, '/enterDetails');

      print("Successfully signed in UID: ${user!.uid}");
    } catch (e) {
      print("Failed to sign in: " + e.toString());
    }
  }

  Widget _buildSendOtpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          verifyPhoneNumber();
          setState(() {
            isPhoneNumberTfVisible = !isPhoneNumberTfVisible;
            FocusScope.of(context).unfocus();
          });
        },
        style: ElevatedButton.styleFrom(
            primary: _theme.secondaryColor.withOpacity(0.8),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )
        ),
        child: Wrap(
          children: [
            Icon(Icons.send),
            SizedBox(width: 10.0,),
            Text(
              "SEND OTP",
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: _theme.font,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberTF() {
    return TextFormField(
      initialValue: "",
      onChanged: (value) {
        _phoneNumber = "+91" + value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Phone Number",
        labelStyle: TextStyle(color: _theme.secondaryColor),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.secondaryColor, width: 1.3)),
      ),
      cursorColor: _theme.secondaryColor,
      style: TextStyle(
        fontFamily: _theme.font,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildOtpTF() {
    return TextFormField(
      initialValue: "",
      onChanged: (text) {
        _otp = text;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "OTP",
        labelStyle: TextStyle(color: _theme.secondaryColor),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.secondaryColor, width: 1.3)),
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
        onPressed: (){
          FocusScope.of(context).unfocus();
          signInWithPhoneNumber();
        },
        style: ElevatedButton.styleFrom(
            primary: _theme.secondaryColor.withOpacity(0.8),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )
        ),
        child: Wrap(
          children: [
            Icon(Icons.login_rounded),
            SizedBox(width: 10.0,),
            Text(
              "VERIFY OTP",
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: _theme.font,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResendOtpButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            FocusScope.of(context).unfocus();
          });
        },
        child: Text(
          "Resend OTP",
          style: TextStyle(
            fontFamily: _theme.font,
            color: _theme.secondaryColor,
          ),
        )
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
        )
    );
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
          fontWeight: FontWeight.w800
      ),
    ),
  );
}




