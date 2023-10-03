import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> showPopUpMenu(String title, String subtitle, Function function,
    {Color themeColor = const Color.fromARGB(255, 82, 44, 8)}
    // ignore: avoid_types_as_parameter_names
    ) async {
  return showDialog<void>(
    context: navigatorKey.currentContext!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Container(
        child: AlertDialog(
          backgroundColor: Color(0xFFFFBF84),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: themeColor,
                width: 3,
              )),
          title: Text(title, style: TextStyle(color: themeColor)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(subtitle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                function;
              },
            ),
          ],
        ),
      );
    },
  );
}
