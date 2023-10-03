import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> showAlertDialog(
  String title,
  String subtitle,
  Function function, {
  String type = 'red',
  Color themeColor = const Color.fromARGB(255, 82, 44, 8),
}
    // ignore: avoid_types_as_parameter_names
    ) async {
  return showDialog<void>(
    context: navigatorKey.currentContext!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFFFBF84),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: themeColor,
              width: 3,
            )),
        title: Text(title, style: TextStyle(color: themeColor)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: themeColor, borderRadius: BorderRadius.circular(30)),
              child: type == 'green'
                  ? const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 40,
                    )
                  : const Text(
                      '!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                height: 100,
                child: Center(
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          subtitle,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 40,
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF8947), Color(0xFFFF5C00)],
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 141, 52, 0),
                        spreadRadius: 2,
                        blurStyle: BlurStyle.inner,
                        blurRadius: 10,
                        offset: Offset(1, 2)),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  //elevation: 5,
                  minimumSize: const Size(370, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  function;
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
