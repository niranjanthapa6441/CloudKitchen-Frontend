import 'package:cloud_kitchen/utils/api/api_client.dart';
import 'package:get/get_connect.dart';

import '../utils/app_constants/app_constant.dart';

class PaymentRepo {
  final APIClient apiClient;

  PaymentRepo({required this.apiClient});

  Future<Response> getCustomerPayment() async {
    return await apiClient.getData(
        AppConstant.paymentsURI,
        apiClient.mainHeaders);
  }
}