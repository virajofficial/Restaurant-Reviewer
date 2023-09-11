// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sized_box_test/Api/api.dart';
import 'package:sized_box_test/Components/SearchableDropDown.dart';
import 'package:sized_box_test/Screen/phiManage.dart';
import 'package:sized_box_test/models/phi.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../Components/alertDialog.dart';
import 'RegisterPage.dart';
import '../Components/inputField.dart';
import 'dashboard.dart';

class PhiDialogue extends StatefulWidget {
  const PhiDialogue(
      {super.key,
      required this.state,
      required this.details,
      required this.reloadPhis});

  final String state;
  final Phi details;
  final Function reloadPhis;

  @override
  State<PhiDialogue> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PhiDialogue> {
  final _formKey = GlobalKey<FormState>();

  String phiName = '';
  String phiRegNo = '';
  String phiEmail = '';
  String phiContactNo = '';
  String phiAddress = '';
  String phiArea = '';

  final _popupCustomValidationKey = GlobalKey<DropdownSearchState<int>>();
  final PHIManage ani = PHIManage();

  handleAddPhi() async {
    if (_formKey.currentState!.validate()) {
      try {
        var addPhiResponse = await addPHICall(
            phiName, phiRegNo, phiEmail, phiContactNo, phiAddress, phiArea);
        print('Add PHI Res = ');
        print(addPhiResponse);
        if (addPhiResponse['success'] = true) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          widget.reloadPhis();
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
      content: (widget.state == 'add')
          ? Container(
              // **********************************************************************Edit Phi Dialouge
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
                        'Add PHI',
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
                        labelText: 'PHI Name',
                        onChange: (value) {
                          setState(() {
                            phiName = value;
                          });
                        },
                      ),
                      InputField(
                        type: 'text',
                        labelText: 'PHI Reg No',
                        onChange: (value) {
                          setState(() {
                            phiRegNo = value;
                          });
                        },
                      ),
                      InputField(
                        type: 'email',
                        labelText: 'Email',
                        onChange: (value) {
                          setState(() {
                            phiEmail = value;
                          });
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputField(
                              type: 'tp',
                              labelText: 'Contact No',
                              onChange: (value) {
                                setState(() {
                                  phiContactNo = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          )
                        ],
                      ),
                      InputField(
                        type: 'multiline',
                        labelText: 'Address',
                        onChange: (value) {
                          setState(() {
                            phiAddress = value;
                          });
                        },
                      ),
                      SearchableDropdown(
                        type: 'searchableDD',
                        labelText: "PHI Area",
                        onChange: (value) {
                          setState(() {
                            phiArea = value;
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            //elevation: 5,
                            minimumSize: const Size(370, 50),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          onPressed: handleAddPhi,
                          child: const Text(
                            'Submit PHI',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            //elevation: 5,
                            minimumSize: const Size(370, 50),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(
              // **********************************************************************Edit Phi Dialouge
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
                      Container(
                        width: 200,
                        child: Text(
                          widget.details.phiName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'text',
                        labelText: 'PHI Name',
                        initialValue: widget.details.phiName,
                        onChange: (value) {
                          setState(() {
                            phiName = value;
                          });
                        },
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'text',
                        labelText: 'PHI Reg No',
                        initialValue: widget.details.phiRegNo,
                        onChange: (value) {
                          setState(() {
                            phiRegNo = value;
                          });
                        },
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'email',
                        labelText: 'Email',
                        initialValue: widget.details.phiEmail,
                        onChange: (value) {
                          setState(() {
                            phiEmail = value;
                          });
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputField(
                              mode: 'edit',
                              type: 'tp',
                              labelText: 'Contact No',
                              initialValue: widget.details.phiContactNo,
                              onChange: (value) {
                                setState(() {
                                  phiContactNo = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          )
                        ],
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'multiline',
                        labelText: 'Address',
                        initialValue: widget.details.phiAddress,
                        onChange: (value) {
                          setState(() {
                            phiAddress = value;
                          });
                        },
                      ),
                      SearchableDropdown(
                        mode: 'edit',
                        type: 'searchableDD',
                        labelText: "PHI Area",
                        initialValue: widget.details.phiArea,
                        onChange: (value) {
                          setState(() {
                            phiArea = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 178, 133),
                                      Color.fromARGB(255, 134, 87, 61)
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 158, 110, 83),
                                        spreadRadius: 2,
                                        blurStyle: BlurStyle.inner,
                                        blurRadius: 5,
                                        offset: Offset(0.5, 1)),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  //elevation: 5,
                                  //minimumSize: const Size(370, 50),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Save Changes',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFF8947),
                                      Color(0xFFFF5C00)
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 179, 87, 30),
                                        spreadRadius: 2,
                                        blurStyle: BlurStyle.inner,
                                        blurRadius: 3,
                                        offset: Offset(0.5, 1)),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  //elevation: 5,
                                  //minimumSize: const Size(370, 50),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Remove',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
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
                                        offset: Offset(0.5, 1)),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  //elevation: 5,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
