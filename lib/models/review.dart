import 'package:sized_box_test/models/restaurant.dart';

class Review {
  final String review;
  final Restaurant restaurant;

  Review({required this.restaurant, required this.review});

  factory Review.fromJson(Map<String, dynamic> parsedJson) {
    return Review(
      review: parsedJson['review'],
      restaurant: Restaurant.fromJson(parsedJson['restaurant']),
    );
  }
}
