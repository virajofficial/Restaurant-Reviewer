import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/LoadingScreen.dart';
import 'package:restaurant_reviewer/Components/alertDialog.dart';
import 'package:restaurant_reviewer/Components/inputField.dart';
import 'package:restaurant_reviewer/Screen/resetPWDialog.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();

  String username = '';
  bool isloading = false;

  handleForgotPWMail() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isloading = true;
        });
        var forgotPWResponse = await forgotPWCall(username);
        setState(() {
          isloading = false;
        });
        if (forgotPWResponse['success'] = true) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (BuildContext context) => ResetPWDialog(
                    username: username,
                  ));
        }
      } catch (error) {
        if (error is DioException) {
          setState(() {
            isloading = false;
          });
          showAlertDialog(
            'Unable to Send OTP',
            error.response?.data['message'],
            () {},
            themeColor: Colors.red,
          );
        }
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          content: Container(
            width: 600,
            height: 300,
            constraints: const BoxConstraints(
              minWidth: 400,
              maxWidth: 800,
              maxHeight: 500,
            ),
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromARGB(232, 255, 200, 171),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  width: 6,
                  color: const Color(0xffFB8E51),
                ),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        width: double.maxFinite,
                        child: const Text(
                          'Password Forgot ?',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF96471A),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        width: double.maxFinite,
                        child: const Text(
                          'Enter the username associated with your account and we\'ll send you a OTP code to reset your password.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF96471A),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MediaQuery.of(context).size.width > 400
                          ? Row(
                              children: [
                                Container(
                                  width: 300,
                                  child: InputField(
                                    type: 'text',
                                    labelText: 'User Name',
                                    onChange: (value) {
                                      setState(() {
                                        username = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            )
                          : InputField(
                              type: 'text',
                              labelText: 'User Name',
                              onChange: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              //elevation: 5,
                              minimumSize: const Size(double.maxFinite, 50),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onPressed: handleForgotPWMail,
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        isloading
            ? LoadingScreen(
                label: 'Sending ...',
              )
            : Container(),
      ],
    );
  }
}
