import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class RestaurantRepo {
  final APIClient apiClient;

  RestaurantRepo({required this.apiClient});

  Future<Response> getRestaurants() async {
    print("restaurantUri" + AppConstant.restaurantURi());
    return await apiClient.getData(
        AppConstant.restaurantURi(), apiClient.mainHeaders);
  }
}
