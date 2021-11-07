import 'package:bfg/theme.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {

  OurTheme _theme = OurTheme();
  String _edition = "1";
  String _semester = "2";
  String _department = "Misc";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sell a Book", style: TextStyle(fontFamily: _theme.font),),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext) => _buildPopupDialogue(context),
                    );
                  },
                  icon: Icon(Icons.info),
                  color: _theme.tertiaryColor,
                )),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTextFormField("Book Name", "Full Name of Book"),
                    _buildTextFormField("Author(s)", "Name(s) separated by commas"),
                    _buildDepartmentDropDown(),
                    _buildDropdownRow(),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: _buildTextFormField("Listing Price", "Your Selling Price"),
                      ),
                    ),
                    _buildTextFormField("Note", "Any extra info (if any)"),
                    _buildSellButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(String _label, String _hint) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: _label,
        hintText: _hint,
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
    );
  }

  Widget _buildDropdownRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Text(
              "Book Edition: ",
              style: TextStyle(
                fontFamily: _theme.font,
                fontSize: 16
              ),
            ),
            DropdownButton<String>(
              value: _edition,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 20,
              elevation: 16,
              style: TextStyle(color: _theme.secondaryColor),
              underline: Container(
                height: 2,
                color: _theme.secondaryColor,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _edition = newValue!;
                });
              },
              items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '-']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Semester: ",
              style: TextStyle(
                  fontFamily: _theme.font,
                  fontSize: 16
              ),
            ),
            DropdownButton<String>(
              value: _semester,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 20,
              elevation: 16,
              style: TextStyle(color: _theme.secondaryColor),
              underline: Container(
                height: 2,
                color: _theme.secondaryColor,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _semester = newValue!;
                });
              },
              items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '-']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDepartmentDropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Department: ",
          style: TextStyle(
              fontFamily: _theme.font,
              fontSize: 16
          ),
        ),
        SizedBox(width: 5,),
        DropdownButton<String>(
          value: _department,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 20,
          elevation: 16,
          style: TextStyle(color: _theme.secondaryColor),
          underline: Container(
            height: 2,
            color: _theme.secondaryColor,
          ),
          onChanged: (String? newValue) {
            setState(() {
              _department = newValue!;
            });
          },
          items: <String>['Comp Sc', 'Phoenix', 'Mechanical', 'Dual Degree', 'Chemical', 'Higher Deg', 'Misc']
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

  Widget _buildSellButton() {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext) => _buildPopupDialogue(context),
          );
        },
        style: ElevatedButton.styleFrom(
            primary: _theme.secondaryColor.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Wrap(
          children: [
            const Icon(Icons.sell),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              "Sell",
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

  Widget _buildPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("hahaahahahhaak")
            ],
          ),
        ],
      ),
    );
  }
}
