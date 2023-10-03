import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/alertDialog.dart';
import 'package:restaurant_reviewer/Screen/reviewDialog.dart';
import 'package:restaurant_reviewer/models/review.dart';

class ReviewItem extends StatefulWidget {
  ReviewItem({
    super.key,
    required this.type,
    required this.review,
    this.isPhi = false,
    this.isCheckUse = false,
    this.isPhiMark = false,
    required this.updateReviewList,
  });

  final String type;
  final Review review;
  final bool isCheckUse;
  final bool isPhi;
  bool? isPhiMark;
  final Function updateReviewList;

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  handlePhiMark(bool? phiMarked) async {
    try {
      var phiMarkedResponse = await markReviewCall(
        widget.review.id,
        phiMarked,
      );
    } catch (error) {
      if (error is DioException) {
        showAlertDialog(
            'Unable to Mark Review', error.response?.data['message'], () {},
            themeColor: Color(0xFFFF1B1B));
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FittedBox(
          child: Container(
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
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 65,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 500,
                        child: Text(
                          widget.review.review,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFCD3100)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Text(
                        '${widget.review.restaurantName} - ${widget.review.phiArea}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    widget.review.review,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.start,
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
        ),
        FittedBox(
          child: Container(
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
                    builder: (BuildContext context) => ReviewDialog(
                        type: widget.type,
                        review: widget.review,
                        isPhi: widget.isPhi,
                        updateReviewList: widget.updateReviewList),
                  );
                },
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 500, maxWidth: 800),
                  height: 120,
                ),
              ),
            ),
          ),
        ),
        widget.isCheckUse
            ? Row(
                children: [
                  Expanded(child: Container()),
                  FittedBox(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.red)),
                        checkColor: Colors.white,
                        activeColor: Color.fromARGB(255, 236, 148, 76),
                        //fillColor: Colors.green,
                        value: widget.isPhiMark,
                        onChanged: ((value) async {
                          setState(() {
                            widget.isPhiMark = value;
                          });
                          await handlePhiMark(value);
                          widget.updateReviewList();
                        }),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
