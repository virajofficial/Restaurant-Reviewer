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
      alignment: Alignment.centerRight,
      child: const Padding(
        padding:  EdgeInsets.only(right: 10),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
             Text("\u00a9Restaurant Reviewer",style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 53, 26, 11)),),
             Text("Email: restaurantreviewer@gmail.com",style: TextStyle(color: Color.fromARGB(255, 53, 26, 11)),),
             Text("Contact No: +94118526526",style: TextStyle(color: Color.fromARGB(255, 53, 26, 11)),),
             Text("All right reserved",style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8,color: Color.fromARGB(255, 53, 26, 11)),)
          ],
        ),
      ),
    );
  }
}
