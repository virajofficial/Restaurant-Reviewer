// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/LoadingScreen.dart';
import 'package:restaurant_reviewer/Components/alertDialog.dart';

import '../models/review.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({
    super.key,
    required this.type,
    required this.review,
    this.isPhi = false,
    required this.updateReviewList,
  });

  final String type;
  final Review review;
  final bool isPhi;
  final Function updateReviewList;

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  bool isLoading = false;

  handleReviewStatus(String status, bool isPhiMark) async {
    try {
      setState(() {
        isLoading = true;
      });
      var statusChangeResponse = await reveiwStatusCall(
        widget.review.id,
        status,
        isPhiMark,
      );
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      showAlertDialog(
        status == 'good'
            ? 'Successfully Ignored.!!'
            : 'Successfully Re-Assigned.!!',
        status == 'good'
            ? 'Ignored from bad reviews successfully.'
            : 'Re-assigned to check.',
        () {},
        themeColor: Color.fromARGB(255, 14, 199, 20),
        type: 'green',
      );
    } catch (error) {
      if (error is DioException) {
        setState(() {
          isLoading = false;
        });
        showAlertDialog(
          'Unable to Change Status',
          error.response?.data['message'],
          () {},
          themeColor: Color(0xFFFF1B1B),
        );
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
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
                border: Border.all(
                  color: Color.fromARGB(255, 126, 90, 60),
                  width: 5,
                )),
            constraints: const BoxConstraints(
              minHeight: 600,
            ),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 201, 136, 83),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.review.review,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                              color: Color(0xFFCD3100),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          '${widget.review.restaurantName} - ${widget.review.phiArea}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
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
                              widget.review.reviewerName.split(' ')[0],
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
                  height: 5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(73, 0, 0, 0),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Container(
                      width: double.maxFinite,
                      child: Text(
                        widget.review.review,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.isPhi
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF8947), Color(0xFFFF5C00)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 141, 52, 0),
                                  spreadRadius: 2,
                                  blurStyle: BlurStyle.inner,
                                  blurRadius: 3,
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
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          onPressed: () async {
                            if (widget.type == 'new' ||
                                widget.type == 'marked') {
                              await handleReviewStatus('good', true);
                            } else if (widget.type == 'ignore') {
                              await handleReviewStatus('bad', false);
                            }
                            widget.updateReviewList();
                          },
                          child: Text(
                            (widget.type == 'new' || widget.type == 'marked')
                                ? 'Ignore Review'
                                : (widget.type == 'ignore')
                                    ? 'Re Check'
                                    : '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 2),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
        ),
        isLoading ? const LoadingScreen(label: 'Loading ...') : Container()
      ],
    );
  }
}
