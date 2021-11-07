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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
                      _buildRichText(),
                      _buildTextFormField("Name", "", TextInputType.name),
                      _buildDropdownRow(),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: _buildTextFormField("Room Number", "", TextInputType.number),
                        ),
                      ),
                      _buildTextFormField("Password", "Will be used to log in to your account later", TextInputType.visiblePassword),
                      _buildSignUpButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildTextFormField(String label, String hint, TextInputType keyboardType) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: _theme.secondaryColor),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _theme.secondaryColor, width: 1.3)),
      ),
      cursorColor: _theme.secondaryColor,
      style: TextStyle(
        fontFamily: _theme.font,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildRichText() {
    return RichText(
      text: TextSpan(
        text: "Enter Your Details",
        style: TextStyle(
            color: _theme.tertiaryColor,
            fontSize: 30.0,
            fontFamily: _theme.font,
            fontWeight: FontWeight.w800
        ),
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
              "SIGNUP",
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
}


