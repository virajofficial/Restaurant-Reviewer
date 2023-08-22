import 'dart:ui';

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, this.showLoginSignup = false});

  final bool showLoginSignup;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(146, 243, 218, 200),
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
        children: [
          Container(
              child: Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Image.asset(
                  '../assets/images/Logo.png',
                  color: Color.fromARGB(255, 255, 255, 255),
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
          Expanded(
            child: Container(),
          ),
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
                      onPressed: () {},
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
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
