import 'package:bfg/drawer/drawer.dart';
import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  OurTheme _theme = OurTheme();
  String hostelDropdown1 = 'AH ';
  String hostelDropdown2 = '2';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile", style: TextStyle(fontFamily: _theme.font),),
        ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextFormField("Name", "Rachit Champu"),
                      _buildTextFormField("Phone Number", "9876543210"),
                      _buildDropdownRow(),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: _buildTextFormField("Room Number", "344"),
                        ),
                      ),
                      _buildTextFormField("Password", "abracadabra"),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
  Widget _buildTextFormField(String label, String _initialValue) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(color: _theme.secondaryColor),
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: _theme.tertiaryColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: _theme.secondaryColor, width: 1.3)),
      ),
      initialValue: _initialValue,
      cursorColor: _theme.secondaryColor,
      style: TextStyle(
        fontFamily: _theme.font,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.name,
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
}
