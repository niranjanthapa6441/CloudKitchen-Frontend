import 'package:cloud_kitchen/pages/cart/cart_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../../route_helper/route_helper.dart';
import '../../utils/app_constants/app_constant.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Cart'),
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
            leading: !AppConstant.toCart
                ? BackButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.getNavigation());
                      AppConstant.toCart = false;
                    },
                  )
                : BackButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.getFoodDetail(AppConstant.foodId));
                      AppConstant.toCart = false;
                    },
                  ),
          ),
          Container(
              child: Expanded(
                  child: SingleChildScrollView(child: CartPageBody()))),
        ],
      ),
    );
  }
}
