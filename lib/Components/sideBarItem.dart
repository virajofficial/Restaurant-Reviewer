import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem(
      {super.key,
      required this.selectedTab,
      required this.tab,
      required this.changeTab});

  final String selectedTab;
  final String tab;
  final Function changeTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => changeTab(tab),
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(right: 20, top: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selectedTab == tab
                ? const Color.fromARGB(255, 226, 88, 44)
                : const Color.fromARGB(255, 246, 153, 123),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(95, 125, 44, 18),
                  offset: Offset(0, -1),
                  blurRadius: 8,
                  blurStyle: BlurStyle.inner),
              BoxShadow(
                color: Color.fromARGB(56, 0, 0, 0),
                offset: Offset(0, 4),
                blurRadius: 4,
              )
            ]),
        child: Text(
          tab,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
