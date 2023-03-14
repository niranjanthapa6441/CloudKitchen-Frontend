import 'package:get/get.dart';
import '../Request/update_profile_request.dart';
import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class CustomerDetailRepo extends GetxService {
  final APIClient apiClient;
  CustomerDetailRepo({required this.apiClient});

  Future<Response> getCustomerDetails() async {
    return await apiClient.getData(
        AppConstant.profileURI,
        apiClient.mainHeaders);
  }

  Future<Response> updateCustomer(UpdateProfileRequest request) async {
    print(request.firstName);
    return await apiClient.put(
        AppConstant.userURI + AppConstant.userId, request.toJson(),
        headers: apiClient.mainHeaders);
  }
}
