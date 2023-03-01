import 'package:cloud_kitchen/repository/auth_repository.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Model/response_model.dart';
import '../Request/login_body.dart';
import '../Request/registration_body.dart';
import '../Response/error_response.dart';
import '../Response/login_response.dart';
import '../utils/app_constants/app_constant.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
  final List<dynamic> _customerRegistrationDetails = [];
  List<dynamic> get customerRegistrationDetails => _customerRegistrationDetails;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late LogInResponseModel details;
  late ErrorResponse errorDetails;
  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> login(LoginBody loginBody) async {
    _isLoading = true;
    Response response = await authRepo.login(loginBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      details = LogInResponseModel.fromJson(response.body);
      responseModel = ResponseModel(true, response.body["message"]);
      authRepo.saveUserToken(details.data!.accessToken.toString());
      AppConstant.userId = details.data!.customerId!;
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }
}
