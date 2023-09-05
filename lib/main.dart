import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sized_box_test/Components/alertDialog.dart';
import 'package:sized_box_test/Screen/phiDialog.dart';
import 'package:sized_box_test/Screen/restaurantDialog.dart';
import 'package:sized_box_test/Screen/reviewDialog.dart';
import 'package:sized_box_test/Screen/RegisterPage.dart';
import 'package:sized_box_test/Screen/dashboard.dart';

// components
import 'package:sized_box_test/Screen/loginPage.dart';
import 'package:sized_box_test/Screen/phiManage.dart';
import 'package:sized_box_test/Screen/restaurantReveiwsPage.dart';
import 'package:sized_box_test/Screen/startupPage.dart';
import 'package:sized_box_test/models/review.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const StartupPage(),
    navigatorKey: navigatorKey,
  ));
}
