import 'package:cloud_kitchen/Response/foods.dart';
import 'package:cloud_kitchen/controller/food_controller.dart';
import 'package:cloud_kitchen/pages/homepage/homepage_body.dart';
import 'package:cloud_kitchen/utils/app_constants/app_constant.dart';
import 'package:cloud_kitchen/utils/color/colors.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:cloud_kitchen/widgets/big_text.dart';
import 'package:cloud_kitchen/widgets/icon_and_text_widget.dart';
import 'package:cloud_kitchen/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<FoodController>().getFoodDetails();
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height50, bottom: Dimensions.height10),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Row(children: [
                          IconAndTextWidget(
                              icon: Icons.location_on,
                              text: "Location",
                              iconColor: Colors.red)
                        ]),
                        height: Dimensions.height30,
                        width: Dimensions.width300,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: Dimensions.width10 / 10)),
                      )
                    ],
                  ),
                  Container(
                    width: Dimensions.width30,
                    height: Dimensions.height45,
                    child: Icon(
                      Icons.shopping_cart,
                      size: Dimensions.height30,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: HomePageBody(),
          )),
        ],
      ),
    );
  }
}
