import 'package:cloud_kitchen/Model/response_model.dart';
import 'package:cloud_kitchen/Request/order_body.dart';
import 'package:cloud_kitchen/Response/error_response.dart';
import 'package:cloud_kitchen/Response/orders.dart';
import 'package:cloud_kitchen/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:cloud_kitchen/base/show_custom_snack_bar.dart';

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
  Future<void> getCustomerBookingDetails() async {
    Response response = await orderRepository.getCustomerOrderDetails();
    if (response.statusCode == 200) {
      _isLoaded = true;
      _customerOrderDetails
          .addAll(OrderResponse.fromJson(response.body).data.orders);
      _currentPage = OrderResponse.fromJson(response.body).data.currentPage;
      _totalElements = OrderResponse.fromJson(response.body).data.totalElements;
      _totalPages = OrderResponse.fromJson(response.body).data.totalPages;
      update();
    } else {
      Response response = await orderRepository.getCustomerOrderDetails();
      ErrorResponse error= ErrorResponse.fromJson(response.body);
      showCustomSnackBar(error.message,title:"orders");
    }
  }

  Future<ResponseModel> saveBookingDetails(OrderRequest request) async {
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
}