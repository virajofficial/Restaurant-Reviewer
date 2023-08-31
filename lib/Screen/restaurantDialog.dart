// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sized_box_test/Components/SearchableDropDown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../Components/datePicker.dart';
import 'RegisterPage.dart';
import '../Components/inputField.dart';

class RestaurantDialogue extends StatefulWidget {
  const RestaurantDialogue({super.key});

  @override
  State<RestaurantDialogue> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RestaurantDialogue> {
  String username = '';
  String password = '';
  final _popupCustomValidationKey = GlobalKey<DropdownSearchState<int>>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: const [
              Color.fromARGB(255, 194, 147, 102),
              Color.fromARGB(255, 216, 170, 139),
            ]),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                blurStyle: BlurStyle.outer,
                offset: Offset(0.1, 0.1),
                spreadRadius: 0,
                color: Colors.black45,
              )
            ]),
        width: 500,
        height: 700,
        constraints: const BoxConstraints(
          minHeight: 700,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add Restaurant',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      blurRadius: 3,
                      blurStyle: BlurStyle.outer,
                      color: Color.fromARGB(50, 0, 0, 0),
                    )
                  ],
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                type: 'text',
                labelText: 'Restaurant Name',
                onChange: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              InputField(
                type: 'text',
                labelText: 'Restaurant Reg No',
                onChange: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      type: 'number',
                      labelText: 'Contact No',
                      onChange: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  )
                ],
              ),
              DatePicker(
                labelText: 'Restaurant Reg Date',
                onChange: () {},
                type: 'dateTime',
              ),
              InputField(
                type: 'multiline',
                labelText: 'Address',
                onChange: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              SearchableDropdown(labelText: "PHI Area"),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF8947), Color(0xFFFF5C00)],
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 141, 52, 0),
                          spreadRadius: 2,
                          blurStyle: BlurStyle.inner,
                          blurRadius: 3,
                          offset: Offset(1, 2)),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    //elevation: 5,
                    minimumSize: const Size(370, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Submit PHI',
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, letterSpacing: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 71, 71),
                        Color.fromARGB(255, 255, 0, 0)
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 141, 0, 0),
                          spreadRadius: 2,
                          blurStyle: BlurStyle.inner,
                          blurRadius: 3,
                          offset: Offset(1, 2)),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    //elevation: 5,
                    minimumSize: const Size(370, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, letterSpacing: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
