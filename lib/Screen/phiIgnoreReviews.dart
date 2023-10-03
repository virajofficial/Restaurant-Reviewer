import 'package:flutter/material.dart';
import 'package:restaurant_reviewer/Api/api.dart';
import 'package:restaurant_reviewer/Components/restaurantItem.dart';
import 'package:restaurant_reviewer/Components/reviewItem.dart';
import 'package:restaurant_reviewer/Screen/restaurantDialog.dart';
import 'package:restaurant_reviewer/models/restaurant.dart';
import 'package:restaurant_reviewer/models/review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhiIgnoreReviews extends StatefulWidget {
  const PhiIgnoreReviews({
    super.key,
    required this.phiArea,
    required this.updateCount,
  });
  final String phiArea;
  final Function updateCount;

  @override
  State<PhiIgnoreReviews> createState() => _RestaurantManageState();
}

class _RestaurantManageState extends State<PhiIgnoreReviews> {
  List<Review> reviews = [];

  getReviews() async {
    List<Review> response =
        await getReviewsCall(phiArea: 'phiArea=${widget.phiArea}');
    List<Review> filteredRes = [];
    int count = 0;
    for (Review review in response) {
      if (review.isPhiMark && review.status == 'good') {
        filteredRes.add(review);
      } else if (!review.isPhiMark && review.status == 'bad') {
        count++;
      }
    }
    //print("review count .......................");
    //print(count);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('new_review_count', count);
    await widget.updateCount();
    setState(() {
      reviews = filteredRes;
    });
  }

  @override
  void initState() {
    getReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 57,
          margin: const EdgeInsets.only(top: 10),
          color: const Color.fromARGB(255, 175, 109, 61),
          alignment: Alignment.center,
          child: const Text(
            'Ignored Reviews',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: 700,
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviews.length,
                  itemBuilder: (context, index) => ReviewItem(
                    type: 'ignore',
                    review: reviews[index],
                    isPhiMark: reviews[index].isPhiMark,
                    isPhi: true,
                    updateReviewList: getReviews,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
