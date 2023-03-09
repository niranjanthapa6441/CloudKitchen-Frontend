import 'package:cloud_kitchen/Model/response_model.dart';
import 'package:cloud_kitchen/Request/order_body.dart';
import 'package:cloud_kitchen/Response/error_response.dart';
import 'package:cloud_kitchen/Response/orders.dart';
import 'package:cloud_kitchen/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:cloud_kitchen/base/show_custom_snack_bar.dart';

import '../utils/app_constants/app_constant.dart';

class OrderController extends GetxController {
  final OrderRepository orderRepository;

  OrderController({required this.orderRepository});

  List<dynamic> _customerOrderDetails = [];
  List<dynamic> get customerOrderDetails => _customerOrderDetails;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;
  void setCustomerBookingDetail() {
    _customerOrderDetails = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await orderRepository.getCustomerOrderDetails();
    if (response.statusCode == 200) {
      _customerOrderDetails
          .addAll(OrderResponse.fromJson(response.body).data.orders);
      _currentPage = OrderResponse.fromJson(response.body).data.currentPage;
      _totalElements = OrderResponse.fromJson(response.body).data.totalElements;
      _totalPages = OrderResponse.fromJson(response.body).data.totalPages;
      _isLoaded = true;
      update();
    } else {
      Response response = await orderRepository.getCustomerOrderDetails();
      ErrorResponse error = ErrorResponse.fromJson(response.body);
      showCustomSnackBar(error.message, title: "orders");
    }
  }

  Future<ResponseModel> save(OrderRequest request) async {
    Response response = await orderRepository.orderFoods(request);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
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
    _customerOrderDetails.clear();
    AppConstant.page = 1;
    AppConstant.searchFoodsURi();
  }
}
