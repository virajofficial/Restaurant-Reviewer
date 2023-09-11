import 'package:flutter/material.dart';
import 'package:sized_box_test/Components/alertDialog.dart';

// components
import 'package:sized_box_test/Screen/startupPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const StartupPage(),
    navigatorKey: navigatorKey,
  ));
}
