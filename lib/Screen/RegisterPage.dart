import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sized_box_test/Components/footer.dart';
import 'package:sized_box_test/Components/inputField.dart';
import 'package:sized_box_test/Components/navbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controller = TextEditingController(text: '');
  TextEditingController conPControlelr = TextEditingController(text: '');
  bool checkValue = false;
  bool _validPassword = false;
  //bool obscureText = true;

  String fName = '';
  String contactNo = '';
  String email = '';
  String username = '';
  String password = '';
  String cPassword = '';

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
                        height: 700,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'User Register',
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
                            InputField(
                              type: "text",
                              labelText: 'Full Name',
                              onChange: (value) {
                                setState(() {
                                  fName = value;
                                });
                              },
                            ),
                            InputField(
                              type: 'number',
                              labelText: 'Contact No',
                              onChange: (value) {
                                setState(() {
                                  contactNo = value;
                                });
                              },
                            ),
                            InputField(
                              type: 'text',
                              labelText: 'Email',
                              onChange: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                            ),
                            InputField(
                              type: 'text',
                              labelText: 'User Name',
                              onChange: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                            ),
                            InputField(
                              type: 'password',
                              labelText: 'Password',
                              onChange: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                            InputField(
                              type: 'password',
                              labelText: 'Confirm Password',
                              onChange: (value) {
                                setState(() {
                                  cPassword = value;
                                });
                              },
                            ),
                            // InputField(
                            //   labelText: 'Password',
                            //   onChange: (value) {
                            //     setState(() {
                            //       password = value;
                            //     });
                            //   },
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            // TextField(
                            //   controller: controller,
                            //   obscureText: obscureText,
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     fillColor: Colors.transparent,
                            //     hoverColor: Color.fromARGB(22, 150, 71, 26),
                            //     suffixIconColor:
                            //         Color.fromARGB(204, 150, 71, 26),
                            //     suffixIcon: GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           obscureText = !obscureText;
                            //         });
                            //       },
                            //       child: obscureText
                            //           ? const Icon(Icons.visibility_off)
                            //           : const Icon(Icons.visibility),
                            //     ),
                            //     label: const Text('Password',
                            //         style: TextStyle(
                            //             color: Color.fromARGB(204, 150, 71, 26),
                            //             fontStyle: FontStyle.italic)),
                            //     enabledBorder: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //         borderSide: BorderSide(
                            //           width: 2,
                            //           color: Color.fromARGB(160, 150, 71, 26),
                            //         )),
                            //     errorBorder: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //         borderSide: BorderSide(
                            //             width: 2, color: Color(0xFF96471A))),
                            //     disabledBorder: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //         borderSide: BorderSide(
                            //             width: 2, color: Color(0xFF96471A))),
                            //     focusedBorder: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //         borderSide: BorderSide(
                            //             width: 2, color: Color(0xFF96471A))),
                            //     constraints: const BoxConstraints(
                            //       maxWidth: 370,
                            //       maxHeight: 40,
                            //     ),
                            //   ),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       password = value;
                            //     });
                            //   },
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            // TextField(
                            //   controller: conPControlelr,
                            //   obscureText: obscureText,
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     fillColor: Colors.transparent,
                            //     hoverColor: Color.fromARGB(22, 150, 71, 26),
                            //     suffixIconColor:
                            //         Color.fromARGB(204, 150, 71, 26),
                            //     suffixIcon: GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           obscureText = !obscureText;
                            //         });
                            //       },
                            //       child: obscureText
                            //           ? const Icon(Icons.visibility_off)
                            //           : const Icon(Icons.visibility),
                            //     ),
                            //     label: const Text('Confirm Password',
                            //         style: TextStyle(
                            //             color: Color.fromARGB(204, 150, 71, 26),
                            //             fontStyle: FontStyle.italic)),
                            //     enabledBorder: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //         borderSide: BorderSide(
                            //           width: 2,
                            //           color: Color.fromARGB(160, 150, 71, 26),
                            //         )),
                            //     errorBorder: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //         borderSide: BorderSide(
                            //             width: 2, color: Color(0xFF96471A))),
                            //     disabledBorder: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //         borderSide: BorderSide(
                            //             width: 2, color: Color(0xFF96471A))),
                            //     focusedBorder: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10)),
                            //         borderSide: BorderSide(
                            //             width: 2, color: Color(0xFF96471A))),
                            //     constraints: const BoxConstraints(
                            //       maxWidth: 370,
                            //       maxHeight: 40,
                            //     ),
                            //   ),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       cPassword = value;
                            //     });
                            //   },
                            // ),
                            // InputField(
                            //   labelText: 'Confirm Password',
                            //   onChange: (value) {
                            //     setState(() {
                            //       password = value;
                            //     });
                            //   },
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 55),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Checkbox(
                            //         value: checkValue,
                            //         activeColor: const Color(0xFFAA684B),
                            //         hoverColor:
                            //             const Color.fromARGB(199, 214, 134, 99),
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(3),
                            //         ),
                            //         side: const BorderSide(
                            //             color: Color(0xFFAA684B), width: 2),
                            //         onChanged: (bool? value) {
                            //           setState(
                            //             () {
                            //               checkValue = value!;
                            //             },
                            //           );
                            //         },
                            //       ),
                            //       // const Text(
                            //       //   'Show Password',
                            //       //   style: TextStyle(
                            //       //     color: Color(0xFF664233),
                            //       //   ),
                            //       // )
                            //     ],
                            //   ),
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFF8947),
                                      Color(0xFFFF5C00)
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 141, 52, 0),
                                        spreadRadius: 2,
                                        blurStyle: BlurStyle.inner,
                                        blurRadius: 10,
                                        offset: Offset(1, 2)),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  //elevation: 5,
                                  minimumSize: const Size(370, 50),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      letterSpacing: 2),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
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
