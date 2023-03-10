import 'package:cloud_kitchen/utils/api/api_client.dart';
import 'package:get/get_connect.dart';

import '../utils/app_constants/app_constant.dart';

class PaymentRepo {
  final APIClient apiClient;

  PaymentRepo({required this.apiClient});

  Future<Response> getCustomerPayment() async {
    print(AppConstant.paymentsURi());
    return await apiClient.getData(
        AppConstant.paymentsURi(), apiClient.mainHeaders);
  }
}
