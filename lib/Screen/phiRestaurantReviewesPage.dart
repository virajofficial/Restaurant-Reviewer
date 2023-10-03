import 'dart:convert';
import 'dart:ui';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/reviewItem.dart';
import 'package:restaurant_reviewer/Screen/addReviewDialog.dart';
import 'package:restaurant_reviewer/models/restaurant.dart';
import 'package:restaurant_reviewer/models/review.dart';
import 'package:restaurant_reviewer/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_reviewer/Components/footer.dart';
import 'package:restaurant_reviewer/Components/inputField.dart';
import 'package:restaurant_reviewer/Components/navbar.dart';

class PHIRestaurantReviewsPage extends StatefulWidget {
  const PHIRestaurantReviewsPage({super.key});

  @override
  State<PHIRestaurantReviewsPage> createState() =>
      _RestaurantReviewsPageState();
}

class _RestaurantReviewsPageState extends State<PHIRestaurantReviewsPage> {
  List<Review> reviews = [];
  List<Restaurant> restaurants = [];
  User currentUser = User(name: '', userName: '', contactNo: '', email: '');

  getReviews() async {
    List<Review> response = await getReviewsCall();
    //print('review body');
    //print(response);
    setState(() {
      reviews = response;
    });
  }

  getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUser =
          User.fromJson(jsonDecode(prefs.getString('user_profile') ?? '{}'));
    });
  }

  @override
  void initState() {
    getReviews();
    getUserProfile();
    super.initState();
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
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.2,
                  image: AssetImage(
                    '../assets/images/pattern.jpg',
                  ),
                  scale: 3,
                  repeat: ImageRepeat.repeat),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //Header Container
                    currentUser != null
                        ? NavBar(
                            showUsername: true,
                            currentUser: User(
                                userId: currentUser.userId,
                                name: currentUser.name,
                                userName: currentUser.userName,
                                contactNo: currentUser.contactNo,
                                email: currentUser.email))
                        : Container(),
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
                            'PHI Dashboard',
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
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              alignment: Alignment.topCenter,
                              width: 700,
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: reviews.length,
                                  itemBuilder: (context, index) => ReviewItem(
                                      type: 'type',
                                      review: reviews[index],
                                      updateReviewList: getReviews),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Positioned(
                            right: 20,
                            bottom: 20,
                            child: FloatingActionButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AddReviewDialogue(
                                          reloadReviews: getReviews),
                                );
                              },
                              backgroundColor: Color(0xFFE2582C),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
