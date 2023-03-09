import 'package:cloud_kitchen/Request/order_body.dart';
import 'package:cloud_kitchen/utils/api/api_client.dart';
import 'package:cloud_kitchen/utils/app_constants/app_constant.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrderRepository extends GetxService {
  final APIClient apiClient;
  OrderRepository({required this.apiClient});

  Future<Response> getCustomerOrderDetails() async {
    return await apiClient.getData(
        AppConstant.ordersURI,
        apiClient.mainHeaders);
  }

  Future<Response> orderFoods(OrderRequest request) async {
    return await apiClient.postData(
        AppConstant.saveOrderURI, request.toJson());
  }
}