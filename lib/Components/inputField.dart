import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final Function onChange;
  const InputField(
      {super.key, required this.labelText, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 16,
      ),
      child: Material(
        color: Colors.transparent,
        //shadowColor: Colors.black,
        //elevation: 10,
        child: TextField(
          onChanged: (value) {
            onChange(value);
          },
          style: const TextStyle(
            color: Color(0xFFAA684B),
          ),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color(0xFFAA684B),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFAA684B),
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            labelText: labelText,
            labelStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFFAA684B),
            ),
            constraints: const BoxConstraints(
              maxHeight: 40,
            ),
            filled: true,
            fillColor: const Color.fromARGB(0, 255, 211, 186),
          ),
        ),
      ),
    );
  }
}
