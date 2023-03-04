class RestaurantResponse {
  late String _code;
  late String _message;
  late Data _data;

  String get code => _code;

  String get message => _message;

  Data get data => _data;

  RestaurantResponse({required code, required message, required data}) {
    _code = code;
    _message = message;
    _data = data;
  }

  RestaurantResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late List<Restaurants> _restaurants;
  late int _currentPage;
  late int _totalElements;
  late int _totalPages;

  List<Restaurants> get restaurants => _restaurants;
  int get currentPage => _currentPage;
  int get totalElements => _totalElements;
  int get totalPages => _totalPages;

  Data(
      {required restaurants,
      required currentPage,
      required totalElements,
      required totalPages}) {
    _restaurants = restaurants;
    _currentPage = currentPage;
    _totalElements = totalElements;
    _totalPages = totalPages;
  }

  Data.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      _restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        _restaurants.add(Restaurants.fromJson(v));
      });
    }
    _currentPage = json['currentPage'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
  }
}

class Restaurants {
  late String _id;
  late String _name;
  late String _countryCode;
  late String _phoneNumber;
  late String _telephoneNumber;
  late String _email;
  late String _address;
  late String _status;

  String get id => _id;

  String get name => _name;

  String get countryCode => _countryCode;

  String get phoneNumber => _phoneNumber;

  String get telephoneNumber => _telephoneNumber;

  String get email => _email;

  String get address => _address;

  String get status => _status;

  Restaurants(
      {required id,
      required name,
      required countryCode,
      required phoneNumber,
      required telephoneNumber,
      required email,
      required address,
      required status}) {
    _id = id;
    _name = name;
    _countryCode = countryCode;
    _phoneNumber = phoneNumber;
    _telephoneNumber = telephoneNumber;
    _email = email;
    _address = address;
    _status = status;
  }

  Restaurants.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _countryCode = json['countryCode'];
    _phoneNumber = json['phoneNumber'];
    _telephoneNumber = json['telephoneNumber'];
    _email = json['email'];
    _address = json['address'];
    _status = json['status'];
    print("I'm here to be hones");
  }
}
