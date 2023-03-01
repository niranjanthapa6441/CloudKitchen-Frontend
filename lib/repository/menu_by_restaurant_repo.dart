
import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class MenuByRestaurantRepo {
  final APIClient apiClient;

  MenuByRestaurantRepo({required this.apiClient});

  Future<Response> getMenuByRestaurant() async {
    return await apiClient.getData(
        AppConstant.restaurantMenuURI,
        apiClient.mainHeaders);
  }
}