import 'package:cloud_kitchen/pages/food/food_page_body.dart';
import 'package:cloud_kitchen/route_helper/route_helper.dart';
import 'package:cloud_kitchen/utils/app_constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
            leading: AppConstant.toFood
                ? BackButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.getNavigation());
                      AppConstant.toFood = false;
                    },
                  )
                : BackButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.getSearchFoods());
                      AppConstant.toFood = false;
                    },
                  ),
          ),
          FoodPageBody(foodId: widget.foodId)
        ],
      ),
    );
  }
}
