import 'package:cloud_kitchen/Response/foods.dart';
import 'package:cloud_kitchen/controller/menu_by_restaurant_controller.dart';
import 'package:cloud_kitchen/pages/menu_by_restaurant/menu_by_restaurant_page_body.dart';
import 'package:cloud_kitchen/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../route_helper/route_helper.dart';
import '../../utils/Color/colors.dart';
import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/small_text.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({super.key});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenu> {
  ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController();
  ScrollController _categoryScrollController = ScrollController();

  var _currentPageValue = 0.0;
  var _currentPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _categoryScrollController.addListener(_setIndex);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _categoryScrollController.dispose();
    _clear();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<MenuByRestaurantController>().loadMore();
    }
  }

  PageController pageController = PageController();
  TextEditingController searchCriteria = TextEditingController();
  int _selectedIndex = 0;
  String _selectedCategory = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Menu'),
            backgroundColor: Color.fromARGB(255, 223, 123, 80),
          ),
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height10,
                right: Dimensions.width5,
                left: Dimensions.width5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 6,
                      offset: const Offset(1, 8),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      _searchFoods();
                    },
                    readOnly: false,
                    obscureText: false,
                    controller: searchCriteria,
                    decoration: InputDecoration(
                      hintText: "Search For Foods",
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.mainBlackColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        borderSide: BorderSide(width: 1.0, color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        borderSide: BorderSide(width: 1.0, color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<MenuByRestaurantController>(builder: (menus) {
                    return Container(
                      height: Dimensions.height10 * 5,
                      width: Dimensions.screenWidth,
                      child: ListView.builder(
                        controller: _categoryScrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: menus.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildCategories(
                              index, menus.categories[index]);
                        },
                      ),
                    );
                  }),
                  GetBuilder<MenuByRestaurantController>(builder: (menus) {
                    return Container(
                      height: Dimensions.height10 * 64,
                      width: Dimensions.screenWidth,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            _selectedIndex = value;
                            _selectedCategory = menus.categories[value];
                            _searchFoods();
                            _setIndex();
                          });
                        },
                        itemCount: menus.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildMenuByCategory(
                              index, menus.categories[index]);
                        },
                      ),
                    );
                  }),
                  RestaurantMenuPageBody(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(int index, String category) {
    bool isSelected = index == _selectedIndex;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          top: Dimensions.height5,
          bottom: Dimensions.height5,
          left: Dimensions.width5,
        ),
        padding: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        height: Dimensions.height10,
        decoration: BoxDecoration(
          color: !isSelected
              ? Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(255, 223, 123, 80),
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
        child: Center(
            child: BigText(
          text: category,
          size: Dimensions.font15,
          color: !isSelected ? Colors.black : Colors.white,
        )),
      ),
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _selectedCategory = category;
          _searchFoods();
          setPage(index);
        });
      },
    );
  }

  Widget _buildMenuByCategory(int index, String categori) {
    return Container(
      decoration: BoxDecoration(
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
            margin: EdgeInsets.only(top: Dimensions.height10),
            child: GetBuilder<MenuByRestaurantController>(builder: (foods) {
              return GestureDetector(
                child: foods.isLoaded
                    ? Container(
                        height: Dimensions.height10 * 62,
                        padding: EdgeInsets.only(bottom: Dimensions.height20),
                        child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: foods.menus.length + 1,
                            itemBuilder: (context, index) {
                              if (index != foods.totalElements &&
                                  index == foods.menus.length) {
                                return _buildSingleLoadingIndicator();
                              } else if (index == foods.totalElements &&
                                  index == foods.menus.length) {
                                return Container();
                              }
                              return _buildSearchFoods(
                                  index, foods.menus[index]);
                            }),
                      )
                    : _buildLoadingIndicator(),
              );
            }),
          ),
        ],
      ),
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
        height: Dimensions.height10 * 16,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.toNamed(RouteHelper.getRestaurantMenuFoodDetail(index));
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

  void _searchFoods() {
    if (_selectedIndex == 0) {
      AppConstant.category = '';
    } else {
      AppConstant.category = _selectedCategory;
    }
    AppConstant.foodName = searchCriteria.text.toString();
    Get.find<MenuByRestaurantController>().onClose();
    Get.find<MenuByRestaurantController>().get();
  }

  void _clear() {
    AppConstant.category = '';

    AppConstant.foodName = '';

    AppConstant.restaurantId = '';

    AppConstant.rating = 0.0;

    AppConstant.sortBy = '';
    Get.find<MenuByRestaurantController>().onClose();
    Get.find<MenuByRestaurantController>().categoryClear();
    Get.find<MenuByRestaurantController>().get();
  }

  void setPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void _setIndex() {
    _categoryScrollController.animateTo(pageController.page!,
        duration: const Duration(microseconds: 10), curve: Curves.easeInOut);
  }
}
