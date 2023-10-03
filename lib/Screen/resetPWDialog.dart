import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/LoadingScreen.dart';
import 'package:restaurant_reviewer/Components/alertDialog.dart';
import 'package:restaurant_reviewer/Components/inputField.dart';

class ResetPWDialog extends StatefulWidget {
  const ResetPWDialog({super.key, required this.username});

  final String username;

  @override
  State<ResetPWDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ResetPWDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();

  String otp = '';
  String password = '';
  String cPassword = '';
  bool isLoading = false;

  RegExp passwordRegEx =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  handleResetPW() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        var forgotPWResponse =
            await resetPWCall(widget.username, otp, password);
        setState(() {
          isLoading = false;
        });
        if (forgotPWResponse['success'] = true) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          showAlertDialog(
            'Reset Successfully!',
            'You have reset your password successfully.',
            () {},
            themeColor: Color.fromARGB(255, 14, 199, 20),
            type: 'green',
          );
        }
      } catch (error) {
        if (error is DioException) {
          setState(() {
            isLoading = false;
          });
          showAlertDialog(
            'Unable to Rest Password',
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
            height: 500,
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
                          'Reset Your Password',
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
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Text(
                              '${widget.username[0].toUpperCase()}${widget.username.substring(1).toLowerCase()}, ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF96471A),
                              ),
                            ),
                            MediaQuery.of(context).size.width > 600
                                ? const Text(
                                    'now your can change your password using your OTP.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF96471A),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      MediaQuery.of(context).size.width > 600
                          ? Container()
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              width: double.maxFinite,
                              child: const Text(
                                'now your can change your password using your OTP.',
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
                                    labelText: 'Enter OTP code',
                                    onChange: (value) {
                                      setState(() {
                                        otp = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            )
                          : InputField(
                              type: 'text',
                              labelText: 'Enter OTP code',
                              onChange: (value) {
                                setState(() {
                                  otp = value;
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
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          } else if (value.length < 8) {
                            return 'Password must have minimum 8 characters';
                          } else if (!passwordRegEx.hasMatch(value)) {
                            return 'Enter valid Password';
                          }
                          return null;
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter confirm password';
                          } else if (passwordController.text != value) {
                            return 'Confirm password is not matching';
                          }
                          return null;
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
                            onPressed: handleResetPW,
                            child: const Text(
                              'Reset Password',
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
        isLoading ? const LoadingScreen(label: 'Loading ...') : Container()
      ],
    );
  }
}
