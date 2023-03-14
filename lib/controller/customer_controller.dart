import 'package:cloud_kitchen/model/response_model.dart';
import 'package:get/get.dart';

import '../Request/update_profile_request.dart';
import '../Response/customer_detail.dart';
import '../repository/customer_repo.dart';

class CustomerDetailController extends GetxController {
  final CustomerDetailRepo detailRepo;

  CustomerDetailController({required this.detailRepo});
  Customer? customer;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getCustomerDetails() async {
    Response response = await detailRepo.getCustomerDetails();
    if (response.statusCode == 200) {
      _isLoaded = true;
      customer = CustomerDetailResponse.fromJson(response.body).data;
      update();
    } else {
      print(response.body["message"]);
    }
  }

  Future<ResponseModel> updateProfile(UpdateProfileRequest request) async {
    Response response = await detailRepo.updateCustomer(request);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }
} 