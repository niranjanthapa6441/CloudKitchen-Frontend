import 'package:cloud_kitchen/pages/food/food_page_body.dart';
import 'package:cloud_kitchen/pages/restauraunt_menu_food/restaurant_menu_food_body.dart';
import 'package:flutter/material.dart';

class RestaurantMenuFoodPage extends StatefulWidget {
  int foodId;
  RestaurantMenuFoodPage({required this.foodId, Key? key}) : super(key: key);

  @override
  State<RestaurantMenuFoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<RestaurantMenuFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
          ),
          RestaurantMenuFoodBody(foodId: widget.foodId)
        ],
      ),
    );
  }
}
