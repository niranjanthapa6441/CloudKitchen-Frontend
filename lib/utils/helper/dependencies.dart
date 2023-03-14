import 'package:cloud_kitchen/controller/auth_controller.dart';
import 'package:cloud_kitchen/controller/cart_controller.dart';
import 'package:cloud_kitchen/controller/customer_controller.dart';
import 'package:cloud_kitchen/controller/food_controller.dart';
import 'package:cloud_kitchen/controller/menu_by_restaurant_controller.dart';
import 'package:cloud_kitchen/controller/order_controller.dart';
import 'package:cloud_kitchen/controller/payment_controller.dart';
import 'package:cloud_kitchen/repository/auth_repository.dart';
import 'package:cloud_kitchen/repository/customer_repo.dart';
import 'package:cloud_kitchen/repository/food_repo.dart';
import 'package:cloud_kitchen/repository/menu_by_restaurant_repo.dart';
import 'package:cloud_kitchen/repository/order_repository.dart';
import 'package:cloud_kitchen/repository/payment_repository.dart';
import 'package:cloud_kitchen/repository/restaurant_repo.dart';
import 'package:cloud_kitchen/utils/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../controller/restaurant_controller.dart';
import '../app_constants/app_constant.dart';

Future<void> init() async {
  final sharedPreferences = SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => APIClient(appBaseUrl: AppConstant.baseURL));

  //repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find()));
  Get.lazyPut(() => FoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => MenuByRestaurantRepo(apiClient: Get.find()));
  Get.lazyPut(() => PaymentRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepository(apiClient: Get.find()));
  Get.lazyPut(() => RestaurantRepo(apiClient: Get.find()));
  Get.lazyPut(() => CustomerDetailRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => FoodController(foodRepo: Get.find()));
  Get.lazyPut(
      () => MenuByRestaurantController(menuByRestaurantRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepository: Get.find()));
  Get.lazyPut(() => PaymentController(paymentRepo: Get.find()));
  Get.lazyPut(() => RestaurantController(restaurantRepo: Get.find()));
  Get.lazyPut(() => CartController());
  Get.lazyPut(() => CustomerDetailController(detailRepo: Get.find()));
}
