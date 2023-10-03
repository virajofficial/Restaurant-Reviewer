import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/LoadingScreen.dart';
import 'package:restaurant_reviewer/Components/alertDialog.dart';
import 'package:restaurant_reviewer/Components/inputField.dart';
import 'package:restaurant_reviewer/Screen/loginDialog.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final _formKey = GlobalKey<FormState>();

  bool checkValue = false;

  RegExp passwordRegEx =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  //bool obscureText = true;

  String name = '';
  String contactNo = '';
  String email = '';
  String username = '';
  String password = '';
  String cPassword = '';

  bool isLoading = false;

  final passwordController = TextEditingController();

  handleRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = false;
        });
        var signupResponse =
            await registerCall(name, username, password, email, contactNo);
        setState(() {
          isLoading = false;
        });
        if (signupResponse['success'] = true) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          showAlertDialog(
            'Successfully Registered.!!',
            'Welcome, ${name.split(' ')[0]}',
            type: 'green',
            showLogin,
            themeColor: Color.fromARGB(255, 14, 199, 20),
          );
        }
      } catch (error) {
        if (error is DioException) {
          setState(() {
            isLoading = false;
          });
          showAlertDialog(
            'Unable to Register',
            error.response?.data['message'],
            () {},
            themeColor: Colors.red,
          );
        }
        return;
      }
    }
  }

  showLogin() {
    showDialog(
        context: context,
        builder: (BuildContext context) => const LoginDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          content: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
              maxHeight: 600,
              minWidth: 300,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(232, 255, 200, 171),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(
                width: 6,
                color: const Color(0xffFB8E51),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'User Register',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF96471A),
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          InputField(
                            type: "text",
                            labelText: 'Full Name',
                            onChange: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                          InputField(
                            type: 'tp',
                            labelText: 'Contact No',
                            onChange: (value) {
                              setState(() {
                                contactNo = value;
                              });
                            },
                          ),
                          InputField(
                            type: 'email',
                            labelText: 'Email',
                            onChange: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          InputField(
                            type: 'uname',
                            labelText: 'User Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Username';
                              }
                              return null;
                            },
                            onChange: (value) {
                              setState(() {
                                username = value;
                              });
                            },
                          ),
                          InputField(
                            type: 'password',
                            labelText: 'Password',
                            onChange: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              } else if (value.length < 8) {
                                return 'Password must have minimum 8 characters';
                              } else if (!passwordRegEx.hasMatch(value)) {
                                return 'Enter valid Password';
                              }
                              return null;
                            },
                          ),
                          InputField(
                            type: 'password',
                            labelText: 'Confirm Password',
                            onChange: (value) {
                              setState(() {
                                cPassword = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter confirm password';
                              } else if (passwordController.text != value) {
                                return 'Confirm password is not matching';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF8947), Color(0xFFFF5C00)],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 141, 52, 0),
                              spreadRadius: 2,
                              blurStyle: BlurStyle.inner,
                              blurRadius: 5,
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
                      onPressed: handleRegister,
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        isLoading ? const LoadingScreen(label: 'Loading ...') : Container(),
      ],
    );
  }
}
