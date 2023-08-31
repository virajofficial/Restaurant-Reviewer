import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String type;
  final String labelText;
  final Function onChange;

  const DatePicker({
    super.key,
    required this.type,
    required this.labelText,
    required this.onChange,
  });

  @override
  State<DatePicker> createState() => _InputFieldState();
}

class _InputFieldState extends State<DatePicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

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
        child: TextField(
          controller: dateController,
          onChanged: (value) {
            widget.onChange(value);
          },
          style: const TextStyle(
            color: Color(0xFFAA684B),
          ),
          onTap: () async {
            DateTime? pickeedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2024));
            if (pickeedDate != null) {
              String formattedDate =
                  DateFormat("yyyy-MM-dd").format(pickeedDate);
              setState(() {
                dateController.text = formattedDate.toString();
              });
            } else {
              print('Not Selected');
            }
          },
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_today),
            prefixIconColor: const Color.fromARGB(204, 150, 71, 26),
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
          ),
        ),
      ),
    );
  }
}
