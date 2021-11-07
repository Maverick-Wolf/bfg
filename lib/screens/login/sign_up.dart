import 'package:bfg/providers/login_providers/login_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  OurTheme _theme = OurTheme();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRichText(),
                  _buildSizedBox(30),
                  _buildUsernameTF(),
                  _buildSizedBox(17),
                  _buildPasswordTF(),
                  _buildSizedBox(70),
                ],
              ),
            ),
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText() {
    return RichText(
      text: TextSpan(
        text: "Sign Up",
        style: TextStyle(
            color: _theme.secondaryColor,
            fontSize: 30.0,
            fontFamily: _theme.font,
            fontWeight: FontWeight.w800
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          Navigator.pushReplacementNamed(context, '/');
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

  Widget _buildPasswordTF() {
    return TextFormField(
      initialValue: context.read<LoginProvider>().password,
      onChanged: (text) {
        context.read<LoginProvider>().setPassword(text);
      },
      obscureText: context.watch<LoginProvider>().obscurePassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "OTP",
        labelStyle: TextStyle(color: _theme.secondaryColor),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.secondaryColor, width: 1.3)),
        suffixIcon: IconButton(
          color: _theme.tertiaryColor,
          icon: Icon(Icons.remove_red_eye),
          onPressed: () {
            context.read<LoginProvider>().toggleObscurePassword();
            FocusScope.of(context).unfocus();
          },
          splashRadius: 15.0,
        ),
      ),
      cursorColor: _theme.secondaryColor,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }
}
