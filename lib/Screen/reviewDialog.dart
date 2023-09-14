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
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: const [
            Color.fromARGB(255, 194, 147, 102),
            Color.fromARGB(255, 216, 170, 139),
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minHeight: 600,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.maxFinite,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                /*border: Border(
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
                  ),*/
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(10),
                //   topRight: Radius.circular(10),
                // ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Color.fromARGB(150, 0, 0, 0),
                //     blurStyle: BlurStyle.outer,
                //     offset: Offset(0, 00.1),
                //     blurRadius: 3,
                //   ),
                // ],
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              height: 10,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 126, 90, 60),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
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
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 71, 71),
                      Color.fromARGB(255, 255, 0, 0)
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 141, 0, 0),
                        spreadRadius: 2,
                        blurStyle: BlurStyle.inner,
                        blurRadius: 3,
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
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 2),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
