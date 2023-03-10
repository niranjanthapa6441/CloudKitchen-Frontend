import 'package:cloud_kitchen/repository/menu_by_restaurant_repo.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Response/error_response.dart';
import '../Response/restaurant_menu.dart';
import '../base/show_custom_snack_bar.dart';
import '../utils/app_constants/app_constant.dart';

class MenuByRestaurantController extends GetxController {
  final MenuByRestaurantRepo menuByRestaurantRepo;

  MenuByRestaurantController({required this.menuByRestaurantRepo});

  List<dynamic> _menus = [];
  List<dynamic> get menus => _menus;
  List<String> _categories = ['All'];
  List<String> get categories => _categories;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;
  void setMenus() {
    _menus = [];
  }

  void setCategories() {
    _categories = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await menuByRestaurantRepo.getMenuByRestaurant();
    if (response.statusCode == 200) {
      _isLoaded = true;
      _menus.addAll(RestaurantMenuResponse.fromJson(response.body).data.menus);
    if (_categories.length == 1) {
      _categories.addAll(
          RestaurantMenuResponse.fromJson(response.body).data.categories);
      }
      _currentPage =
          RestaurantMenuResponse.fromJson(response.body).data.currentPage;
      _totalElements =
          RestaurantMenuResponse.fromJson(response.body).data.totalElements;
      _totalPages =
          RestaurantMenuResponse.fromJson(response.body).data.totalPages;
      update();
    }
  }

  Future<void> loadMore() async {
    if (_currentPage < _totalPages) {
      AppConstant.page += 1;
      AppConstant.restaurantMenuURi();
      get();
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  void clear() {
    _menus.clear();
    AppConstant.page = 1;
    AppConstant.restaurantMenuURi();
  }

  void categoryClear() {
    _categories.clear();
    _categories.add('All');
  }
}
