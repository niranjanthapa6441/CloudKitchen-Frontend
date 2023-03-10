import 'package:cloud_kitchen/Response/restaurants.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Response/error_response.dart';
import '../base/show_custom_snack_bar.dart';
import '../repository/restaurant_repo.dart';
import '../utils/app_constants/app_constant.dart';

class RestaurantController extends GetxController {
  final RestaurantRepo restaurantRepo;

  RestaurantController({required this.restaurantRepo});

  List<dynamic> _restaurants = [];
  List<dynamic> get restaurants => _restaurants;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;
  void setRestaurants() {
    _restaurants = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await restaurantRepo.getRestaurants();
    if (response.statusCode == 200) {
      _restaurants
          .addAll(RestaurantResponse.fromJson(response.body).data.restaurants);
      _currentPage =
          RestaurantResponse.fromJson(response.body).data.currentPage;
      _totalElements =
          RestaurantResponse.fromJson(response.body).data.totalElements;
      _totalPages = RestaurantResponse.fromJson(response.body).data.totalPages;
      _isLoaded = true;

      update();
    } 
  }

  Future<void> loadMore() async {
    if (_currentPage < _totalPages) {
      AppConstant.page += 1;
      AppConstant.restaurantURi();
      get();
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  void clear() {
    _restaurants.clear();
    AppConstant.page = 1;
    AppConstant.restaurantURi();
  }
}
