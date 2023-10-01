import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(120, 0, 0, 0),
        ),
        Center(
            child: Container(
          width: 120,
          height: 120,
          padding: EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
              color: Color.fromARGB(212, 160, 88, 20),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              const CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2),
              )
            ],
          ),
        )),
      ],
    );
  }
}
