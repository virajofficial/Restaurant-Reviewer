import 'package:restaurant_reviewer/models/restaurant.dart';

class Review {
  final String review;
  final String restaurantName;
  final String phiArea;
  final String reviewerName;
  final int restaurantId;

  Review(
      {required this.restaurantName,
      required this.restaurantId,
      required this.review,
      required this.phiArea,
      required this.reviewerName});

  factory Review.fromJson(Map<String, dynamic> parsedJson) {
    return Review(
        review: parsedJson['reviewDetails'],
        restaurantName: parsedJson['restaurantName'],
        restaurantId: parsedJson['restaurantId'],
        phiArea: parsedJson['phiArea'],
        reviewerName: parsedJson['userName']);
  }
}
