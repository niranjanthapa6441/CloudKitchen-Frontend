import 'package:cloud_kitchen/Response/payments.dart';
import 'package:cloud_kitchen/repository/payment_repository.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Response/error_response.dart';
import '../base/show_custom_snack_bar.dart';

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
  Future<void> getCustomerPaymentDetails() async {
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
    @override
  void onClose() {
    _customerPaymentDetails.clear();
    super.onClose();
  }
  }
}
