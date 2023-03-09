import 'package:cloud_kitchen/repository/food_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Response/foods.dart';
import '../utils/app_constants/app_constant.dart';

class FoodController extends GetxController {
  final FoodRepo foodRepo;

  FoodController({required this.foodRepo});

  List<dynamic> _foods = [];
  List<dynamic> get foods => _foods;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;

  void setCustomerBookingDetail() {
    _foods = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;


  Future<void> get() async {
    Response response = await foodRepo.getFoods();
    if (response.statusCode == 200) {
      _foods.addAll(FoodResponse.fromJson(response.body).data.foods);
      _currentPage = FoodResponse.fromJson(response.body).data.currentPage;
      _totalElements = FoodResponse.fromJson(response.body).data.totalElements;
      _totalPages = FoodResponse.fromJson(response.body).data.totalPages;
      _isLoaded = true;
      update();
    }
  }

  Future<void> loadMore() async {
    if (_currentPage < _totalPages) {
      AppConstant.page += 1;
      AppConstant.searchFoodsURi();
      get();
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  void clear() {
    _foods.clear();
    AppConstant.page = 1;
    AppConstant.searchFoodsURi();
  }
}
