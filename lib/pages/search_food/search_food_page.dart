import 'package:cloud_kitchen/pages/search_food/search_food_page_body.dart';
import 'package:cloud_kitchen/utils/app_constants/app_constant.dart';
import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../controller/food_controller.dart';
import '../../utils/Color/colors.dart';

class SearchFoodPage extends StatefulWidget {
  const SearchFoodPage({super.key});

  @override
  State<SearchFoodPage> createState() => _SearchFoodPageState();
}

class _SearchFoodPageState extends State<SearchFoodPage> {
  var searchCriteria = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _clear();
    super.dispose();
  }

  String categoryDropDownValue = '';
  String restaurantDropDownValue = '';
  String mealDropDownValue = '';
  String priceDropDownValue = '';
  String ratingDropDownValue = '';

  bool categorySelection = false;
  bool restaurantSelection = false;
  bool priceSelection = false;
  bool ratingSelection = false;
  bool isSearching = false;

  List<String> restaurants = [
    'AT Burger House and Crunchy Fried Chicken',
    'American Express',
    'Fatis Biryani'
  ];
  List<String> category = ['Mo : Mo', 'Pizza', 'Burger', 'Biryani'];
  List<String> sortBy = ['low to high', 'high to low'];
  List<String> rating = ['3.0', '3.5', '4.0', '4.5'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: const Color.fromARGB(255, 223, 123, 80),
            title: const Text("Search Foods"),
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
                      isSearching = true;
                      _searchFoods();
                    },
                    readOnly: false,
                    obscureText: false,
                    controller: searchCriteria,
                    decoration: InputDecoration(
                      hintText: "Search For Foods or Restaurant",
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
          Container(
            margin: EdgeInsets.only(
                right: Dimensions.width5, left: Dimensions.width5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  height: Dimensions.height10 * 5,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width5, right: Dimensions.width5),
                        height: Dimensions.height10 * 4,
                        width: Dimensions.width10 * 9.25,
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
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width5,
                              right: Dimensions.width5),
                          child: Center(
                            child: DropdownButton<String>(
                              elevation: 16,
                              style: TextStyle(color: AppColors.mainBlackColor),
                              underline: null,
                              icon: null,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  categoryDropDownValue = newValue!;
                                  categorySelection = true;
                                });
                                _searchFoods();
                              },
                              items: category.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: categorySelection
                                  ? Text(categoryDropDownValue.toString())
                                  : const Text("Category"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  height: Dimensions.height10 * 5,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width5, right: Dimensions.width5),
                        height: Dimensions.height10 * 4,
                        width: Dimensions.width10 * 7.5,
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
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width5,
                              right: Dimensions.width5),
                          child: Center(
                            child: DropdownButton<String>(
                              elevation: 16,
                              style: TextStyle(color: AppColors.mainBlackColor),
                              underline: null,
                              icon: null,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  ratingDropDownValue = newValue!;
                                  ratingSelection = true;
                                });
                                _searchFoods();
                              },
                              items: rating.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: ratingSelection
                                  ? Text(ratingDropDownValue.toString())
                                  : Text("Rating"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  height: Dimensions.height10 * 5,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width5, right: Dimensions.width5),
                        height: Dimensions.height10 * 4,
                        width: Dimensions.width10 * 7.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 6,
                                  offset: Offset(1, 8),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width5,
                              right: Dimensions.width5),
                          child: Center(
                            child: DropdownButton<String>(
                              elevation: 16,
                              style: TextStyle(color: AppColors.mainBlackColor),
                              underline: null,
                              icon: null,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  priceDropDownValue = newValue!;
                                  priceSelection = true;
                                });
                                _searchFoods();
                              },
                              items: sortBy.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: priceSelection
                                  ? Text(priceDropDownValue.toString())
                                  : Text("Price"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  height: Dimensions.height10 * 5,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width5, right: Dimensions.width5),
                        height: Dimensions.height10 * 4,
                        width: Dimensions.width10 * 11,
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
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width5,
                              right: Dimensions.width5),
                          child: Center(
                            child: DropdownButton<String>(
                              elevation: 16,
                              style: TextStyle(color: AppColors.mainBlackColor),
                              icon: null,
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  restaurantDropDownValue = newValue!;
                                  restaurantSelection = true;
                                });
                                _searchFoods();
                              },
                              items: restaurants.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: restaurantSelection
                                  ? Text(restaurantDropDownValue.toString())
                                  : Text("Restaurants"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
                  child: SingleChildScrollView(child: SearchFoodPageBody()))
        ],
      ),
    );
  }

  void _searchFoods() {

    AppConstant.category = categoryDropDownValue;

    AppConstant.foodName = searchCriteria.text.toString();

    if (ratingDropDownValue != '') {
      AppConstant.rating = double.parse(ratingDropDownValue.trim());
    }

    if (priceDropDownValue.toLowerCase() == 'low to high') {
      AppConstant.sortBy = 'price';
    } else if (priceDropDownValue.toLowerCase() == 'high to low') {
      AppConstant.sortBy = '-price';
    }
    AppConstant.restaurantName = restaurantDropDownValue;
    Get.find<FoodController>().onClose();
    Get.find<FoodController>().get();
    isSearching = false;
  }

  void _clear() {
    AppConstant.category = '';

    AppConstant.foodName = '';

    AppConstant.rating = 0.0;

    AppConstant.sortBy = '';
    AppConstant.restaurantName = '';
    Get.find<FoodController>().onClose();
    Get.find<FoodController>().get();
  }

}
