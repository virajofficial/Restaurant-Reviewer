import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String type;
  final String mode;
  final String labelText;
  final String initialValue;
  final Function onChange;

  const DatePicker({
    super.key,
    required this.type,
    this.mode = 'add',
    this.initialValue = '',
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
    print('date');
    print(widget.initialValue);
    dateController.text = "";
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return (widget.mode == 'add')
        ? Padding(
            //**************************************************************************************Date picker Edit
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 5,
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
                    lastDate: DateTime(2024),
                    builder: (contex, child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: Color.fromARGB(255, 255, 230, 0),
                            onPrimary: Colors.red,
                            surface: Color.fromARGB(224, 189, 83, 42),
                            onSurface: Color.fromARGB(255, 255, 255, 255),
                            onSurfaceVariant: Colors.yellow,
                          ),
                          dialogBackgroundColor:
                              const Color.fromARGB(255, 253, 253, 253),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickeedDate != null) {
                    String formattedDate =
                        DateFormat("yyyy-MM-dd").format(pickeedDate);
                    print('value changed in DP');
                    print(formattedDate);
                    widget.onChange(formattedDate);
                    setState(() {
                      dateController.text = formattedDate;
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
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF96471A))),
                  disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF96471A))),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF96471A))),
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
                  fillColor: Color.fromARGB(255, 226, 140, 60),
                  filled: true,
                ),
              ),
            ),
          )
        : Padding(
            //**************************************************************************************Date picker Edit
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 16,
            ),
            child: Material(
              color: Colors.transparent,
              //shadowColor: Colors.black,
              //elevation: 10,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${widget.labelText}:',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 168, 88, 41),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        widget.onChange(value);
                      },
                      controller: dateController
                        ..text = widget.initialValue.substring(0, 10),
                      style: const TextStyle(
                        color: Color(0xFFAA684B),
                      ),
                      onTap: () async {
                        DateTime? pickeedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(widget.initialValue),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2024));
                        if (pickeedDate != null) {
                          String formattedDate =
                              DateFormat("yyyy-MM-dd").format(pickeedDate);
                          print('value changed in DP');
                          print(formattedDate);
                          widget.onChange(formattedDate);
                          setState(() {
                            dateController.text = formattedDate;
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
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF96471A))),
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF96471A))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF96471A))),
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
                        fillColor: Color.fromARGB(255, 226, 140, 60),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
