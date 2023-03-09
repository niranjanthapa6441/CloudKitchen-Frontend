import 'package:cloud_kitchen/Response/foods.dart';
import 'package:cloud_kitchen/controller/cart_controller.dart';
import 'package:cloud_kitchen/controller/food_controller.dart';
import 'package:cloud_kitchen/model/cart.dart';
import 'package:cloud_kitchen/route_helper/route_helper.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:cloud_kitchen/widgets/big_text.dart';
import 'package:cloud_kitchen/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Color/colors.dart';
import '../../utils/app_constants/app_constant.dart';
import '../../widgets/icon_and_text_widget.dart';

class FoodPageBody extends StatefulWidget {
  int foodId;
  FoodPageBody({required this.foodId, Key? key}) : super(key: key);
  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  int quantity = 1;
  bool _ontap = false;
  List<CartItem> cartItems = <CartItem>[];
  @override
  Widget build(BuildContext context) {
    Foods food = Get.find<FoodController>().foods[widget.foodId];
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: Dimensions.height10 * 25,
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius25),
                  bottomRight: Radius.circular(Dimensions.radius25),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstant.baseURL +
                        AppConstant.apiVersion +
                        food.imagePath.toString(),
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.getCart());
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        size: Dimensions.height30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Get.find<CartController>().hasValue
                      ? Positioned(
                          top: 5,
                          right: 5,
                          child: Text(
                            Get.find<CartController>()
                                .cartItems
                                .length
                                .toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: Dimensions.width20, left: Dimensions.width20),
              padding: EdgeInsets.only(
                  top: Dimensions.height20, bottom: Dimensions.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: food.name.toString()),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  BigText(
                    text: food.restaurantName.toString(),
                    size: Dimensions.font10 * 1.8,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(
                            icon: Icons.star,
                            text: food.rating.toString(),
                            size: Dimensions.font10 * 1.6,
                            iconColor: AppColors.iconColor1,
                          ),
                          IconAndTextWidget(
                            icon: Icons.timer,
                            text: '15 mins',
                            size: Dimensions.font10 * 1.6,
                            iconColor: AppColors.mainColor,
                          ),
                          IconAndTextWidget(
                            icon: Icons.location_on,
                            text: '1.5 k.ms',
                            size: Dimensions.font10 * 1.6,
                            iconColor: AppColors.iconColor2,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Container(
                    height: Dimensions.height10 * 23,
                    child: SmallText(
                      text: food.description.toString(),
                      color: Color.fromARGB(255, 15, 15, 15),
                      size: Dimensions.font10 * 1.4,
                      textOverflow: TextOverflow.visible,
                      maxLines: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Stack(
          children: [
            Container(
              height: Dimensions.height10 * 13.3,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.height10 * 13.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius25),
                    topRight: Radius.circular(Dimensions.radius25)),
              ),
              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      right: Dimensions.width20,
                      left: Dimensions.width20),
                  width: Dimensions.width10 * 18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.add,
                              color: Colors.green,
                              size: Dimensions.height50,
                            ),
                            onTap: () {
                              setState(() {
                                quantity += 1;
                              });
                            },
                          ),
                          SizedBox(
                            width: Dimensions.width15,
                          ),
                          BigText(text: quantity.toString()),
                          SizedBox(
                            width: Dimensions.width15,
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                              size: Dimensions.height50,
                            ),
                            onTap: () {
                              setState(() {
                                if (quantity != 1) {
                                  quantity -= 1;
                                }
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: Dimensions.width10),
                        child: BigText(
                          text: "Rs: " + _foodPrice(food.price, quantity),
                          size: Dimensions.font25,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    addToCart(food, quantity, food.price! * quantity);
                    Get.toNamed(RouteHelper.getCart());
                  },
                  child: Container(
                    height: Dimensions.screenHeight / 14,
                    width: Dimensions.width10 * 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: Color.fromARGB(255, 223, 123, 80),
                    ),
                    child: Center(
                      child: BigText(
                        text: "Add to Cart",
                        size: Dimensions.font20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        )
      ],
    );
  }

  String _foodPrice(double? price, int quantity) {
    double foodPrice = price! * quantity;
    return foodPrice.toString();
  }

  void addToCart(Foods food, int quantity, double price) {
    setState(() {
      Get.find<CartController>().add(food, quantity, price);
      Get.find<CartController>().hasValue;
    });
  }
}
