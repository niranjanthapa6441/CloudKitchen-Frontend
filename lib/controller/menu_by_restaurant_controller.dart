import 'package:cloud_kitchen/repository/menu_by_restaurant_repo.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Response/error_response.dart';
import '../Response/restaurant_menu.dart';
import '../base/show_custom_snack_bar.dart';

class MenuByRestaurantController extends GetxController {
  final MenuByRestaurantRepo menuByRestaurantRepo;

  MenuByRestaurantController({required this.menuByRestaurantRepo});

  List<dynamic> _menus = [];
  List<dynamic> get menus => _menus;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;
  void setCustomerBookingDetail() {
    _menus = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getCustomerBookingDetails() async {
    Response response = await menuByRestaurantRepo.getMenuByRestaurant();
    if (response.statusCode == 200) {
      _isLoaded = true;
      _menus
          .addAll(RestaurantMenuResponse.fromJson(response.body).data.menus);
      _currentPage = RestaurantMenuResponse.fromJson(response.body).data.currentPage;
      _totalElements = RestaurantMenuResponse.fromJson(response.body).data.totalElements;
      _totalPages = RestaurantMenuResponse.fromJson(response.body).data.totalPages;
      update();
    } else {
      Response response = await menuByRestaurantRepo.getMenuByRestaurant();
      ErrorResponse error= ErrorResponse.fromJson(response.body);
      showCustomSnackBar(error.message,title:"Menu By Restaurants");
    }
  }
}
