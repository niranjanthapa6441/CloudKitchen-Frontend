import 'package:cloud_kitchen/controller/food_controller.dart';
import 'package:cloud_kitchen/route_helper/route_helper.dart';
import 'package:cloud_kitchen/utils/color/colors.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Response/foods.dart';
import '../../utils/app_constants/app_constant.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import 'package:shimmer/shimmer.dart';

class SearchFoodPageBody extends StatefulWidget {
  const SearchFoodPageBody({super.key});

  @override
  State<SearchFoodPageBody> createState() => _SearchFoodPageBodyState();
}

class _SearchFoodPageBodyState extends State<SearchFoodPageBody> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
          Get.find<FoodController>().onClose();

    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<FoodController>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Dimensions.height10),
          child: GetBuilder<FoodController>(builder: (foods) {
            return GestureDetector(
              child: foods.isLoaded
                  ? Container(
                      height: Dimensions.height10 * 100,
                      padding: EdgeInsets.only(bottom: Dimensions.height20),
                      child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: foods.foods.length + 1,
                          itemBuilder: (context, index) {
                            if (index != foods.totalElements &&
                                index == foods.foods.length) {
                              return _buildSingleLoadingIndicator();
                            } else if (index == foods.totalElements &&
                                index == foods.foods.length) {
                              return Container();
                            }
                            return _buildSearchFoods(index, foods.foods[index]);
                          }),
                    )
                  : _buildLoadingIndicator(),
            );
          }),
        ),
        SizedBox(
          height: Dimensions.height30,
        )
      ],
    );
  }

  Widget _buildSearchFoods(int index, Foods food) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
            top: Dimensions.height5,
            bottom: Dimensions.height5,
            left: Dimensions.width10,
            right: Dimensions.width10),
        padding: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        height: Dimensions.height10 * 20,
        width: Dimensions.width20 * 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 238, 236, 236),
              blurRadius: Dimensions.radius5,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 249, 248, 248),
              offset: Offset(-5, 0),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 251, 250, 250),
              offset: Offset(5, 0),
            )
          ],
        ),
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
                        food.imagePath.toString()),
                  ),
                  color: AppColors.paraColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius10)),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    top: Dimensions.height15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: food.name.toString(),
                      size: Dimensions.font10 * 1.6,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    BigText(
                      text: food.restaurantName.toString(),
                      color: Colors.black,
                      size: Dimensions.font10 * 1.4,
                      textOverflow: TextOverflow.fade,
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    SmallText(
                      text: food.description.toString(),
                      color: Color.fromARGB(255, 77, 77, 77),
                      size: Dimensions.font10 * 1.4,
                      textOverflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      //restaurant.address.toString(),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    BigText(
                      text: "Rs: ${food.price}",
                      color: Colors.black,
                      size: Dimensions.font10 * 1.8,
                      textOverflow: TextOverflow.ellipsis,
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
                              size: Dimensions.font10 * 1.3,
                              iconColor: AppColors.iconColor1,
                            ),
                            IconAndTextWidget(
                              icon: Icons.timer,
                              text: '15 mins',
                              size: Dimensions.font10 * 1.3,
                              iconColor: AppColors.mainColor,
                            ),
                            IconAndTextWidget(
                              icon: Icons.location_on,
                              text: '1.5 k.ms',
                              size: Dimensions.font10 * 1.3,
                              iconColor: AppColors.iconColor2,
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.toNamed(RouteHelper.getFoodDetail(index));
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 62,
        child: ListView.builder(
          padding: EdgeInsets.zero,

          itemCount: 5, // You can adjust the number of shimmering cells
          itemBuilder: (_, __) => Container(
            padding: EdgeInsets.only(
                right: Dimensions.width10,
                left: Dimensions.width10,
                bottom: Dimensions.height20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height10 * 10,
                  width: Dimensions.width10 * 10,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: Dimensions.height10 * 2.4,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSingleLoadingIndicator() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 13,
        child: Container(
          padding: EdgeInsets.only(
              right: Dimensions.width10,
              left: Dimensions.width10,
              bottom: Dimensions.height20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.height10 * 10,
                width: Dimensions.width10 * 10,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: Dimensions.height10 * 2.4,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double _height(List<dynamic> foods) {
    print("foods.length" + foods.length.toString());
    double height = 0;
    for (int i = 0; i < foods!.length; i++) {
      height += Dimensions.height10 * 20;
    }

    return height;
  }
}
