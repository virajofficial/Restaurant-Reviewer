// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/SearchableDropDown.dart';
import 'package:restaurant_reviewer/models/restaurant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../Components/alertDialog.dart';
import '../Components/datePicker.dart';
import '../Components/inputField.dart';

class RestaurantDialogue extends StatefulWidget {
  const RestaurantDialogue({
    super.key,
    required this.state,
    required this.details,
    required this.onReloadRestaurants,
  });

  final String state;
  final Restaurant details;
  final Function onReloadRestaurants;

  @override
  State<RestaurantDialogue> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RestaurantDialogue> {
  final _formKey = GlobalKey<FormState>();

  String resName = '';
  String resRegNo = '';
  String resContactNo = '';
  String resRegDate = '';
  String resAddress = '';
  String resPhiArea = '';

  final _popupCustomValidationKey = GlobalKey<DropdownSearchState<int>>();

  @override
  void initState() {
    resName = widget.details.resName;
    resRegNo = widget.details.resRegNo;
    resContactNo = widget.details.resContactNo;
    resRegDate = widget.details.resRegDate;
    resAddress = widget.details.resAddress;
    resPhiArea = widget.details.resPhiArea;
    super.initState();
  }

  handleAddRestaurant() async {
    if (_formKey.currentState!.validate()) {
      try {
        var addResResponse = await addRestaurantCall(resName, resRegNo,
            resContactNo, resRegDate, resAddress, resPhiArea);
        print('Add Restaurant Res = ');
        print(addResResponse);
        if (addResResponse['success'] = true) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          widget.onReloadRestaurants();
        }
      } catch (error) {
        print('add restaurant err');
        print(error);
        if (error is DioException) {
          print(error.response);
          showMyDialog('Unable to Add Restaurant',
              error.response?.data['message'], () {});
        }
        return;
      }
    }
  }

  handleEditRestaurant() async {
    if (_formKey.currentState!.validate()) {
      try {
        var editResResponse = await editRestaurantCall(widget.details.resId,
            resName, resContactNo, resAddress, resPhiArea);
        if (editResResponse['success'] = true) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          widget.onReloadRestaurants();
        }
      } catch (error) {
        if (error is DioException) {
          print(error.response);
          showMyDialog('Unable to Edit Restaurant',
              error.response?.data['message'], () {});
        }
        return;
      }
    }
  }

  handleRemoveRestaurant() async {
    if (_formKey.currentState!.validate()) {
      try {
        var removeResResponse =
            await removeRestaurantCall(widget.details.resId);
        if (removeResResponse['success'] = true) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          widget.onReloadRestaurants();
        }
      } catch (error) {
        if (error is DioException) {
          print(error.response);
          showMyDialog('Unable to Remove Restaurant',
              error.response?.data['message'], () {});
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
              // ************************************************************************add Restaurant
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
                            resName = value;
                          });
                        },
                      ),
                      InputField(
                        type: 'text',
                        labelText: 'Restaurant Reg No',
                        onChange: (value) {
                          setState(() {
                            resRegNo = value;
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
                                  resContactNo = value;
                                });
                              },
                            ),
                          ),
                          MediaQuery.of(context).size.width > 490
                              ? SizedBox(
                                  width: 100,
                                )
                              : Container(),
                        ],
                      ),
                      DatePicker(
                        labelText: 'Restaurant Reg Date',
                        onChange: (value) {
                          print('res date');
                          print(value);
                          setState(() {
                            resRegDate = value;
                          });
                        },
                        type: 'dateTime',
                      ),
                      InputField(
                        type: 'multiline',
                        labelText: 'Address',
                        onChange: (value) {
                          setState(() {
                            resAddress = value;
                          });
                        },
                      ),
                      SearchableDropdown(
                        type: 'searchableDD',
                        labelText: "PHI Area",
                        onChange: (value) {
                          setState(() {
                            resPhiArea = value;
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
                          onPressed: handleAddRestaurant,
                          child: const Text(
                            'Submit Restaurant',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 2),
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
              // ************************************************************************Edit Restaurant
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
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          widget.details.resName,
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
                        labelText: 'Restaurant Name',
                        initialValue: widget.details.resName,
                        onChange: (value) {
                          setState(() {
                            resName = value;
                          });
                        },
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'text',
                        labelText: 'Restaurant Reg No',
                        readOnly: true,
                        initialValue: widget.details.resRegNo,
                        onChange: (value) {
                          setState(() {
                            resRegNo = value;
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
                              initialValue: widget.details.resContactNo,
                              onChange: (value) {
                                setState(() {
                                  resContactNo = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          )
                        ],
                      ),
                      /*DatePicker(
                        mode: 'edit',
                        initialValue: widget.details.resRegDate,
                        labelText: 'Restaurant Reg Date',
                        onChange: (value) {
                          print('res date');
                          print(value);
                          setState(() {
                            resRegDate = value;
                          });
                        },
                        type: 'dateTime',
                      ),*/
                      InputField(
                        mode: 'edit',
                        type: 'text',
                        labelText: 'Restaurant Reg Date',
                        readOnly: true,
                        initialValue:
                            widget.details.resRegDate.substring(0, 10),
                        onChange: (value) {
                          setState(() {
                            resAddress = value;
                          });
                        },
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'multiline',
                        labelText: 'Address',
                        initialValue: widget.details.resAddress,
                        onChange: (value) {
                          setState(() {
                            resAddress = value;
                          });
                        },
                      ),
                      SearchableDropdown(
                        mode: 'edit',
                        type: 'searchableDD',
                        labelText: "PHI Area",
                        initialValue: widget.details.resPhiArea,
                        onChange: (value) {
                          setState(() {
                            resPhiArea = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
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
                                      Color.fromARGB(255, 175, 117, 85)
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
                                onPressed: handleEditRestaurant,
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
                                onPressed: handleRemoveRestaurant,
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
