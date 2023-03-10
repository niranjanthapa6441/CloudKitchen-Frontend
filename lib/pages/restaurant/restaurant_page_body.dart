import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../Response/restaurants.dart';
import '../../controller/menu_by_restaurant_controller.dart';
import '../../controller/restaurant_controller.dart';
import '../../route_helper/route_helper.dart';
import '../../utils/Color/colors.dart';
import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class RestaurantPageBody extends StatefulWidget {
  const RestaurantPageBody({super.key});

  @override
  State<RestaurantPageBody> createState() => _RestaurantPageBodyState();
}

class _RestaurantPageBodyState extends State<RestaurantPageBody> {
  ScrollController _scrollController = ScrollController();
  var _currentPageValue = 0.0;
  var _currentPosition = 0.0;

  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<RestaurantController>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Dimensions.height10),
          child: GetBuilder<RestaurantController>(builder: (restaurants) {
            return GestureDetector(
              child: restaurants.isLoaded
                  ? Container(
                      height: Dimensions.height10 * 57,
                      padding: EdgeInsets.only(bottom: Dimensions.height20),
                      child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: restaurants.restaurants.length + 1,
                          itemBuilder: (context, index) {
                            if (index != restaurants.totalElements &&
                                index == restaurants.restaurants.length) {
                              return _buildSingleLoadingIndicator();
                            } else if (index == restaurants.totalElements &&
                                index == restaurants.restaurants.length) {
                              return Container();
                            }
                            return _buildRestaurant(
                                index, restaurants.restaurants[index]);
                          }),
                    )
                  : _buildLoadingIndicator(),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRestaurant(int index, Restaurants restaurant) {
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
        height: Dimensions.height10 * 25,
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
        child: Column(
          children: [
            Container(
              height: Dimensions.height10 * 15,
              width: Dimensions.width20 * 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstant.baseURL +
                        AppConstant.apiVersion +
                        restaurant.imagePath.toString()),
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius10)),
            ),
            Expanded(
              child: Container(
                width: Dimensions.width20 * 20,
                padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    top: Dimensions.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: restaurant.name.toString(),
                      size: Dimensions.font10 * 1.5,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(
                      text: restaurant.address.toString(),
                      color: Colors.black,
                      size: Dimensions.font10 * 1.3,
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
                              text: '4.0',
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        AppConstant.restaurantId = restaurant.id.toString();
        Get.find<MenuByRestaurantController>().clear();
        Get.find<MenuByRestaurantController>().get();
        Get.toNamed(RouteHelper.getRestaurantMenu());
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
            itemBuilder: (_, __) => _buildSingleLoadingIndicator()),
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
        height: Dimensions.height10 * 25,
        child: Container(
          padding: EdgeInsets.only(
              right: Dimensions.width10,
              left: Dimensions.width10,
              bottom: Dimensions.height20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.height10 * 15,
                width: Dimensions.width20 * 20,
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
