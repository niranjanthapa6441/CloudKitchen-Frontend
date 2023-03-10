import 'package:cloud_kitchen/controller/cart_controller.dart';
import 'package:cloud_kitchen/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Color/colors.dart';
import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPageBody extends StatefulWidget {
  const CartPageBody({super.key});

  @override
  State<CartPageBody> createState() => _CartPageBodyState();
}

class _CartPageBodyState extends State<CartPageBody> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: Column(children: [
        GetBuilder<CartController>(builder: (cartItems) {
          return GestureDetector(
              child: Container(
            height: _height(cartItems.cartItems),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: cartItems.cartItems?.length,
                itemBuilder: (context, index) {
                  return _buildPageItem(index, cartItems.cartItems[index]);
                }),
          ));
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimensions.height10 * 7,
                    width: Dimensions.width10 * 18,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: 'Subtotal: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        BigText(
                          text: 'Delivery Charge: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 7,
                    width: Dimensions.width10 * 9,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SmallText(
                          text: _totalPrice().toString(),
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        SmallText(
                          text: '0',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.black,
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 7,
                    width: Dimensions.width10 * 18,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: 'Total Amount: ',
                          color: Colors.black,
                          size: Dimensions.font10 * 1.8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height10 * 7,
                    width: Dimensions.width10 * 8,
                    padding: EdgeInsets.only(
                        bottom: Dimensions.height10, top: Dimensions.height10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SmallText(
                          text: _totalPrice().toString(),
                          color: Colors.black,
                          size: Dimensions.font10 * 1.6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            //Get.toNamed(RouteHelper.availablePaymentMethods);
          },
          child: Container(
            margin: EdgeInsets.only(
                left: Dimensions.width30 + Dimensions.width30,
                right: Dimensions.width30 + Dimensions.width30,
                bottom: Dimensions.height50),
            height: Dimensions.screenHeight / 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: Color.fromARGB(255, 223, 123, 80),
            ),
            child: Center(
              child: BigText(
                text: "CheckOut",
                size: Dimensions.font20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildPageItem(int index, CartItem item) {
    return Card(
      child: Column(
        children: [
          Container(
            height: Dimensions.height10 * 17,
            padding: EdgeInsets.only(
                right: Dimensions.width10 * 0.8,
                left: Dimensions.width10 * 0.8,
                top: Dimensions.height10 * 0.4,
                bottom: Dimensions.height10 * 0.4),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                  ),
                  height: Dimensions.height10 * 10,
                  width: Dimensions.width10 * 10,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstant.baseURL +
                            AppConstant.apiVersion +
                            item.food.imagePath.toString()),
                      ),
                      color: AppColors.paraColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius10)),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        right: Dimensions.width10,
                        left: Dimensions.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimensions.height10 * 0.8,
                        ),
                        Text(
                          item.food.name.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font10 * 1.7,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10 * 0.8,
                        ),
                        Text(
                          'Unit Price: ${item.food.price}',
                          style: TextStyle(
                            fontSize: Dimensions.font10 * 1.6,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10 * 0.8,
                        ),
                        Text(
                          'Price: ${item.price}',
                          style: TextStyle(
                            fontSize: Dimensions.font10 * 1.6,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10 * 1.6,
                        ),
                        Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: Dimensions.height30,
                                ),
                                onTap: () {
                                  setState(() {
                                    quantity = item.quantity;
                                    Get.find<CartController>().addQuantity(
                                        item.food, item.quantity, item.price);
                                  });
                                },
                              ),
                              SizedBox(
                                width: Dimensions.width15,
                              ),
                              BigText(text: item.quantity.toString()),
                              SizedBox(
                                width: Dimensions.width15,
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                  size: Dimensions.height30,
                                ),
                                onTap: () {
                                  setState(() {
                                    if (item.quantity > 1) {
                                      Get.find<CartController>()
                                          .subractQuantity(item.food,
                                              item.quantity, item.price);
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        Get.find<CartController>()
                            .remove(item.food, item.quantity, item.price);
                      });
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _height(List<CartItem> cartItems) {
    double height = 0;
    for (int i = 0; i < cartItems.length; i++) {
      height += Dimensions.height10 * 17.7;
    }
    return height;
  }

  double _totalPrice() {
    double price = 0;
    List<CartItem> cartItems = Get.find<CartController>().cartItems;
    for (var item in cartItems) {
      price += item.price;
    }
    return price;
  }
}
