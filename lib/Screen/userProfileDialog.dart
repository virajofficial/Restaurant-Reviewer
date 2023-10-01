import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/inputField.dart';
import 'package:restaurant_reviewer/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileDialog extends StatefulWidget {
  const UserProfileDialog({super.key, required this.userdata});

  final User userdata;

  @override
  State<UserProfileDialog> createState() => _UserProfileDialogState();
}

class _UserProfileDialogState extends State<UserProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  User currentUser = User(name: '', userName: '', contactNo: '', email: '');

  String fname = '';
  String userName = '';
  String email = '';
  String contactNo = '';

  getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUser =
          User.fromJson(jsonDecode(prefs.getString('user_profile') ?? '{}'));
    });
    print('current user');
    print(currentUser.email);
  }

  @override
  void initState() {
    //getUserProfile();
    super.initState();
  }

  handleEditUserData() async {
    if (_formKey.currentState!.validate()) {
      // try {
      //   var editPhiResponse = await editPHICall(
      //       widget.details.phiId, phiName, phiContactNo, phiAddress, phiArea);
      //   if (editPhiResponse['success'] = true) {
      //     // ignore: use_build_context_synchronously
      //     Navigator.pop(context);
      //     widget.reloadPhis();
      //   }
      // } catch (error) {
      //   if (error is DioException) {
      //     print(error.response);
      //     showMyDialog(
      //         'Unable to Edit PHI', error.response?.data['message'], () {});
      //   }
      //   return;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(colors: [
              Color.fromARGB(255, 194, 147, 102),
              Color.fromARGB(255, 216, 170, 139),
            ]),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                blurStyle: BlurStyle.outer,
                offset: Offset(0.1, 0.1),
                spreadRadius: 0,
                color: Colors.black45,
              )
            ]),
        width: 500,
        height: 600,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              child: const Text(
                'User Profile',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
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
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'text',
                        labelText: 'Full Name',
                        initialValue: widget.userdata.name,
                        onChange: (value) {
                          setState(() {
                            fname = value;
                          });
                        },
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'text',
                        labelText: 'User Name',
                        initialValue: widget.userdata.userName,
                        readOnly: true,
                        onChange: (value) {
                          setState(() {
                            userName = value;
                          });
                        },
                      ),
                      InputField(
                        mode: 'edit',
                        type: 'email',
                        labelText: 'Email',
                        initialValue: widget.userdata.email,
                        onChange: (value) {
                          setState(() {
                            email = value;
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
                              initialValue: widget.userdata.contactNo,
                              onChange: (value) {
                                setState(() {
                                  contactNo = value;
                                });
                              },
                            ),
                          ),
                          MediaQuery.of(context).size.width > 490
                              ? SizedBox(
                                  width: 80,
                                )
                              : Container()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 40,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 178, 133),
                        Color.fromARGB(255, 175, 117, 85)
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 158, 110, 83),
                          spreadRadius: 2,
                          blurStyle: BlurStyle.inner,
                          blurRadius: 5,
                          offset: Offset(0.5, 1)),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    //elevation: 5,
                    //minimumSize: const Size(370, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: handleEditUserData,
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, letterSpacing: 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 40,
                width: double.maxFinite,
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    //elevation: 5,
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
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
