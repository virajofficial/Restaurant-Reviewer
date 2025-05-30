import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

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
                        ButtonBar(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.black,
                                elevation: 5,
                                backgroundColor: Color(0xFFF2B65B),
                                minimumSize: Size(120, 50),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                      ],
                    ),
                  ),

                  //Body Container
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            '../assets/images/Logo_Icon.png',
                            height: 150,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Welcome To',
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 7,
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'R',
                                style: TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 7,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'estaurant',
                                style: TextStyle(
                                  fontSize: 30,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 7,
                                  textBaseline: TextBaseline.ideographic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                ' R',
                                style: TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 7,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'eviewer',
                                style: TextStyle(
                                  fontSize: 30,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 7,
                                  textBaseline: TextBaseline.ideographic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 1500,
                            ),
                            child: const Text(
                              'Welcome to our website, where we help to PHI in Sri Lanka to navigate the Sri Lankan restaurants online reviews. And also, we give chance to add the customer\'s reviews. As PHI, you know that a bad review can have a serious impact on restaurant, that effects on customer badly. Therefore, we assist you  to identify those restaurants by using bad reviews.',
                              style: TextStyle(
                                fontSize: 16,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 3,
                                    offset: Offset(1, 1),
                                  )
                                ],
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Footer Container
                  //Here you will get unexpected behaviour when keyboard pops-up.
                  //So its better to use `bottomNavigationBar` to avoid this.
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
