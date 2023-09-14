import 'dart:ui';
import 'package:restaurant_reviewer/Screen/loginPage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_reviewer/Components/footer.dart';
import 'package:restaurant_reviewer/Components/inputField.dart';
import 'package:restaurant_reviewer/Components/navbar.dart';

import '../Api/api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controller = TextEditingController(text: '');
  TextEditingController conPControlelr = TextEditingController(text: '');
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

  final passwordController = TextEditingController();

  handleRegister() async {
    if (_formKey.currentState!.validate()) {
      var signupResponse =
          await registerCall(name, username, password, email, contactNo);
      if (signupResponse['success'] = true) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
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
                      padding: const EdgeInsets.symmetric(vertical: 20),
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
                        height: 700,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'User Register',
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
                                    } else if (passwordController.text !=
                                        value) {
                                      return 'Confirm password is not matching';
                                    }
                                    return null;
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
                                const SizedBox(
                                  height: 40,
                                ),
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
