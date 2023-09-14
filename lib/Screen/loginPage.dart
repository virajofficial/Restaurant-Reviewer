import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/alertDialog.dart';
import 'package:restaurant_reviewer/Screen/RegisterPage.dart';
import 'package:restaurant_reviewer/Screen/dashboard.dart';
import 'package:restaurant_reviewer/Screen/restaurantReveiwsPage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Components/footer.dart';
import 'package:restaurant_reviewer/Components/inputField.dart';
import 'package:restaurant_reviewer/Components/navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  bool checkValue = false;
  bool obscureText = true;

  String username = '';
  String password = '';
  RegExp passwordRegEx =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        var loginResponse = await loginCall(username, password);
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
        }
      } catch (error) {
        if (error is DioException) {
          showMyDialog('Unable to login', error.response?.data['message']);
        }
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('../assets/images/Background_1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //Header Container
                  const NavBar(showLogout: false),
                  //Body Container
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(171, 255, 200, 171),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                            width: 6,
                            color: const Color(0xffFB8E51),
                          ),
                        ),
                        width: 500,
                        height: 500,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                Container(
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFF8947),
                                          Color(0xFFFF5C00)
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Color.fromARGB(255, 141, 52, 0),
                                            spreadRadius: 2,
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 10,
                                            offset: Offset(1, 2)),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      //elevation: 5,
                                      minimumSize: const Size(370, 50),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
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
                                      child: const Text('User Name/ Password',
                                          style: TextStyle(
                                            color: Color(0xFFFF5207),
                                            letterSpacing: 2,
                                            fontSize: 14,
                                          )),
                                      onTap: () => launchUrl(
                                          Uri.parse(
                                              'https://stackoverflow.com/questions/51545768/flutter-vertically-center-column'),
                                          webOnlyWindowName: '_self'),
                                    ),
                                    const Text(' ?',
                                        style: TextStyle(
                                          color: Color(0xFF664233),
                                          letterSpacing: 2,
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
