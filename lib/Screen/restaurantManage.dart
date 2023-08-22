import 'package:flutter/material.dart';
import 'package:sized_box_test/Components/restaurantItem.dart';
import 'package:sized_box_test/models/restaurant.dart';

class RestaurantManage extends StatefulWidget {
  const RestaurantManage({super.key});

  @override
  State<RestaurantManage> createState() => _RestaurantManageState();
}

var restaurants = [
  Restaurant(name: 'Restaurant 1', address: 'Moratuwa 1'),
  Restaurant(name: 'Restaurant 2', address: 'Moratuwa 2'),
  Restaurant(name: 'Restaurant 3', address: 'Moratuwa 3')
];

class _RestaurantManageState extends State<RestaurantManage> {
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
            'Restaurant Manage',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: restaurants.length,
              itemBuilder: (context, index) => RestaurantItem(
                restaurant: restaurants[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
