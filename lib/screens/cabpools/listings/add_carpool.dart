import 'package:bfg/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddCarpool extends StatefulWidget {
  const AddCarpool({Key? key}) : super(key: key);

  @override
  _AddCarpoolState createState() => _AddCarpoolState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
User? _user;

class _AddCarpoolState extends State<AddCarpool> {
  late CollectionReference pools;

  String _from = "";
  String _to = "";
  String _city = "";
  String _note = "";
  String _maxCapacity = "";
  late DateTime _date = DateTime.now();
  late DateTime _time = DateTime.now();
  String _timeSet = "Choose Time";
  String _dateSet = "Choose Date";
  late Map _initiator;
  String _how = "car";
  bool _withinGoaBool = false;
  final OurTheme _theme = OurTheme();
  final TextEditingController _controller = TextEditingController();

  Future<void> addCarpool(String name, String phone, String contactPreference) {
    _initiator = {'name': name, 'phone': phone};
    return pools.add({
      'city': _city,
      'from': _from,
      'date': _dateSet,
      'max_capacity': _maxCapacity,
      'to': _to,
      'time': _timeSet,
      'note': _note,
      'how': _how,
      'initiator': _initiator,
      'booked': "1",
      'pools': [],
      'inGoa': _withinGoaBool,
      'contact_preference': contactPreference,
    }).then((value) {
      const snackBar =
          SnackBar(content: Text("Your listing was added successfully"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      final snackBar = SnackBar(content: Text("Failed to add pool: $error"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Widget _buildTextFormField(
      String _label, String _hint, String fillIn, TextInputType inputType) {
    return TextFormField(
      onChanged: (text) {
        switch (fillIn) {
          case 'city':
            _city = text;
            break;
          case 'to':
            _to = text;
            break;
          case 'from':
            _from = text;
            break;
          case 'note':
            _note = text;
            break;
          default:
            break;
        }
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: _how == 'car' && fillIn == "city"
            ? 'City'
            : _how == 'flight' && fillIn == "city"
                ? 'Airlines Name/No.'
                : _how == "train" && fillIn == "city"
                    ? "Train Name/No."
                    : _label,
        hintText: _hint,
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
      keyboardType: inputType,
    );
  }

  Widget _buildCapacityFormField(
      String _label, String _hint, TextInputType inputType) {
    return TextFormField(
      controller: _controller,
      enableInteractiveSelection: false,
      onChanged: (text) {
        _maxCapacity = text;
      },
      maxLength: (_how == "car") ? 1 : 2,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: _label,
        hintText: _hint,
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
      keyboardType: inputType,
    );
  }

  Widget _buildAddPoolButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_from.isEmpty ||
              _city.isEmpty ||
              _to.isEmpty ||
              _maxCapacity.isEmpty ||
              _dateSet == "Choose Date" ||
              _timeSet == "Choose Time") {
            const snackBar =
                SnackBar(content: Text("Please fill the required fields"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext) => _buildPopupDialogue(context),
            );
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
            const Icon(Icons.car_rental),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              "Add Pool",
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

  Widget _buildInfoPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text(
        "thots",
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
          _textBox("City", "The city where the pool is supposed to happen"),
          SizedBox(
            height: 5,
          ),
          _textBox("From", "Starting point"),
          SizedBox(
            height: 5,
          ),
          _textBox("To", "Destination"),
          SizedBox(
            height: 5,
          ),
          _textBox("Max Poolmates",
              "The max number of poolmates youre comfortable with having"),
          SizedBox(
            height: 5,
          ),
          _textBox("How", "Choose your suitable way of travel"),
          SizedBox(
            height: 5,
          ),
          _textBox("In Goa", "This helps us filter search results later"),
          SizedBox(
            height: 5,
          ),
          _textBox("Note",
              "(Optional) Any extra info, regarding the pool, or life in general"),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _textBox(String title, String text) {
    return RichText(
      text: TextSpan(
          text: title + ": ",
          style: TextStyle(
              color: _theme.secondaryColor,
              fontSize: 16.0,
              fontFamily: _theme.font,
              fontWeight: FontWeight.w800),
          children: <TextSpan>[
            TextSpan(
                text: text,
                style: TextStyle(
                  color: _theme.tertiaryColor,
                  fontFamily: _theme.font,
                )),
          ]),
    );
  }

  Widget _buildPopupDialogue(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text(
        "IMPORTANT",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: _theme.secondaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "To avoid unnecessary calls, please remove your pool after the specified date has passed",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () async {
              String name = "";
              String phoneNumber = "";
              String contactPreference = "";

              DocumentSnapshot documentSnapshot = await FirebaseFirestore
                  .instance
                  .collection("users")
                  .doc(_user!.uid)
                  .get();
              if (documentSnapshot.exists) {
                name = (documentSnapshot.data() as dynamic)['name'];
                phoneNumber =
                    (documentSnapshot.data() as dynamic)['phone_number'];
                contactPreference =
                    (documentSnapshot.data() as dynamic)['contact_preference'];
              }
              addCarpool(name, phoneNumber, contactPreference);
              Navigator.popAndPushNamed(context, '/userMenu');
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

  @override
  Widget build(BuildContext context) {
    _user = _auth.currentUser;
    pools = FirebaseFirestore.instance.collection('pools');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        appBar: AppBar(
          backgroundColor: _theme.primaryColor,
          centerTitle: true,
          title: Text(
            "Add a Pool",
            style: TextStyle(
                fontFamily: _theme.font,
                fontWeight: FontWeight.bold,
                color: _theme.secondaryColor),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext) =>
                          _buildInfoPopupDialogue(context),
                    );
                  },
                  icon: Icon(Icons.info),
                  color: _theme.tertiaryColor,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 80.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildWhereDropDown(),
                      if (_how == "car")
                        Row(
                          children: [
                            Checkbox(
                                checkColor: _theme.primaryColor,
                                activeColor: _theme.secondaryColor,
                                value: _withinGoaBool,
                                onChanged: (value) {
                                  _withinGoaBool = value!;
                                  setState(() {
                                    !_withinGoaBool;
                                  });
                                }),
                            Text("Is the pool in Goa?",
                                style: TextStyle(
                                    fontFamily: _theme.font,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                    ],
                  ),
                  _buildTextFormField("City", "", 'city', TextInputType.name),
                  _buildTextFormField("From", "Where will the pool start from",
                      'from', TextInputType.name),
                  _buildTextFormField("To", "Where will the pool end", 'to',
                      TextInputType.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2022, 2, 2),
                              theme: DatePickerTheme(
                                  headerColor: _theme.secondaryColor,
                                  backgroundColor: _theme.primaryColor,
                                  itemStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle: TextStyle(
                                      color: _theme.primaryColor,
                                      fontSize: 16)), onChanged: (date) {
                            _date = date;
                            DateFormat _dateFormatter = DateFormat('yMMMd');
                            _dateSet = _dateFormatter.format(date);
                          }, onConfirm: (date) {
                            _date = date;
                            DateFormat _dateFormatter = DateFormat('yMMMd');
                            setState(() {
                              _dateSet = _dateFormatter.format(date);
                            });
                          }, currentTime: _date, locale: LocaleType.en);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: _theme.secondaryColor.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        child: Wrap(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              _dateSet,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: _theme.font,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            _time = date;
                            _timeSet = date.hour.toString() +
                                date.minute.toString() +
                                "hrs";
                          }, onConfirm: (date) {
                            _time = date;
                            setState(() {
                              _timeSet = date.hour.toString() +
                                  ":" +
                                  date.minute.toString() +
                                  "hrs";
                            });
                          }, currentTime: _time);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: _theme.secondaryColor.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        child: Wrap(
                          children: [
                            const Icon(
                              Icons.timer,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              _timeSet,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: _theme.font,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: _buildCapacityFormField(
                          "Max Poolmates", "", TextInputType.number),
                    ),
                  ),
                  _buildTextFormField("Note (Optional)", "Extra info (if any)",
                      'note', TextInputType.name),
                  _buildAddPoolButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWhereDropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "How: ",
          style: TextStyle(fontFamily: _theme.font, fontSize: 16),
        ),
        const SizedBox(
          width: 5,
        ),
        DropdownButton<String>(
          value: _how,
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
              _how = newValue!;
              _controller.clear();
            });
          },
          items: <String>["car", "flight", "train"]
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
