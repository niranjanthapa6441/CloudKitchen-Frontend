import 'package:cloud_kitchen/Response/restaurants.dart';
import 'package:cloud_kitchen/controller/menu_by_restaurant_controller.dart';
import 'package:cloud_kitchen/controller/restaurant_controller.dart';
import 'package:cloud_kitchen/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../Response/foods.dart';
import '../../controller/food_controller.dart';
import '../../route_helper/route_helper.dart';
import '../../utils/Color/colors.dart';
import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  ScrollController scrollController = ScrollController();
  var _currentPageValue = 0.0;
  var _currentPosition = 0.0;

  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
    scrollController.addListener(() {
      setState(() {
        _currentPosition = scrollController.position as double;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
          ),
          child: Row(
            children: [BigText(text: "Popular Foods")],
          ),
        ),
        GetBuilder<FoodController>(builder: (foods) {
          return GestureDetector(
            child: foods.isLoaded
                ? Container(
                    height: Dimensions.height10 * 35,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: foods.foods.length,
                        itemBuilder: (context, index) {
                          return _buildPageItem(index, foods.foods[index]);
                        }),
                  )
                : CircularProgressIndicator.adaptive(
                    backgroundColor: Color.fromARGB(255, 3, 3, 3),
                  ),
          );
        }),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
          ),
          child: Row(
            children: [BigText(text: "Popular Restaurants")],
          ),
          height: Dimensions.height40,
        ),
        GetBuilder<RestaurantController>(builder: (restaurants) {
          return GestureDetector(
            child: restaurants.isLoaded
                ? Container(
                    height: Dimensions.height10 * 130,
                    child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: restaurants.restaurants.length,
                        itemBuilder: (context, index) {
                          return _buildPopularRestaurant(
                              index, restaurants.restaurants[index]);
                        }),
                  )
                : _buildSingleLoadingIndicator(),
          );
        }),
      ],
    );
  }

  Widget _buildPageItem(index, Foods foods) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var _currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      var matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var _currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, _currScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var _currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else {
      var _currScale = 0.8;
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1);

      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    }
    return GestureDetector(
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: Dimensions.height10 * 20,
              width: Dimensions.width10 * 200,
              margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.height10,
                  right: Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Color.fromARGB(255, 87, 76, 148),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstant.baseURL +
                      AppConstant.apiVersion +
                      foods.imagePath.toString()),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.height20 * 6,
                width: Dimensions.width10 * 32,
                margin: EdgeInsets.only(
                    left: Dimensions.height10,
                    right: Dimensions.height10,
                    bottom: Dimensions.height20),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.01),
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
                child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        left: Dimensions.height15,
                        right: Dimensions.height15),
                    child: Column(
                      children: [
                        BigText(text: foods.name.toString()),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          height: Dimensions.height10 * 3,
                          child: BigText(
                            text: foods.restaurantName.toString(),
                            color: Colors.black,
                            size: Dimensions.font10 + 2,
                          ),
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconAndTextWidget(
                                  icon: Icons.star,
                                  text: foods.rating.toString(),
                                  iconColor: AppColors.iconColor1,
                                ),
                                IconAndTextWidget(
                                  icon: Icons.timer,
                                  text: '15 mins',
                                  iconColor: AppColors.mainColor,
                                ),
                                IconAndTextWidget(
                                  icon: Icons.location_on,
                                  text: '1.5 k.m.',
                                  iconColor: AppColors.iconColor2,
                                ),
                              ]),
                        )
                      ],
                    )),
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

  Widget _buildPopularRestaurant(int index, Restaurants restaurant) {
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
                width: double.infinity,
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
