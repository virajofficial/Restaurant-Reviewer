import 'package:flutter/material.dart';
import 'package:sized_box_test/models/restaurant.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key, required this.restaurant});
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 10),
      child:
          Column(children: [Text(restaurant.name), Text(restaurant.address)]),
    );
  }
}
