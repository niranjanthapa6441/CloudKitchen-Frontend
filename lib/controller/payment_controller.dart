import 'package:cloud_kitchen/Response/payments.dart';
import 'package:cloud_kitchen/repository/payment_repository.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Response/error_response.dart';
import '../base/show_custom_snack_bar.dart';
import '../utils/app_constants/app_constant.dart';

class PaymentController extends GetxController {
  final PaymentRepo paymentRepo;

  PaymentController({required this.paymentRepo});

  List<dynamic> _customerPaymentDetails = [];
  List<dynamic> get customerPaymentDetails => _customerPaymentDetails;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;
  void setCustomerBookingDetail() {
    _customerPaymentDetails = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await paymentRepo.getCustomerPayment();
    if (response.statusCode == 200) {
      _customerPaymentDetails
          .addAll(PaymentResponse.fromJson(response.body).data.payments);
      _currentPage = PaymentResponse.fromJson(response.body).data.currentPage;
      _totalElements =
          PaymentResponse.fromJson(response.body).data.totalElements;
      _totalPages = PaymentResponse.fromJson(response.body).data.totalPages;
      _isLoaded = true;

      update();
    } else {
      Response response = await paymentRepo.getCustomerPayment();
      ErrorResponse error = ErrorResponse.fromJson(response.body);
      showCustomSnackBar(error.message, title: "Payments");
    }
  }

  Future<void> loadMore() async {
    if (_currentPage < _totalPages) {
      AppConstant.page += 1;
      AppConstant.ordersURi();
      get();
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  void clear() {
    _customerPaymentDetails.clear();
    AppConstant.page = 1;
    AppConstant.searchFoodsURi();
  }
}
