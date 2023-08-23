import 'package:flutter/material.dart';
import 'package:sized_box_test/Components/sideBarItem.dart';

class SideBar extends StatelessWidget {
  const SideBar(
      {super.key,
      required this.selectedTab,
      required this.changeTab,
      this.isHorizontal = false});
  final String selectedTab;
  final Function changeTab;
  final bool isHorizontal;

  getLayout(List<Widget> children) {
    return isHorizontal
        ? Row(children: children)
        : Column(
            children: children,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: isHorizontal ? 10 : 0,
        right: isHorizontal ? 10 : 0,
      ),
      width: isHorizontal ? double.infinity : 228,
      decoration: BoxDecoration(
        color: isHorizontal
            ? Colors.transparent
            : const Color.fromARGB(225, 253, 185, 148),
        boxShadow: isHorizontal
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(3, 10), // changes position of shadow
                ),
              ],
      ),
      child: getLayout(
        [
          SideBarItem(
            tab: 'Restaurants',
            selectedTab: selectedTab,
            changeTab: changeTab,
            isHorizontal: isHorizontal,
            position: 1,
          ),
          SideBarItem(
            tab: 'PHI',
            selectedTab: selectedTab,
            changeTab: changeTab,
            isHorizontal: isHorizontal,
            position: 2,
          ),
          SideBarItem(
            tab: 'Settings',
            selectedTab: selectedTab,
            changeTab: changeTab,
            isHorizontal: isHorizontal,
            position: 3,
          ),
        ],
      ),
    );
  }
}
