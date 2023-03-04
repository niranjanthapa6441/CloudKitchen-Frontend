import 'package:cloud_kitchen/repository/food_repo.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Response/error_response.dart';
import '../Response/foods.dart';
import '../base/show_custom_snack_bar.dart';

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
  Future<void> getFoodDetails() async {
    Response response = await foodRepo.getFoods();
    if (response.statusCode == 200) {
      _isLoaded = true;
      _foods.addAll(FoodResponse.fromJson(response.body).data.foods);
      _currentPage = FoodResponse.fromJson(response.body).data.currentPage;
      _totalElements = FoodResponse.fromJson(response.body).data.totalElements;
      _totalPages = FoodResponse.fromJson(response.body).data.totalPages;
      update();
    }
  }
}
