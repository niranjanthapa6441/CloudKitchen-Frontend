import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class FoodRepo {
  final APIClient apiClient;

  FoodRepo({required this.apiClient});

  Future<Response> getFoods() async {
    print(AppConstant.searchFoodsURi());
    return await apiClient.getData(
        AppConstant.searchFoodsURi(), apiClient.mainHeaders);
  }
}
