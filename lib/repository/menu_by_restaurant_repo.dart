import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class MenuByRestaurantRepo {
  final APIClient apiClient;

  MenuByRestaurantRepo({required this.apiClient});

  Future<Response> getMenuByRestaurant() async {
    print("AppConstants" + AppConstant.restaurantMenuURi());
    return await apiClient.getData(
        AppConstant.restaurantMenuURi(), apiClient.mainHeaders);
  }
}
