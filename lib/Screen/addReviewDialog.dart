// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sized_box_test/Api/api.dart';
import 'package:sized_box_test/Components/SearchableDropDown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../Components/alertDialog.dart';
import 'RegisterPage.dart';
import '../Components/inputField.dart';

class AddReviewDialogue extends StatefulWidget {
  const AddReviewDialogue({
    super.key,
    required this.reloadReviews,
  });

  final Function reloadReviews;

  @override
  State<AddReviewDialogue> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddReviewDialogue> {
  final _formKey = GlobalKey<FormState>();
  String restaurant = '';
  String phiArea = '';
  String review = '';
  final _popupCustomValidationKey = GlobalKey<DropdownSearchState<int>>();

  handleAddReviews() async {
    if (_formKey.currentState!.validate()) {
      try {
        var addPhiResponse =
            await addReviewCall(1.toString(), review, 'good', phiArea);
        print('Add PHI Res = ');
        print(addPhiResponse);
        if (addPhiResponse['success'] = true) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          widget.reloadReviews();
        }
      } catch (error) {
        if (error is DioException) {
          print(error.response);
          showMyDialog('Unable to login', error.response?.data['message']);
        }
        return;
      }
    }
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Add Review',
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
                SearchableDropdown(
                    type: 'searchableDD',
                    labelText: 'Select A Restaurant',
                    onChange: (value) {
                      setState(() {
                        restaurant = value;
                      });
                    }),
                SearchableDropdown(
                    type: 'searchableDD',
                    labelText: 'Restaurant Location',
                    onChange: (value) {
                      setState(() {
                        phiArea = value;
                      });
                    }),
                InputField(
                  minMultilines: 7,
                  maxMultilines: 7,
                  type: 'multiline',
                  labelText: 'Enter Your Message...',
                  onChange: (value) {
                    setState(() {
                      review = value;
                    });
                  },
                ),
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
                    onPressed: handleAddReviews,
                    child: const Text(
                      'Submit Review',
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
      ),
    );
  }
}
