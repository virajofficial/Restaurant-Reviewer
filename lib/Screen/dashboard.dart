import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sized_box_test/Components/footer.dart';
import 'package:sized_box_test/Components/navbar.dart';
import 'package:sized_box_test/Components/sideBar.dart';
import 'package:sized_box_test/Screen/phiManage.dart';
import 'package:sized_box_test/Screen/restaurantManage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedTab = 'Restaurants';

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
          image: AssetImage('../assets/images/Background_2.png'),
          fit: BoxFit.cover,
        ),
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
                    SideBar(selectedTab: selectedTab, changeTab: changeTab),
                    Expanded(
                        child: selectedTab == 'Restaurants'
                            ? RestaurantManage()
                            : selectedTab == 'PHI'
                                ? PHIManage()
                                : Container())
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
