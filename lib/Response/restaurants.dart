class RestaurantResponse {
  late String _code;
  late String _message;
  late Data _data;

  String get code => _code;
  String get message => _message;
  Data get data => _data;

  RestaurantResponse({code, message, data}) {
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

  Data({restaurants, currentPage, totalElements, totalPages}) {
    _restaurants = restaurants;
    _currentPage = currentPage;
    _totalElements = totalElements;
    _totalPages = totalPages;
  }

  Data.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      _restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
    _currentPage = json['currentPage'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
  }
}

class Restaurants {
  String? id;
  String? name;
  String? countryCode;
  String? phoneNumber;
  String? telephoneNumber;
  String? email;
  String? address;
  String? status;
  String? imagePath;

  Restaurants(
      {this.id,
      this.name,
      this.countryCode,
      this.phoneNumber,
      this.telephoneNumber,
      this.email,
      this.address,
      this.status,
      this.imagePath});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    telephoneNumber = json['telephoneNumber'];
    email = json['email'];
    address = json['address'];
    status = json['status'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['telephoneNumber'] = this.telephoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['status'] = this.status;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
