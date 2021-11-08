import 'package:bfg/providers/login_providers/login_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

OurTheme _theme = OurTheme();

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
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
                  _buildUsernameTF(),
                  // _buildPasswordTF(),
                  _buildSizedBox(200),
                ],
              ),
            ),
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context, '/otpClass');
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

  Widget _buildUsernameTF() {
    return TextFormField(
      initialValue: context.read<LoginProvider>().username,
      onChanged: (text) {
        context.read<LoginProvider>().setUsername(text);
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
}

class OtpClass extends StatefulWidget {
  const OtpClass({Key? key}) : super(key: key);

  @override
  _OtpClassState createState() => _OtpClassState();
}

class _OtpClassState extends State<OtpClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.primaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRichText("Verify OTP"),
                _buildSizedBox(30),
                _buildOtpTF(),
                _buildSizedBox(200),
              ],
            ),
          ),
          _buildVerifyButton(),
          _buildSizedBox(10),
          _buildResendOtpButton(),
        ],
      ),
    );
  }

  Widget _buildOtpTF() {
    return TextFormField(
      onChanged: (text) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "OTP",
        labelStyle: TextStyle(color: _theme.secondaryColor),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.secondaryColor, width: 1.3)),
      ),
      cursorColor: _theme.secondaryColor,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildVerifyButton() {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context, '/enterDetails');
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
      onPressed: () {},
      child: Text(
        "Resend OTP",
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
