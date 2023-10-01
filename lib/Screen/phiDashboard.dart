import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Components/footer.dart';
import 'package:restaurant_reviewer/Components/navbar.dart';
import 'package:restaurant_reviewer/Components/sideBar.dart';
import 'package:restaurant_reviewer/Screen/phiManage.dart';
import 'package:restaurant_reviewer/Screen/restaurantManage.dart';
import 'package:restaurant_reviewer/models/user.dart';

import '../Api/api.dart';

class PhiDashboard extends StatefulWidget {
  const PhiDashboard({super.key});

  @override
  State<PhiDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<PhiDashboard> {
  String selectedTab = 'Restaurants';

  static List<String> locations = [];

  // getPHIAreas() async {
  //   String response = await getPHIAreasCall();
  //   locations = json.decode(response).cast<String>().toList();
  //   print(locations);
  //   setState(() {
  //     locations = json.decode(response).cast<String>().toList();
  //   });
  // }

  void changeTab(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../assets/images/Background_1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.0,
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
                    NavBar(
                        title: 'PHI DASHBOARD',
                        currentUser: User(
                            name: '', userName: '', contactNo: '', email: '')),
                    //Body Container
                    Expanded(
                        child: Row(
                      children: [
                        MediaQuery.of(context).size.width > 800
                            ? SideBar(
                                selectedTab: selectedTab, changeTab: changeTab)
                            : Container(),
                        Expanded(
                            child: Column(
                          children: [
                            MediaQuery.of(context).size.width <= 800
                                ? SideBar(
                                    selectedTab: selectedTab,
                                    changeTab: changeTab,
                                    isHorizontal: true,
                                  )
                                : Container(),
                            Expanded(
                                child: selectedTab == 'Restaurants'
                                    ? //RestaurantManage()
                                    Container()
                                    : selectedTab == 'PHI'
                                        ? //PHIManage()
                                        Container()
                                        : Container())
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
        ),
      ],
    );
  }
}
