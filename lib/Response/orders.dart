class OrderResponse {
  late String _code;
  late String _message;
  late Data _data;
  Data get data => _data;
  String get messsage => _message;
  String get code => _code;


  OrderResponse({required code, required message, required data}) {
    _code = code;
    _message = message;
    _data = data;
  }

  OrderResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late int _totalPages;
  late List<Orders> _orders;
  late int _currentPage;
  late int _totalElements;

  List<Orders> get orders => _orders;
  int get currentPage => _currentPage;
  int get totalElements => _totalElements;
  int get totalPages => _totalPages;

  Data(
      {required totalPages,
      required orders,
      required currentPage,
      required totalElements}) {
    _totalElements = totalElements;
    _orders = orders;
    _totalPages = totalPages;
    _currentPage = currentPage;
  }

  Data.fromJson(Map<String, dynamic> json) {
    _totalPages = json['totalPages'];
    if (json['orders'] != null) {
      _orders = <Orders>[];
      json['orders'].forEach((v) {
        _orders.add(Orders.fromJson(v));
      });
    }
    _currentPage = json['currentPage'];
    _totalElements = json['totalElements'];
  }
}

class Orders {
  String? orderId;
  double? totalPrice;
  int? totalItems;
  String? orderDate;
  String? orderTime;
  String? status;
  List<OrderFoods>? orderFoods;

  Orders(
      {this.orderId,
      this.totalPrice,
      this.totalItems,
      this.orderDate,
      this.orderTime,
      this.status,
      this.orderFoods});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    totalPrice = json['totalPrice'];
    totalItems = json['totalItems'];
    orderDate = json['orderDate'];
    orderTime = json['orderTime'];
    status = json['status'];
    if (json['orderFoods'] != null) {
      orderFoods = <OrderFoods>[];
      json['orderFoods'].forEach((v) {
        orderFoods!.add(OrderFoods.fromJson(v));
      });
    }
  }
}

class OrderFoods {
  String? name;
  int? quantity;
  double? unitPrice;
  double? price;

  OrderFoods({this.name, this.quantity, this.unitPrice, this.price});

  OrderFoods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    price = json['price'];
  }
}
