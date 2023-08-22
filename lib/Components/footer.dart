import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF9C6339), boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: Colors.black,
          blurStyle: BlurStyle.outer,
        ),
      ]),
      padding: const EdgeInsets.all(8.0),
      height: 100,
      alignment: Alignment.center,
      child: const Text("Footer"),
    );
  }
}
