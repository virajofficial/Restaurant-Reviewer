import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  const PopupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        width: 500,
        height: 500,
        color: Colors.transparent,
        constraints: const BoxConstraints(
          minHeight: 500,
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 80,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(colors: [
                    Color(0xFFDB9452),
                    Color(0xFFDF8B3D),
                  ]),
                  border: Border(
                      left: BorderSide(
                    color: Color(0xFFBD712B),
                    width: 3,
                  )),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(150, 0, 0, 0),
                      blurStyle: BlurStyle.outer,
                      offset: Offset(0, 00.1),
                      blurRadius: 3,
                    ),
                  ]),
              child: const Column(
                children: [
                  Text('Review Title'),
                  Text('Restaurant Name'),
                  Text('Customer Name')
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 412,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFF1C9A5),
                      Color.fromARGB(255, 239, 177, 123)
                    ],
                  ),
                  border: Border(
                      left: BorderSide(
                    color: Color(0xFFBD712B),
                    width: 3,
                  )),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(150, 0, 0, 0),
                      blurStyle: BlurStyle.outer,
                      offset: Offset(0, 00.1),
                      blurRadius: 3,
                    ),
                  ]),
              child: const Column(
                children: [
                  Text('Review Title', textAlign: TextAlign.start),
                  Text('Restaurant Name'),
                  Text('Customer Name')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
