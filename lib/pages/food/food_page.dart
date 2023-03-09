import 'package:cloud_kitchen/pages/food/food_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodPage extends StatefulWidget {
  int foodId;
  FoodPage({required this.foodId, Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
          ),
          FoodPageBody(foodId: widget.foodId)
        ],
      ),
    );
  }
}
