import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sized_box_test/Components/footer.dart';
import 'package:sized_box_test/Components/inputField.dart';
import 'package:sized_box_test/Components/navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('../assets/images/Background_1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //Header Container
                  const NavBar(),
                  //Body Container
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(171, 255, 200, 171),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                            width: 6,
                            color: const Color(0xffFB8E51),
                          ),
                        ),
                        width: 500,
                        height: 500,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF96471A),
                                letterSpacing: 3,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const InputField(labelText: 'User Name'),
                            const InputField(labelText: 'Password'),
                            Padding(
                              padding: const EdgeInsets.only(left: 55),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: checkValue,
                                    activeColor: const Color(0xFFAA684B),
                                    hoverColor:
                                        const Color.fromARGB(199, 214, 134, 99),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    side: const BorderSide(
                                        color: Color(0xFFAA684B), width: 2),
                                    onChanged: (bool? value) {
                                      setState(
                                        () {
                                          checkValue = value!;
                                        },
                                      );
                                    },
                                  ),
                                  const Text(
                                    'Show Password',
                                    style: TextStyle(
                                      color: Color(0xFF664233),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                              onPressed: () {},
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
