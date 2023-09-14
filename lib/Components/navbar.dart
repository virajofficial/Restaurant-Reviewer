import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_reviewer/Screen/RegisterPage.dart';
import 'package:restaurant_reviewer/Screen/loginPage.dart';
import 'package:restaurant_reviewer/Screen/startupPage.dart';

class NavBar extends StatelessWidget {
  const NavBar(
      {super.key,
      this.showLoginSignup = false,
      this.title = '',
      this.showLogout = true});

  final bool showLoginSignup;
  final bool showLogout;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 243, 218, 200),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      height: 70,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Image.asset(
                  '../assets/images/Logo.png',
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Image.asset('../assets/images/Logo.png'),
                ),
              )
            ],
          )),
          MediaQuery.of(context).size.width > 800
              ? Text(
                  title,
                  style: const TextStyle(
                      color: Color.fromARGB(225, 227, 82, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                )
              : Container(),
          showLoginSignup
              ? ButtonBar(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        elevation: 5,
                        backgroundColor: Color(0xFFF2B65B),
                        minimumSize: Size(120, 50),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        elevation: 5,
                        backgroundColor: Color(0xFFFF8947),
                        minimumSize: Size(120, 50),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              : (showLogout)
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        elevation: 5,
                        backgroundColor: Color(0xFFF2B65B),
                        minimumSize: Size(120, 50),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StartupPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(),
        ],
      ),
    );
  }
}
