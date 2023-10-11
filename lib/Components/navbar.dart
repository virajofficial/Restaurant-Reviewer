import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Components/LoadingScreen.dart';
import 'package:restaurant_reviewer/Components/PopupMenu.dart';
import 'package:restaurant_reviewer/Screen/loginDialog.dart';
import 'package:restaurant_reviewer/Screen/registerDialog.dart';
import 'package:restaurant_reviewer/Screen/userProfileDialog.dart';
import 'package:restaurant_reviewer/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_reviewer/Screen/startupPage.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    this.showLoginSignup = false,
    this.title = '',
    this.showLogout = true,
    this.userName = '',
    this.showUsername = false,
    required this.currentUser,
    required this.reloadUserData,
  });

  final bool showLoginSignup;
  final bool showLogout;
  final bool showUsername;
  final String title;
  final String userName;
  final User currentUser;
  final Function reloadUserData;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 243, 218, 200),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer,
                blurRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          height: 70,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MediaQuery.of(context).size.width > 500
                  ? Stack(
                      children: [
                        Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            '../assets/images/Logo.png',
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Image.asset('../assets/images/Logo.png'),
                          ),
                        )
                      ],
                    )
                  : Stack(
                      children: [
                        Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            '../assets/images/Logo_Icon.png',
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child:
                                Image.asset('../assets/images/Logo_Icon.png'),
                          ),
                        )
                      ],
                    ),
              MediaQuery.of(context).size.width > 800
                  ? Expanded(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color.fromARGB(225, 227, 82, 0),
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  : Expanded(child: Container()),
              //Expanded(child: Container()),

              widget.showUsername
                  ? InkWell(
                      child: Container(
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 150),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Hi, ${widget.currentUser.name.split(' ')[0]}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 161, 91, 0),
                            ),
                          )),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                UserProfileDialog(
                                  userdata: widget.currentUser,
                                  reloadUserData: widget.reloadUserData,
                                ));
                      },
                    )
                  : Container(),
              widget.showLoginSignup
                  ? ButtonBar(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 5,
                            backgroundColor: Color(0xFFF2B65B),
                            minimumSize: Size(120, 50),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const RegisterDialog());
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 5,
                            backgroundColor: Color(0xFFFF8947),
                            minimumSize: Size(120, 50),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const LoginDialog());
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : (widget.showLogout)
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 5,
                            backgroundColor: Color(0xFFF2B65B),
                            minimumSize: Size(120, 50),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            setState(() {
                              isLoading = false;
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StartupPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
        isLoading ? const LoadingScreen(label: 'Loading ...') : Container()
      ],
    );
  }
}
