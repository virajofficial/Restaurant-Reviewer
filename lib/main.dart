import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Components/alertDialog.dart';

import 'package:restaurant_reviewer/Screen/startupPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const StartupPage(),
    navigatorKey: navigatorKey,
  ));
}
