import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sized_box_test/Components/footer.dart';
import 'package:sized_box_test/Components/inputField.dart';
import 'package:sized_box_test/Components/navbar.dart';

class RestaurantReviewsPage extends StatelessWidget {
  const RestaurantReviewsPage({super.key});

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
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  '../assets/images/pattern.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //Header Container
                    const NavBar(),
                    //Body Container
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromARGB(50, 255, 106, 0),
                        Color.fromARGB(255, 255, 106, 0),
                        Color.fromARGB(50, 255, 106, 0)
                      ])),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Restaurant Reviews',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 4),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.center, child: Container()),
                    ),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
