import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  Container(
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
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Image.asset('../assets/images/Logo.png'),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
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
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
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
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 16,
                              ),
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Color(0xFFAA684B),
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  labelText: 'User Name',
                                  labelStyle: TextStyle(
                                    color: Color(0xFFAA684B),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: 40,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(118, 255, 211, 186),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText:
                                      String.fromEnvironment('Password '),
                                  constraints: BoxConstraints(
                                    maxHeight: 40,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(118, 255, 211, 186),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Footer Container
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF9C6339),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.black,
                            blurStyle: BlurStyle.outer,
                          ),
                        ]),
                    padding: const EdgeInsets.all(8.0),
                    height: 100,
                    alignment: Alignment.center,
                    child: Text("Footer"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
