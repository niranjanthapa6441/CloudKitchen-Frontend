import 'package:cloud_kitchen/utils/api/api_client.dart';
import 'package:get/get_connect.dart';

import '../Request/login_body.dart';
import '../Request/registration_body.dart';
import '../utils/app_constants/app_constant.dart';

class AuthRepo {
  final APIClient apiClient;

  AuthRepo({required this.apiClient});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstant.registrationURI, signUpBody.toJson());
  }

  Future<Response> login(LoginBody loginBody) async {
    return await apiClient.postData(AppConstant.loginURI, loginBody.toJson());
  }

  Future<void> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
  }
}
