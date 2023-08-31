import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String type;
  final String labelText;
  final Function onChange;

  const InputField({
    super.key,
    required this.type,
    required this.labelText,
    required this.onChange,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscureText = true;

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
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${widget.labelText}';
            }
            return null;
          },
          onChanged: (value) {
            widget.onChange(value);
          },
          cursorColor: Color.fromARGB(204, 150, 71, 26),
          obscureText: (widget.type == "password") ? obscureText : false,
          keyboardType:
              (widget.type == "multiline") ? TextInputType.multiline : null,
          minLines: 1,
          maxLines: (widget.type == "multiline") ? 5 : 1,
          style: const TextStyle(
            color: Color(0xFFAA684B),
          ),
          decoration: InputDecoration(
            suffixIconColor: Color.fromARGB(204, 150, 71, 26),
            suffixIcon: (widget.type == "password")
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: obscureText
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )
                : null,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromARGB(160, 150, 71, 26),
                )),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
            labelText: widget.labelText,
            labelStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFFAA684B),
            ),
            constraints: (widget.type == "multiline")
                ? null
                : const BoxConstraints(
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
