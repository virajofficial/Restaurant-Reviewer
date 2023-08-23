import 'package:flutter/material.dart';
import 'package:sized_box_test/models/review.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(157, 0, 0, 0),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 3,
                    offset: Offset(0.1, 0.1))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.fromBorderSide(
                BorderSide(
                    color: Color(0xFFAD692A),
                    strokeAlign: BorderSide.strokeAlignCenter,
                    style: BorderStyle.solid,
                    width: 3),
              ),
              color: Color(0xFFFFD3BB),
            ),
            alignment: Alignment.center,
            constraints: const BoxConstraints(minWidth: 500, maxWidth: 800),
            height: 120,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFBE99),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          color: Color.fromARGB(141, 54, 54, 54),
                          blurRadius: 5,
                        ),
                      ]),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCD3100)),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'Location',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    review.review,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1,
                      color: Color(0xFF5F2708),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: const Color.fromARGB(61, 233, 127, 56),
                splashColor: const Color.fromARGB(59, 223, 117, 56),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
                },
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 500, maxWidth: 800),
                  height: 120,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(),
        Text("Hello"),
      ],
    ),
  );
}
