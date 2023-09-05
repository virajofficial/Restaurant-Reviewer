import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sized_box_test/Components/footer.dart';
import 'package:sized_box_test/Components/navbar.dart';
import 'package:sized_box_test/Components/sideBar.dart';
import 'package:sized_box_test/Screen/phiManage.dart';
import 'package:sized_box_test/Screen/restaurantManage.dart';

import '../Api/api.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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

  // @override
  // void initState() {
  //   getPHIAreas();
  //   print("locations ");
  //   super.initState();
  // }

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
                const NavBar(title: 'ADMIN DASHBOARD'),
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
                                ? RestaurantManage()
                                : selectedTab == 'PHI'
                                    ? PHIManage()
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
    );
  }
}
