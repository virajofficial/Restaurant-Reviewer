import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sized_box_test/Api/api.dart';
import 'package:sized_box_test/Components/footer.dart';
import 'package:sized_box_test/Components/navbar.dart';

import '../models/pihArea.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  //List<String> locations = [];
  static List<String> locations = [];

  // getPHIAreas() async {
  //   String response = await getPHIAreasCall();
  //   locations = json.decode(response).cast<String>().toList();
  //   print(locations);
  //   setState(() {
  //     locations = json.decode(response).cast<String>().toList();
  //   });
  // }

  // @override
  // void initState() {
  //   getPHIAreas();
  //   print("locations ");
  //   super.initState();
  // }

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
                  const NavBar(
                    showLoginSignup: true,
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
