import 'package:flutter/material.dart';
import 'package:sized_box_test/Components/sideBarItem.dart';

class SideBar extends StatelessWidget {
  const SideBar(
      {super.key, required this.selectedTab, required this.changeTab});
  final String selectedTab;
  final Function changeTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 228,
      decoration: BoxDecoration(
        color: const Color.fromARGB(225, 253, 185, 148),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(3, 10), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SideBarItem(
            tab: 'Restaurants',
            selectedTab: selectedTab,
            changeTab: changeTab,
          ),
          SideBarItem(
              tab: 'PHI', selectedTab: selectedTab, changeTab: changeTab),
          SideBarItem(
              tab: 'Settings', selectedTab: selectedTab, changeTab: changeTab),
        ],
      ),
    );
  }
}
