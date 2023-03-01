class RestaurantMenuResponse {
  String? _code;
  String? _message;
  Data? _data;

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
  late List<Menus> _menus;
  late List<String> _categories;
  late int _currentPage;
  late int _totalElements;
  late int _totalPages;

  List<Menus> get menus => _menus;
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
      json['menus'].forEach((v) {
        _menus.add(new Menus.fromJson(v));
      });
    }
    _categories = json['categories'].cast<String>();
    _currentPage = json['currentPage'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
  }
}

class Menus {
  String? menuFoodId;
  String? name;
  String? description;
  int? rating;
  String? deliveryTime;
  String? restaurantName;
  String? restaurantAddress;
  String? category;
  int? price;
  int? discountPrice;
  String? imagePath;
  String? meal;

  Menus(
      {this.menuFoodId,
      this.name,
      this.description,
      this.rating,
      this.deliveryTime,
      this.restaurantName,
      this.restaurantAddress,
      this.category,
      this.price,
      this.discountPrice,
      this.imagePath,
      this.meal});

  Menus.fromJson(Map<String, dynamic> json) {
    menuFoodId = json['menuFoodId'];
    name = json['name'];
    description = json['description'];
    rating = json['rating'];
    deliveryTime = json['deliveryTime'];
    restaurantName = json['restaurantName'];
    restaurantAddress = json['restaurantAddress'];
    category = json['category'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    imagePath = json['imagePath'];
    meal = json['meal'];
  }
}
