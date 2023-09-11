// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/review.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        width: 500,
        height: 500,
        color: Colors.transparent,
        constraints: const BoxConstraints(
          minHeight: 500,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.maxFinite,
              height: 80,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(colors: [
                    Color(0xFFDB9452),
                    Color(0xFFDF8B3D),
                  ]),
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFFBD712B),
                      width: 3,
                    ),
                    right: BorderSide(
                      color: Color(0xFFBD712B),
                      width: 3,
                    ),
                    top: BorderSide(
                      color: Color(0xFFBD712B),
                      width: 3,
                    ),
                  ),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(150, 0, 0, 0),
                      blurStyle: BlurStyle.outer,
                      offset: Offset(0, 00.1),
                      blurRadius: 3,
                    ),
                  ]),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.review,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          color: Color(0xFFCD3100),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      review.restaurantName,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          '( By ',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF783B0F),
                              fontStyle: FontStyle.italic),
                        ),
                        Text(
                          review.reviewerName.split(' ')[0],
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF783B0F),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ')',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF783B0F),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
                width: double.maxFinite,
                height: 412,
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFF1C9A5),
                        Color.fromARGB(255, 239, 177, 123)
                      ],
                    ),
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFFBD712B),
                        width: 3,
                      ),
                      right: BorderSide(
                        color: Color(0xFFBD712B),
                        width: 3,
                      ),
                      bottom: BorderSide(
                        color: Color(0xFFBD712B),
                        width: 3,
                      ),
                    ),
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(10),
                    //   bottomRight: Radius.circular(10),
                    // ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(150, 0, 0, 0),
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 00.1),
                        blurRadius: 3,
                      ),
                    ]),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          left: 60,
                          right: 60,
                          top: 20,
                          bottom: 20,
                        ),
                        child: Container(
                          width: double.maxFinite,
                          child: Text(
                            review.review,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 380,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFA83131)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
