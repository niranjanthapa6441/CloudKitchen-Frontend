import 'package:cloud_kitchen/Response/foods.dart';

class RestaurantMenuResponse {
  late String _code;
  late String _message;
  late Data _data;
  String get code => _code;

  String get message => _message;

  Data get data => _data;

  RestaurantMenuResponse({required code, required message, required data}) {
    _code = code;
    _message = message;
    _data = data;
  }

  RestaurantMenuResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late List<Foods> _menus;
  late List<String> _categories;
  late int _currentPage;
  late int _totalElements;
  late int _totalPages;

  List<Foods> get menus => _menus;
  List<String> get categories => _categories;
  int get currentPage => _currentPage;
  int get totalElements => _totalElements;
  int get totalPages => _totalPages;

  Data(
      {required menus,
      required categories,
      required currentPage,
      required totalElements,
      required totalPages}) {
    _menus = menus;
    _categories = categories;
    _totalElements = totalElements;
    _currentPage = currentPage;
    _totalPages = totalPages;
  }

  Data.fromJson(Map<String, dynamic> json) {
    if (json['menus'] != null) {
      _menus = <Foods>[];
      json['menus'].forEach((v) {
        _menus.add(Foods.fromJson(v));
      });
    }
    _categories = json['categories'].cast<String>();
    _currentPage = json['currentPage'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
  }
}
