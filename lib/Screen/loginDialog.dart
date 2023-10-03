import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/alertDialog.dart';
import 'package:restaurant_reviewer/Components/inputField.dart';
import 'package:restaurant_reviewer/Screen/dashboard.dart';
import 'package:restaurant_reviewer/Screen/forgotPasswordDialog.dart';
import 'package:restaurant_reviewer/Screen/phiDashboard.dart';
import 'package:restaurant_reviewer/Screen/phiRestaurantReviewesPage.dart';
import 'package:restaurant_reviewer/Screen/registerDialog.dart';
import 'package:restaurant_reviewer/Screen/restaurantReveiwsPage.dart';
import 'package:restaurant_reviewer/models/user.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _formKey = GlobalKey<FormState>();
  bool checkValue = false;
  bool obscureText = true;

  String username = '';
  String password = '';
  RegExp passwordRegEx =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  User currerntUser = User(name: '', userName: '', contactNo: '', email: '');

  handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        var loginResponse = await loginCall(username, password);
        await currentUserGet(loginResponse);
        //print(loginResponse['role']);
        if (loginResponse['role'] == 'user') {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RestaurantReviewsPage(),
            ),
          );
        } else if (loginResponse['role'] == 'admin') {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
          );
        } else if (loginResponse['role'] == 'phi') {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhiDashboard(
                phiArea: loginResponse['phiArea'],
              ),
            ),
          );
        }
      } catch (error) {
        if (error is DioException) {
          showAlertDialog(
              'Unable to login', error.response?.data['message'], () {},
              themeColor: Colors.red);
        }
        return;
      }
    }
  }

  currentUserGet(dynamic loginRes) async {
    try {
      dynamic user = await getCurrentUserCall(loginRes['id']);
      // setState(() {
      //   currerntUser = user;
      // });
    } catch (error) {
      if (error is DioException) {
        showAlertDialog(
          'Unable to Get User',
          error.response?.data['message'],
          () {},
          themeColor: Color(0xFFFF1B1B),
        );
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Container(
        constraints: const BoxConstraints(
          minWidth: 400,
          maxWidth: 500,
          maxHeight: 500,
        ),
        alignment: Alignment.center,
        child: Container(
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF96471A),
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    type: 'text',
                    labelText: 'User Name',
                    onChange: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                  ),
                  InputField(
                    type: 'password',
                    labelText: 'Password',
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
                    onChange: (value) {
                      setState(() {
                        password = value;
                      });
                    },
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
                                blurRadius: 10,
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
                        onPressed: handleLogin,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Forgot ',
                              style: TextStyle(
                                color: Color(0xFF664233),
                                letterSpacing: 2,
                                fontSize: 14,
                              )),
                          InkWell(
                            child: const Text('User Password',
                                style: TextStyle(
                                  color: Color(0xFFFF5207),
                                  letterSpacing: 2,
                                  fontSize: 14,
                                )),
                            onTap: () {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const ForgotPasswordDialog());
                            },
                          ),
                          const Text(' ?',
                              style: TextStyle(
                                color: Color(0xFF664233),
                                letterSpacing: 2,
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don’t have an account? ',
                            style: TextStyle(
                              color: Color(0xFF664233),
                              letterSpacing: 2,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            child: const Text('Register',
                                style: TextStyle(
                                  color: Color(0xFFFF5207),
                                  letterSpacing: 2,
                                  fontSize: 14,
                                )),
                            onTap: () {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const RegisterDialog());
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
