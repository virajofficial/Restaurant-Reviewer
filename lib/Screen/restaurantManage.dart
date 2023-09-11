import 'package:flutter/material.dart';
import 'package:sized_box_test/Api/api.dart';
import 'package:sized_box_test/Components/restaurantItem.dart';
import 'package:sized_box_test/Screen/restaurantDialog.dart';
import 'package:sized_box_test/models/restaurant.dart';

class RestaurantManage extends StatefulWidget {
  const RestaurantManage({super.key});

  @override
  State<RestaurantManage> createState() => _RestaurantManageState();
}

class _RestaurantManageState extends State<RestaurantManage> {
  List<Restaurant> restaurants = [];

  getRestaurants() async {
    List<Restaurant> response = await getRestaurantsCall();
    setState(() {
      restaurants = response;
    });
  }

  @override
  void initState() {
    getRestaurants();
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
            'Restaurant Manage',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) => RestaurantItem(
                    restaurant: restaurants[index],
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => RestaurantDialogue(
                        state: 'add',
                        details: Restaurant(
                          resName: '',
                          resRegNo: '',
                          resContactNo: '',
                          resRegDate: '',
                          resAddress: '',
                          resPhiArea: '',
                        ),
                        onReloadRestaurants: getRestaurants,
                      ),
                    );
                  },
                  backgroundColor: Color(0xFFE2582C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
