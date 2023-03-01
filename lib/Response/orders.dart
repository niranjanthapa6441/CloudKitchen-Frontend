class OrderResponse {
  String? code;
  String? message;
  Data? data;

  OrderResponse({this.code, this.message, this.data});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  late List<Orders> _orders;
  late int _currentPage;
  late int _totalElements;
  late int _totalPages;
  int get totalElements => _totalElements;
  int get currentPage => _currentPage;
  List<Orders> get orders => _orders;
  int get totalPages => _totalPages;
  Data(
      {required orders,
      required currentPage,
      required totalElements,
      required totalPages}) {
    _orders = orders;
    _totalElements = totalElements;
    _currentPage = currentPage;
    _totalPages = totalPages;
  }
  Data.fromJson(Map<String, dynamic> json) {
    if (json['menuFoods'] != null) {
      json['menuFoods'].forEach((v) {
        _orders.add(Orders.fromJson(v));
      });
    }
    _currentPage = json['currentPage'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
  }
}

class Orders {
  late String _orderId;
  late int _totalPrice;
  late int _totalItems;
  late String _orderDate;
  late String _orderTime;
  late String _status;
  late List<OrderFoods> _orderFoods;

  String get orderId => _orderId;

  int get totalPrice => _totalPrice;

  int get totalItems => _totalItems;

  String get orderDate => _orderDate;

  String get orderTime => _orderTime;

  String get status => _status;

  List<OrderFoods> get orderFoods => _orderFoods;

  Orders(
      {required orderId,
      required totalPrice,
      required totalItems,
      required orderDate,
      required orderTime,
      required status,
      required orderFoods}) {
    _orderFoods = orderFoods;
    _status = status;
    _orderDate = orderDate;
    _orderId = orderId;
    _totalItems = totalItems;
    _totalPrice = _totalPrice;
    _orderTime = orderTime;
  }

  Orders.fromJson(Map<String, dynamic> json) {
    _orderId = json['orderId'];
    _totalPrice = json['totalPrice'];
    _totalItems = json['totalItems'];
    _orderDate = json['orderDate'];
    _orderTime = json['orderTime'];
    _status = json['status'];
    if (json['orderFoods'] != null) {
      json['orderFoods'].forEach((v) {
        _orderFoods.add(OrderFoods.fromJson(v));
      });
    }
  }
}

class OrderFoods {
  late String _name;
  late int _quantity;
  late int _unitPrice;
  late int _price;

  String get name => _name;
  int get quantity => _quantity;
  int get unitPrice => _unitPrice;
  int get price => _price;

  OrderFoods(
      {required name, required quantity, required unitPrice, required price}) {
    _name = name;
    _quantity = quantity;
    _unitPrice = unitPrice;
    _price = price;
  }

  OrderFoods.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _quantity = json['quantity'];
    _unitPrice = json['unitPrice'];
    _price = json['price'];
  }
}
