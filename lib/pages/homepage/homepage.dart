import 'package:cloud_kitchen/pages/homepage/homepage_body.dart';
import 'package:cloud_kitchen/pages/orders/orders_page.dart';
import 'package:cloud_kitchen/pages/payment_details/payment_details_page.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:cloud_kitchen/widgets/icon_and_text_widget.dart';
import 'package:flutter/material.dart';

import '../profile/profile_page.dart';
import '../search_food/search_food_page.dart';

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
