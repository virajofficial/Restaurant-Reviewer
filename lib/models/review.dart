import 'package:restaurant_reviewer/models/restaurant.dart';

class Review {
  final int id;
  final String review;
  final String restaurantName;
  final String phiArea;
  final String reviewerName;
  final int restaurantId;
  final bool isPhiMark;
  final String status;

  Review({
    this.id = 0,
    required this.restaurantName,
    required this.restaurantId,
    required this.review,
    required this.phiArea,
    required this.reviewerName,
    required this.status,
    this.isPhiMark = false,
  });

  factory Review.fromJson(Map<String, dynamic> parsedJson) {
    return Review(
        id: parsedJson['id'],
        review: parsedJson['reviewDetails'],
        restaurantName: parsedJson['restaurantName'],
        restaurantId: parsedJson['restaurantId'],
        phiArea: parsedJson['phiArea'],
        reviewerName: parsedJson['userName'],
        status: parsedJson['status'],
        isPhiMark: parsedJson['isPhiMark']);
  }
}
