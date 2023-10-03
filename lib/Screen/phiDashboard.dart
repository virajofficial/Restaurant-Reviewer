import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Components/footer.dart';
import 'package:restaurant_reviewer/Components/navbar.dart';
import 'package:restaurant_reviewer/Components/phiSideBar.dart';
import 'package:restaurant_reviewer/Screen/phiIgnoreReviews.dart';
import 'package:restaurant_reviewer/Screen/phiMarkedReviews.dart';
import 'package:restaurant_reviewer/Screen/phiManage.dart';
import 'package:restaurant_reviewer/Screen/phiNewReviews.dart';
import 'package:restaurant_reviewer/Screen/restaurantManage.dart';
import 'package:restaurant_reviewer/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/api.dart';

class PhiDashboard extends StatefulWidget {
  const PhiDashboard({
    super.key,
    required this.phiArea,
  });
  final String phiArea;

  @override
  State<PhiDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<PhiDashboard> {
  String selectedTab = 'Marked Reviews';

  User currentUser = User(name: '', userName: '', contactNo: '', email: '');
  int newBadReviewCount = 0;
  // getPHIAreas() async {
  //   String response = await getPHIAreasCall();
  //   locations = json.decode(response).cast<String>().toList();
  //   print(locations);
  //   setState(() {
  //     locations = json.decode(response).cast<String>().toList();
  //   });
  // }

  getUserProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser =
          User.fromJson(jsonDecode(pref.getString('user_profile') ?? '{}'));
    });
  }

  updateCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      newBadReviewCount = prefs.getInt('new_review_count') ?? 0;
      //print('new bad review count');
      //print(newBadReviewCount);
    });
  }

  @override
  void initState() {
    //updateCount();
    getUserProfile();
    super.initState();
  }

  void changeTab(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Color.fromARGB(68, 252, 92, 0), BlendMode.multiply),
            image: AssetImage(
              '../assets/images/pattern.jpg',
            ),
            scale: 3,
            repeat: ImageRepeat.repeat),
      ),
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
                currentUser != null
                    ? NavBar(
                        title: 'PHI DASHBOARD',
                        showUsername: true,
                        currentUser: User(
                            userId: currentUser.userId,
                            name: currentUser.name,
                            userName: currentUser.userName,
                            contactNo: currentUser.contactNo,
                            email: currentUser.email))
                    : Container(),
                //Body Container
                Expanded(
                    child: Row(
                  children: [
                    MediaQuery.of(context).size.width > 800
                        ? PhiSideBar(
                            selectedTab: selectedTab,
                            changeTab: changeTab,
                            count: newBadReviewCount,
                          )
                        : Container(),
                    Expanded(
                        child: Column(
                      children: [
                        MediaQuery.of(context).size.width <= 800
                            ? PhiSideBar(
                                selectedTab: selectedTab,
                                changeTab: changeTab,
                                isHorizontal: true,
                                count: newBadReviewCount,
                              )
                            : Container(),
                        Expanded(
                            child: selectedTab == 'Marked Reviews'
                                ? PhiMarkedReviews(
                                    phiArea: widget.phiArea,
                                    updateCount: updateCount,
                                  )
                                : selectedTab == 'New Reviews'
                                    ? PhiNewReviews(
                                        phiArea: widget.phiArea,
                                        updateCount: updateCount,
                                      )
                                    : PhiIgnoreReviews(
                                        phiArea: widget.phiArea,
                                        updateCount: updateCount,
                                      ))
                      ],
                    ))
                  ],
                )),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
