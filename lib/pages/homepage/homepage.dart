import 'package:cloud_kitchen/pages/homepage/homepage_body.dart';
import 'package:cloud_kitchen/route_helper/route_helper.dart';
import 'package:cloud_kitchen/utils/color/colors.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:cloud_kitchen/widgets/big_text.dart';
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
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height50, bottom: Dimensions.height10),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Container(
                      child: BigText(
                        text:
                            '2, PuranoNaikap, Kathmandu, BagmatiProvince, Nepal',
                        textOverflow: TextOverflow.ellipsis,
                        size: Dimensions.font15,
                        color: Color.fromARGB(255, 137, 136, 136),
                      ),
                      width: Dimensions.width10 * 25,
                    )
                  ]),
                  height: Dimensions.height30,
                  width: Dimensions.width300,
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.getCart());
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    size: Dimensions.height30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.height10),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: Dimensions.width10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: AppColors.mainBlackColor,
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            SmallText(
                              text: "Search For Foods or Restaurants",
                              size: Dimensions.font15,
                              color: AppColors.mainBlackColor,
                            )
                          ],
                        ),
                        height: Dimensions.height50,
                        width: Dimensions.width10 * 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 6,
                                  offset: Offset(1, 8),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getSearchFoods());
                      },
                    )
                  ],
                ),
              ],
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
