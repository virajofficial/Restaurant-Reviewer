import 'package:email_validator/email_validator.dart';
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
  TextEditingController con = TextEditingController();
  bool obscureText = true;
  bool invalidPassword = false;
  RegExp passwordRegEx =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  String toolTipMessage(String type) {
    if (type == 'password') {
      return 'should contain at least one upper case \nshould contain at least one lower case \nshould contain at least one digit \nshould contain at least one Special character( ! @ # \$ & * ~ )';
    } else if (type == 'text') {
      return '';
    } else if (type == 'tp') {
      return 'Enter valid Contact Number, Ex: 0771234567';
    } else if (type == 'email') {
      return 'Enter valid Email, Ex: testemail@gmail.com';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 10,
      ),
      child: Material(
        color: Colors.transparent,
        //shadowColor: Colors.black,
        //elevation: 10,
        child: Tooltip(
          decoration: const BoxDecoration(
            color: Color.fromARGB(228, 244, 130, 54),
          ),
          message: toolTipMessage(widget.type),
          textAlign: TextAlign.left,
          verticalOffset: 15,
          waitDuration: const Duration(milliseconds: 50),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                invalidPassword = true;
                return 'Please enter ${widget.labelText}';
              }
              if (widget.type == "password") {
                if (value.length < 8) {
                  invalidPassword = true;
                  return 'Password must have minimum 8 characters';
                } else if (!passwordRegEx.hasMatch(value)) {
                  invalidPassword = true;
                  return 'Enter valid Password';
                } else {
                  invalidPassword = false;
                }
              }
              if (widget.type == "email") {
                bool isValidEmail = EmailValidator.validate(value);
                if (!isValidEmail) {
                  return 'Enter valid Email';
                } else {
                  return null;
                }
              }
              if (widget.type == "tp") {
                if (value.length != 10) {
                  return 'Enter valid Contact Number';
                } else {
                  return null;
                }
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
              // hintText: (widget.type == "password" && invalidPassword)
              //     ? 'should contain at least one upper case \nshould contain at least one lower case \nshould contain at least one digit \nshould contain at least one Special character'
              //     : '',
              // floatingLabelBehavior: FloatingLabelBehavior.auto,
              suffixIconColor: const Color.fromARGB(204, 150, 71, 26),
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
                    color: Color.fromARGB(159, 255, 94, 0),
                  )),
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      width: 2, color: Color.fromARGB(255, 255, 0, 0))),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      width: 2, color: Color.fromARGB(255, 255, 0, 0))),
              disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 2, color: Color(0xFF96471A))),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      width: 2, color: Color.fromARGB(255, 255, 94, 0))),
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Color(0xFFAA684B),
              ),
              constraints: (widget.type == "multiline")
                  ? null
                  : const BoxConstraints(maxHeight: 70, minHeight: 70),
              filled: true,
              fillColor: const Color.fromARGB(0, 255, 211, 186),
            ),
          ),
        ),
      ),
    );
  }
}
